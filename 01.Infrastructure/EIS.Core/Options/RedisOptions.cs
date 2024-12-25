namespace EIS.Core.Options;

/// <summary>
/// Redis配置
/// </summary>
public class RedisOptions
{
    /// <summary>
    /// Redis连接名称
    /// </summary>
    public string RedisName { get; set; } = string.Empty;

    /// <summary>
    /// 连接IP
    /// </summary>
    public string Ip { get; set; } = "127.0.0.1";
    
    /// <summary>
    /// 连接端口
    /// </summary>
    public int Port { get; set; }
    
    /// <summary>
    /// 连接用户名
    /// </summary>
    public string UserName { get; set; } = string.Empty;
    
    /// <summary>
    /// 连接密码
    /// </summary>
    public string Password { get; set; } = string.Empty;
    
    /// <summary>
    /// 超时时间
    /// </summary>
    public int Timeout { get; set; }
    
    /// <summary>
    /// 连接数据库
    /// </summary>
    public string RedisDb { get; set; } = string.Empty;
}