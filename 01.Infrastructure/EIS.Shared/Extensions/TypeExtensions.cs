﻿#region License
/***
 * Copyright © 2024-2099, Kesiau.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * without warranties or conditions of any kind, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#endregion

using System.Reflection;

namespace EIS.Shared.Extensions
{
    /// <summary>
    /// Type扩展类
    /// </summary>
    public static class TypeExtensions
    {
        #region GetCoreType
        /// <summary>
        /// 如果type是Nullable类型则返回UnderlyingType，否则则直接返回type本身
        /// </summary>
        /// <param name="this">类型</param>
        /// <returns>Type</returns>
        public static Type GetCoreType(this Type @this) =>
            @this.IsNullable() ? Nullable.GetUnderlyingType(@this) : @this;
        #endregion

        #region IsNullable
        /// <summary>
        /// 判断类型是否是Nullable类型
        /// </summary>
        /// <param name="this">类型</param>
        /// <returns>bool</returns>
        public static bool IsNullable(this Type @this) =>
            @this != null && @this.IsValueType && @this.IsGenericType && @this.GetGenericTypeDefinition() == typeof(Nullable<>);
        #endregion

        #region IsAnonymousType
        /// <summary>
        /// 是否是匿名类型
        /// </summary>
        /// <param name="this"></param>
        /// <returns></returns>
        public static bool IsAnonymousType(this Type @this) =>
            @this != null && (@this.FullName.StartsWith("<>f__AnonymousType") || @this.FullName.StartsWith("VB$AnonymousType"));
        #endregion

        #region AssignableTo
        /// <summary>
        /// Determines whether the current type can be assigned from base type
        /// </summary>
        /// <param name="type"></param>
        /// <param name="baseType"></param>
        /// <returns></returns>
        public static bool AssignableTo(this Type type, Type baseType)
        {
            var typeInfo = type.GetTypeInfo();
            var baseTypeInfo = baseType.GetTypeInfo();

            if (baseTypeInfo.IsGenericTypeDefinition)
                return typeInfo.IsAssignableToGenericTypeDefinition(baseTypeInfo);

            return baseTypeInfo.IsAssignableFrom(typeInfo);
        }
        #endregion

        #region IsAssignableToGenericTypeDefinition
        /// <summary>
        /// IsAssignableToGenericTypeDefinition
        /// </summary>
        /// <param name="typeInfo"></param>
        /// <param name="genericTypeInfo"></param>
        /// <returns></returns>
        public static bool IsAssignableToGenericTypeDefinition(this TypeInfo typeInfo, TypeInfo genericTypeInfo)
        {
            var interfaceTypes = typeInfo.ImplementedInterfaces.Select(t => t.GetTypeInfo());

            foreach (var interfaceType in interfaceTypes)
            {
                if (interfaceType.IsGenericType)
                {
                    var typeDefinitionTypeInfo = interfaceType
                        .GetGenericTypeDefinition()
                        .GetTypeInfo();

                    if (typeDefinitionTypeInfo.Equals(genericTypeInfo))
                        return true;
                }
            }

            if (typeInfo.IsGenericType)
            {
                var typeDefinitionTypeInfo = typeInfo
                    .GetGenericTypeDefinition()
                    .GetTypeInfo();

                if (typeDefinitionTypeInfo.Equals(genericTypeInfo))
                    return true;
            }

            var baseTypeInfo = typeInfo.BaseType?.GetTypeInfo();

            if (baseTypeInfo is null)
                return false;

            return baseTypeInfo.IsAssignableToGenericTypeDefinition(genericTypeInfo);
        }
        #endregion

        #region IsDynamicOrObjectType
        /// <summary>
        /// 判断是否是dynamic或者object类型
        /// </summary>
        /// <param name="this"></param>
        /// <returns></returns>
        public static bool IsDynamicOrObjectType(this Type @this) =>
            @this == typeof(object);
        #endregion

        #region IsStringType
        /// <summary>
        /// 判断是否是string类型
        /// </summary>
        /// <param name="this"></param>
        /// <returns></returns>
        public static bool IsStringType(this Type @this) =>
            @this == typeof(string);
        #endregion

        #region IsGenericType
        /// <summary>
        /// IsGenericType
        /// </summary>
        /// <param name="this"></param>
        /// <returns></returns>
        public static bool IsGenericType(this Type @this) =>
            @this.GetTypeInfo().IsGenericType;

        /// <summary>
        /// IsGenericType
        /// </summary>
        /// <param name="this"></param>
        /// <param name="genericType"></param>
        /// <returns></returns>
        public static bool IsGenericType(this Type @this, Type genericType) =>
            @this.IsGenericType() && @this.GetGenericTypeDefinition() == genericType;
        #endregion

        #region IsDictionaryType
        /// <summary>
        /// IsDictionaryType
        /// </summary>
        /// <param name="this"></param>
        /// <returns></returns>
        public static bool IsDictionaryType(this Type @this) =>
            @this != null && @this.IsImplementsGenericInterface(typeof(IDictionary<,>));
        #endregion

        #region ImplementsGenericInterface
        /// <summary>
        /// ImplementsGenericInterface
        /// </summary>
        /// <param name="this"></param>
        /// <param name="interfaceType"></param>
        /// <returns></returns>
        public static bool IsImplementsGenericInterface(this Type @this, Type interfaceType)
        {
            if (@this.IsGenericType(interfaceType))
                return true;

            foreach (var @interface in @this.GetTypeInfo().ImplementedInterfaces)
            {
                if (@interface.IsGenericType(interfaceType))
                    return true;
            }

            return false;
        }
        #endregion
    }
}
