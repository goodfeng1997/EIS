using EIS.Core.Base.DataBaseLinq;
using EIS.Model.Base;
using EIS.Shared.Extensions;
using IdentityServer4.Models;
using IdentityServer4.Services;

namespace EIS.Auth.ServiceExtensions;

/// <summary>
/// IdentityServer4 用户信息获取服务
/// </summary>
public class ProfileService : IProfileService
{
    private readonly ILogger<ProfileService> _logger;
    private readonly IDbService _dbService;
    
    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="logger"></param>
    /// <param name="dbService"></param>
    public ProfileService(ILogger<ProfileService> logger, IDbService dbService)
    {
        _logger = logger;
        _dbService = dbService;
    }
    
    /// <summary>
    /// 获取用户信息
    /// </summary>
    /// <param name="context"></param>
    public async Task GetProfileDataAsync(ProfileDataRequestContext context)
    {
        context.IssuedClaims = context.Subject.Claims.ToList();
        await Task.CompletedTask;
    }

    /// <summary>
    /// 验证用户Claims的正确性(用户类型与客户端是否匹配)
    /// </summary>
    /// <param name="context"></param>
    public async Task IsActiveAsync(IsActiveContext context)
    {
        try
        {
            var clientId = context.Client.ClientId;
            var userType = context.Subject.Claims.FirstOrDefault(x => x.Type == "UserType")?.Value;
            var list = await _dbService.QueryList<UserClient>(t => t.ClientId == clientId.ToGuid() && t.UserType == userType);
            
            context.IsActive = list.Count() != 0;
        }
        catch (Exception e)
        {
            _logger.LogError(e.ToString());
            context.IsActive = false;
        }
    }
}