namespace EIS.Model.Base;
/// <summary>
/// 用户
/// </summary>
[Shared.ExpressionToSql.Attributes.Table("user")]
[FreeSql.DataAnnotations.Table(Name = "user")]
public record User
{
    /// <summary>
    /// 主键
    /// </summary>
    public Guid Id { get; set; }

    /// <summary>
    /// 用户编号
    /// </summary>
    public string UserCode { get; set; } = string.Empty;
    
    /// <summary>
    /// 用户名称
    /// </summary>
    public string UserName { get; set; } = string.Empty;
    
    /// <summary>
    /// 用户类型
    /// </summary>
    public string UserType { get; set; } = string.Empty;
    
    /// <summary>
    /// 用户密码
    /// </summary>
    public string UserPassWord { get; set; } = string.Empty;
    
    /// <summary>
    /// 是否有效
    /// </summary>
    public bool IsEnable { get; set; }
    
    /// <summary>
    /// 是否删除
    /// </summary>
    public bool IsDelete { get; set; }
}