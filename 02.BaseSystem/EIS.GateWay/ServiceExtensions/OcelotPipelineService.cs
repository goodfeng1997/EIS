using EIS.GateWay.Middleware;
using Ocelot.Authorization.Middleware;
using Ocelot.Cache.Middleware;
using Ocelot.Claims.Middleware;
using Ocelot.DownstreamPathManipulation.Middleware;
using Ocelot.DownstreamRouteFinder.Middleware;
using Ocelot.DownstreamUrlCreator.Middleware;
using Ocelot.Errors.Middleware;
using Ocelot.Headers.Middleware;
using Ocelot.LoadBalancer.Middleware;
using Ocelot.Middleware;
using Ocelot.Multiplexer;
using Ocelot.QueryStrings.Middleware;
using Ocelot.RateLimit.Middleware;
using Ocelot.Request.Middleware;
using Ocelot.Requester.Middleware;
using Ocelot.RequestId.Middleware;
using Ocelot.Responder.Middleware;
using Ocelot.Security.Middleware;
using Ocelot.WebSockets;

namespace EIS.GateWay.ServiceExtensions;

/// <summary>
/// ocelot管道服务
/// </summary>
public static class OcelotPipelineService
{
    /// <summary>
    /// 构建自定义Ocelot管道
    /// </summary>
    /// <param name="app"></param>
    /// <param name="pipelineConfiguration"></param>
    /// <returns></returns>
    public static RequestDelegate BuildCustomOcelotPipeline(this IApplicationBuilder app,
        OcelotPipelineConfiguration pipelineConfiguration)
    {
        // this sets up the downstream context and gets the config
        app.UseDownstreamContextMiddleware();

        app.UseExceptionHandlerMiddleware();

        // If the request is for websockets upgrade we fork into a different pipeline
        app.MapWhen(httpContext => httpContext.WebSockets.IsWebSocketRequest,
            wenSocketsApp =>
            {
                wenSocketsApp.UseDownstreamRouteFinderMiddleware();
                wenSocketsApp.UseMultiplexingMiddleware();
                wenSocketsApp.UseDownstreamRequestInitialiser();
                wenSocketsApp.UseLoadBalancingMiddleware();
                wenSocketsApp.UseDownstreamUrlCreatorMiddleware();
                wenSocketsApp.UseWebSocketsProxyMiddleware();
            });

        // Allow the user to respond with absolutely anything they want.
        app.UseIfNotNull(pipelineConfiguration.PreErrorResponderMiddleware);

        app.UseResponderMiddleware();

        // Then we get the downstream route information
        app.UseDownstreamRouteFinderMiddleware();

        // Multiplex the request if required
        app.UseMultiplexingMiddleware();

        // This security module, IP whitelist blacklist, extended security mechanism
        app.UseSecurityMiddleware();

        //Expand other branch pipes
        if (pipelineConfiguration.MapWhenOcelotPipeline != null)
        {
            foreach (var pipeline in pipelineConfiguration.MapWhenOcelotPipeline)
            {
                // todo why is this asking for an app app?
                app.MapWhen(pipeline.Key, pipeline.Value);
            }
        }

        // Now we have the ds route we can transform headers and stuff?
        app.UseHttpHeadersTransformationMiddleware();

        // Initialises downstream request
        app.UseDownstreamRequestInitialiser();

        app.UseRateLimiting();

        app.UseRequestIdMiddleware();

        app.UseIfNotNull(pipelineConfiguration.PreAuthenticationMiddleware);

        if (pipelineConfiguration.AuthenticationMiddleware == null)
        {
            app.UseMiddleware<CustomAuthenticationMiddleware>();
            //app.UseAuthenticationMiddleware();
        }
        else
        {
            app.Use(pipelineConfiguration.AuthenticationMiddleware);
        }

        app.UseClaimsToClaimsMiddleware();

        app.UseIfNotNull(pipelineConfiguration.PreAuthorizationMiddleware);

        // Now we have authenticated and done any claims transformation we
        // can authorize the request
        // We allow the ocelot middleware to be overriden by whatever the
        // user wants
        if (pipelineConfiguration.AuthorizationMiddleware == null)
        {
            app.UseAuthorizationMiddleware();
        }
        else
        {
            app.Use(pipelineConfiguration.AuthorizationMiddleware);
        }

        // Now we can run the claims to headers transformation middleware
        app.UseClaimsToHeadersMiddleware();

        // Allow the user to implement their own query string manipulation logic
        app.UseIfNotNull(pipelineConfiguration.PreQueryStringBuilderMiddleware);

        // Now we can run any claims to query string transformation middleware
        app.UseClaimsToQueryStringMiddleware();

        app.UseClaimsToDownstreamPathMiddleware();

        // Get the load balancer for this request
        app.UseLoadBalancingMiddleware();

        // This takes the downstream route we retrieved earlier and replaces any placeholders with the variables that should be used
        app.UseDownstreamUrlCreatorMiddleware();

        // as the basis for our cache key.
        app.UseOutputCacheMiddleware();

        //We fire off the request and set the response on the scoped data repo
        app.UseHttpRequesterMiddleware();

        return app.Build();
    }

    private static void UseIfNotNull(this IApplicationBuilder builder,
        Func<HttpContext, Func<Task>, Task>? middleware)
    {
        if (middleware != null)
        {
            builder.Use(middleware);
        }
    }
}