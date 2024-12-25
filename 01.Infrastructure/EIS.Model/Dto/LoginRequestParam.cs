namespace EIS.Model.Dto;
/// <summary>
/// 登录请求参数
/// </summary>
public record LoginRequestParam
{
    /// <summary>
    /// 用户名
    /// </summary>
    public string UserName { get; set; } = string.Empty;
    
    /// <summary>
    /// 密码
    /// </summary>
    public string Password { get; set; } = string.Empty;
    
    /// <summary>
    /// 授权码
    /// </summary>
    public string TenantAuth { get; set; } = string.Empty;
}