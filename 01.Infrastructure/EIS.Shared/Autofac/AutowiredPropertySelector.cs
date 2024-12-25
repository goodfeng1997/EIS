using System.Reflection;
using Autofac.Core;

namespace EIS.Shared.Autofac;

/// <summary>
/// 自动注入属性选择器
/// </summary>
public class AutowiredPropertySelector : IPropertySelector
{
    public bool InjectProperty(PropertyInfo propertyInfo, object instance)
    {
        //判断属性的特性是否包含自定义的属性,标记有返回true
        return propertyInfo.CustomAttributes.Any(s => s.AttributeType == typeof(AutowiredPropertyAttribute));
    }
}