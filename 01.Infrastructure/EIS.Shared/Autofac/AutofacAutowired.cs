using System.Reflection;
using Autofac;
using EIS.Shared.Autofac.DependencyInjection;

namespace EIS.Shared.Autofac;

/// <summary>
/// IOC 扩展方法
/// </summary>
public static class AutofacAutowired
{
    /// <summary>
    /// 批量注入扩展
    /// </summary>
    /// <param name="builder"></param>
    /// <param name="assembly"></param>
    public static void BatchAutowired(this ContainerBuilder builder, Assembly assembly)
    {
        var transientType = typeof(ITransitDependency); //瞬时注入
        var singletonType = typeof(ISingletonDependency); //单例注入
        var scopeType = typeof(IScopeDependency); //单例注入
        
        //瞬时注入
        builder.RegisterAssemblyTypes(assembly).Where(t => t is { IsClass: true, IsAbstract: false } && t.GetInterfaces().Contains(transientType))
            .AsSelf()
            .AsImplementedInterfaces()
            .InstancePerDependency()
            .PropertiesAutowired(new AutowiredPropertySelector());
        
        //单例注入
        builder.RegisterAssemblyTypes(assembly).Where(t => t is { IsClass: true, IsAbstract: false } && t.GetInterfaces().Contains(singletonType))
            .AsSelf()
            .AsImplementedInterfaces()
            .SingleInstance()
            .PropertiesAutowired(new AutowiredPropertySelector());
        
        //生命周期注入
        builder.RegisterAssemblyTypes(assembly).Where(t => t is { IsClass: true, IsAbstract: false } && t.GetInterfaces().Contains(scopeType))
            .AsSelf()
            .AsImplementedInterfaces()
            .InstancePerLifetimeScope()
            .PropertiesAutowired(new AutowiredPropertySelector());
    }
}