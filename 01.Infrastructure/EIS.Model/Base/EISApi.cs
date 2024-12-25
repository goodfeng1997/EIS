namespace EIS.Model.Base;

/// <summary>
/// 系统Api
/// </summary>
[Shared.ExpressionToSql.Attributes.Table("api")]
[FreeSql.DataAnnotations.Table(Name = "api")]
public record EISApi
{
    /// <summary>
    /// 主键
    /// </summary>
    public Guid Id { get; set; }

    /// <summary>
    /// Api编码
    /// </summary>
    public string ApiCode { get; set; } = string.Empty;

    /// <summary>
    /// Api名称
    /// </summary>
    public string ApiName { get; set; } = string.Empty;

    /// <summary>
    /// Api描述
    /// </summary>
    public string ApiDesc { get; set; } = string.Empty;
    
    /// <summary>
    /// Api范畴
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