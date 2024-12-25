namespace EIS.Model.Base;
/// <summary>
/// 客户端
/// </summary>
[Shared.ExpressionToSql.Attributes.Table("client")]
[FreeSql.DataAnnotations.Table(Name = "client")]
public record EISClient
{
    /// <summary>
    /// 主键
    /// </summary>
    public Guid Id { get; set; }

    /// <summary>
    /// 客户端ID
    /// </summary>
    public string ClientId { get; set; } = string.Empty;
    
    /// <summary>
    /// 客户端名称
    /// </summary>
    public string ClientName { get; set; } = string.Empty;

    /// <summary>
    /// 客户端密钥
    /// </summary>
    public string ClientSecret { get; set; } = string.Empty;
    
    /// <summary>
    /// 是否有效
    /// </summary>
    public bool IsEnable { get; set; }
    
    /// <summary>
    /// 是否删除
    /// </summary>
    public bool IsDelete { get; set; }
    
}