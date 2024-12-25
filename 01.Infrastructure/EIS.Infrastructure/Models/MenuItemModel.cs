using Material.Icons;

namespace EIS.Infrastructure.Models;

public class MenuItemModel
{
    /// <summary>
    /// 菜单代码
    /// </summary>
    public string MenuCode { get; set; } = string.Empty;
    
    /// <summary>
    /// 展示名称
    /// </summary>
    public string DisplayName { get; set; } = string.Empty;
    
    /// <summary>
    /// 图标
    /// </summary>
    public MaterialIconKind Icon { get; set; }
    
    /// <summary>
    /// 索引
    /// </summary>
    public int Index { get; set; }
}