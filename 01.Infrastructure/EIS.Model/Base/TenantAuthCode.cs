namespace EIS.Model.Base;

/// <summary>
/// 租户授权码
/// </summary>
[Shared.ExpressionToSql.Attributes.Table("tenant_authcode")]
[FreeSql.DataAnnotations.Table(Name = "tenant_authcode")]
public record TenantAuthCode
{
    /// <summary>
    /// 主键
    /// </summary>
    public Guid Id { get; set; }

    /// <summary>
    /// 授权码
    /// </summary>
    public string AuthCode { get; set; } = string.Empty;

    /// <summary>
    /// 授权类型
    /// </summary>
    public string AuthType { get; set; } = string.Empty;
    
    /// <summary>
    /// 授权租户
    /// </summary>
    public Guid AuthTenant { get; set; }
    
    /// <summary>
    /// 授权截止日期
    /// </summary>
    public DateTime Validity { get; set; }
    
    /// <summary>
    /// 是否启用
    /// </summary>
    public bool IsEnable { get; set; }
    
    /// <summary>
    /// 是否删除
    /// </summary>
    public bool IsDelete { get;set;  }
}