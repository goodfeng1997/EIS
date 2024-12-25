namespace EIS.Model.Base;

/// <summary>
/// 租户配置
/// </summary>
public record TenantConfig
{
    /// <summary>
    /// 主键
    /// </summary>
    public Guid Id { get; set; }
    
    /// <summary>
    /// 租户ID
    /// </summary>
    public Guid TenantId { get; set; }
    
    /// <summary>
    /// 数据库主机
    /// </summary>
    public string DbHost { get; set; } = String.Empty;

    /// <summary>
    /// 数据库端口
    /// </summary>
    public string DbPort { get; set; } = string.Empty;
    
    /// <summary>
    /// 数据库名称
    /// </summary>
    public string DbName { get; set; } = string.Empty;
    
    /// <summary>
    /// 数据库名称
    /// </summary>
    public string DbUser { get; set; } = string.Empty;
    
    /// <summary>
    /// 数据库名称
    /// </summary>
    public string DbPassword { get; init; } = string.Empty;
    
    /// <summary>
    /// 是否有效
    /// </summary>
    public bool IsEnable { get; set; }
    
    /// <summary>
    /// 是否删除
    /// </summary>
    public bool IsDelete { get; set; }
}