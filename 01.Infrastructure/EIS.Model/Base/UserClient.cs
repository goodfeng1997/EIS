namespace EIS.Model.Base;
/// <summary>
/// 用户类型客户端
/// </summary>
[Shared.ExpressionToSql.Attributes.Table("user_client")]
[FreeSql.DataAnnotations.Table(Name = "user_client")]
public record UserClient
{
    /// <summary>
    /// 主键
    /// </summary>
    public Guid Id { get; set; }

    /// <summary>
    /// 用户类型
    /// </summary>
    public string UserType { get; set; } = string.Empty;
    
    /// <summary>
    /// 客户端主键
    /// </summary>
    public Guid ClientId { get; set; }
    
    /// <summary>
    /// 是否有效
    /// </summary>
    public bool IsEnable { get; set; }
    
    /// <summary>
    /// 是否删除
    /// </summary>
    public bool IsDelete { get; set; }
}