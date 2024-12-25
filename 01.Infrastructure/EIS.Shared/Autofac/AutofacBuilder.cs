using Autofac;
using Autofac.Extensions.DependencyInjection;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;

namespace EIS.Shared.Autofac;

public static class AutofacBuilder
{
    /// <summary>
    /// 添加Autofac
    /// </summary>
    /// <param name="builder"></param>
    /// <param name="action"></param>
    /// <returns></returns>
    public static WebApplicationBuilder AddAutofac(this WebApplicationBuilder builder, Action<ContainerBuilder> action)
    {
        builder.Host.UseServiceProviderFactory(new AutofacServiceProviderFactory());
        builder.Host.ConfigureContainer<ContainerBuilder>((context, containerBuilder) =>
        {
            action.Invoke(containerBuilder);
            
            // 注册Controller
            Type[] controllersTypeAssembly = AppDomain.CurrentDomain.GetAssemblies().SelectMany(a =>
                a.GetExportedTypes()).Where(t => typeof(ControllerBase).IsAssignableFrom(t)).ToArray();

            containerBuilder.RegisterTypes(controllersTypeAssembly).PropertiesAutowired(new AutowiredPropertySelector());
        });

        builder.Services.Replace(ServiceDescriptor.Transient<IControllerActivator, ServiceBasedControllerActivator>());
        return builder;
    }
}