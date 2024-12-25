using Microsoft.AspNetCore.Authentication;
using Ocelot.Configuration;
using Ocelot.Logging;
using Ocelot.Middleware;
using AuthenticationOptions = Ocelot.Configuration.AuthenticationOptions;

#pragma warning disable CS0618 // 类型或成员已过时

namespace EIS.GateWay.Middleware
{
    /// <summary>
    /// 自定义认证中间件
    /// </summary>
    public sealed class CustomAuthenticationMiddleware : OcelotMiddleware
    {
        private readonly RequestDelegate _next;

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="next"></param>
        /// <param name="loggerFactory"></param>
        public CustomAuthenticationMiddleware(RequestDelegate next, IOcelotLoggerFactory loggerFactory)
            : base(loggerFactory.CreateLogger<CustomAuthenticationMiddleware>())
        {
            _next = next;
        }

        /// <summary>
        /// 中间件触发
        /// </summary>
        /// <param name="httpContext"></param>
        public async Task Invoke(HttpContext httpContext)
        {
            var request = httpContext.Request;
            var path = httpContext.Request.Path;
            var downstreamRoute = httpContext.Items.DownstreamRoute();

            // reducing nesting, returning early when no authentication is needed.
            if (request.Method.Equals("OPTIONS", StringComparison.OrdinalIgnoreCase)
                || !downstreamRoute.IsAuthenticated
                || (path.Value?.Contains("swagger", StringComparison.OrdinalIgnoreCase) ?? false)
                || (path.Value?.Contains("health", StringComparison.OrdinalIgnoreCase) ?? false))
            {
                Logger.LogInformation($"No authentication needed for path '{path}'.");
                await _next(httpContext);
                return;
            }

            Logger.LogInformation(() =>
                $"The path '{path}' is an authenticated route! {MiddlewareName} checking if client is authenticated...");

            var result = await AuthenticateAsync(httpContext, downstreamRoute);

            if (result.Principal?.Identity == null)
            {
                SetUnauthenticatedError(httpContext, path, "");
                return;
            }

            httpContext.User = result.Principal;

            if (httpContext.User.Identity.IsAuthenticated)
            {
                Logger.LogInformation(() =>
                    $"Client has been authenticated for path '{path}' by '{httpContext.User.Identity.AuthenticationType}' scheme.");
                await _next.Invoke(httpContext);
                return;
            }

            SetUnauthenticatedError(httpContext, path, httpContext.User.Identity.Name ?? "");
        }

        /// <summary>
        /// 设置未授权错误信息
        /// </summary>
        /// <param name="httpContext"></param>
        /// <param name="path"></param>
        /// <param name="userName"></param>
        private void SetUnauthenticatedError(HttpContext httpContext, string path, string userName)
        {
            var error = new UnauthenticatedError(
                $"Request for authenticated route '{path}' {(string.IsNullOrEmpty(userName) ? "was unauthenticated" : $"by '{userName}' was unauthenticated!")}");
            Logger.LogWarning(() =>
                $"Client has NOT been authenticated for path '{path}' and pipeline error set. {error};");
            httpContext.Items.SetError(error);
        }

        /// <summary>
        /// 权限验证
        /// </summary>
        /// <param name="context"></param>
        /// <param name="route"></param>
        /// <returns></returns>
        private async Task<AuthenticateResult> AuthenticateAsync(HttpContext context, DownstreamRoute route)
        {
            var options = route.AuthenticationOptions;
            if (!string.IsNullOrWhiteSpace(options.AuthenticationProviderKey))
            {
                return await context.AuthenticateAsync(options.AuthenticationProviderKey);
            }

            var providerKeys = options.AuthenticationProviderKeys;
            if (providerKeys.Length == 0 || providerKeys.All(string.IsNullOrWhiteSpace))
            {
                Logger.LogWarning(() =>
                    $"Impossible to authenticate client for path '{route.DownstreamPathTemplate}': both {nameof(options.AuthenticationProviderKey)} and {nameof(options.AuthenticationProviderKeys)} are empty but the {nameof(AuthenticationOptions)} have defined.");
                return AuthenticateResult.NoResult();
            }

            AuthenticateResult? result = null;
            foreach (var scheme in providerKeys.Where(apk => !string.IsNullOrWhiteSpace(apk)))
            {
                try
                {
                    result = await context.AuthenticateAsync(scheme);
                    if (result.Succeeded)
                    {
                        return result;
                    }
                }
                catch (Exception e)
                {
                    Logger.LogWarning(() =>
                        $"Impossible to authenticate client for path '{route.DownstreamPathTemplate}' and {nameof(options.AuthenticationProviderKey)}:{scheme}. Error: {e.Message}.");
                }
            }

            return result ?? AuthenticateResult.NoResult();
        }
    }
}