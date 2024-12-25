namespace EIS.Model.Base;

/// <summary>
/// 客户端API
/// </summary>
[Shared.ExpressionToSql.Attributes.Table("client_api")]
[FreeSql.DataAnnotations.Table(Name = "client_api")]
public record ClientApi
{
    /// <summary>
    /// 主键
    /// </summary>
    public Guid Id { get; set; }

    /// <summary>
    /// 客户端ID
    /// </summary>
    public Guid ClientId { get; set; }

    /// <summary>
    /// ApiId
    /// </summary>
    public Guid ApiId { get; set; }

    /// <summary>
    /// api范畴
    /// </summary>
    public string ApiScope { get; set; } = string.Empty;
    
    /// <summary>
    /// 是否有效
    /// </summary>
    public bool IsEnable { get; set; }
    
    /// <summary>
    /// 是否删除
    /// </summary>
    public bool IsDelete { get; set; }
}