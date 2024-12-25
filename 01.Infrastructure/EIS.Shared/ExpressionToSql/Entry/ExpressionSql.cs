#region License
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

using EIS.Shared.Enums;
using EIS.Shared.ExpressionToSql.Models;
using System.Linq.Expressions;

namespace EIS.Shared.ExpressionToSql.Entry
{
    /// <summary>
    /// ExpressionSql
    /// </summary>
    public static class ExpressionSql
    {
        #region Insert
        /// <summary>
        /// Insert
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="isEnableNullValue">是否对null值属性进行sql拼接操作，默认：否</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Insert<T>(
            Expression<Func<object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            bool isEnableNullValue = false,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string, string> tableNameFunc = null)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Insert(expression, isEnableNullValue, tableNameFunc);
        #endregion

        #region Delete
        /// <summary>
        /// Delete
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Delete<T>(
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string, string> tableNameFunc = null)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Delete(tableNameFunc);
        #endregion

        #region Update
        /// <summary>
        /// Update
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="isEnableNullValue">是否对null值属性进行sql拼接操作，默认：否</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Update<T>(
            Expression<Func<object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            bool isEnableNullValue = false,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string, string> tableNameFunc = null)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Update(expression, isEnableNullValue, tableNameFunc);
        #endregion

        #region Select
        /// <summary>
        /// Select
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Select<T>(
            Expression<Func<T, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Select(expression, tableNameFunc);

        /// <summary>
        /// Select
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Select<T, T2>(
            Expression<Func<T, T2, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Select(expression, tableNameFunc);

        /// <summary>
        /// Select
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Select<T, T2, T3>(
            Expression<Func<T, T2, T3, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Select(expression, tableNameFunc);

        /// <summary>
        /// Select
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Select<T, T2, T3, T4>(
            Expression<Func<T, T2, T3, T4, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Select(expression, tableNameFunc);

        /// <summary>
        /// Select
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Select<T, T2, T3, T4, T5>(
            Expression<Func<T, T2, T3, T4, T5, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Select(expression, tableNameFunc);

        /// <summary>
        /// Select
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <typeparam name="T6">泛型类型6</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Select<T, T2, T3, T4, T5, T6>(
            Expression<Func<T, T2, T3, T4, T5, T6, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class
            where T6 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Select(expression, tableNameFunc);

        /// <summary>
        /// Select
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <typeparam name="T6">泛型类型6</typeparam>
        /// <typeparam name="T7">泛型类型7</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Select<T, T2, T3, T4, T5, T6, T7>(
            Expression<Func<T, T2, T3, T4, T5, T6, T7, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class
            where T6 : class
            where T7 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Select(expression, tableNameFunc);

        /// <summary>
        /// Select
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <typeparam name="T6">泛型类型6</typeparam>
        /// <typeparam name="T7">泛型类型7</typeparam>
        /// <typeparam name="T8">泛型类型8</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Select<T, T2, T3, T4, T5, T6, T7, T8>(
            Expression<Func<T, T2, T3, T4, T5, T6, T7, T8, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class
            where T6 : class
            where T7 : class
            where T8 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Select(expression, tableNameFunc);

        /// <summary>
        /// Select
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <typeparam name="T6">泛型类型6</typeparam>
        /// <typeparam name="T7">泛型类型7</typeparam>
        /// <typeparam name="T8">泛型类型8</typeparam>
        /// <typeparam name="T9">泛型类型9</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Select<T, T2, T3, T4, T5, T6, T7, T8, T9>(
            Expression<Func<T, T2, T3, T4, T5, T6, T7, T8, T9, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class
            where T6 : class
            where T7 : class
            where T8 : class
            where T9 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Select(expression, tableNameFunc);

        /// <summary>
        /// Select
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <typeparam name="T6">泛型类型6</typeparam>
        /// <typeparam name="T7">泛型类型7</typeparam>
        /// <typeparam name="T8">泛型类型8</typeparam>
        /// <typeparam name="T9">泛型类型9</typeparam>
        /// <typeparam name="T10">泛型类型10</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Select<T, T2, T3, T4, T5, T6, T7, T8, T9, T10>(
            Expression<Func<T, T2, T3, T4, T5, T6, T7, T8, T9, T10, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class
            where T6 : class
            where T7 : class
            where T8 : class
            where T9 : class
            where T10 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Select(expression, tableNameFunc);
        #endregion

        #region Max
        /// <summary>
        /// Max
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Max<T>(
            Expression<Func<T, object>> expression,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string, string> tableNameFunc = null)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Max(expression, tableNameFunc);
        #endregion

        #region Min
        /// <summary>
        /// Min
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Min<T>(
            Expression<Func<T, object>> expression,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string, string> tableNameFunc = null)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Min(expression, tableNameFunc);
        #endregion

        #region Avg
        /// <summary>
        /// Avg
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Avg<T>(
            Expression<Func<T, object>> expression,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string, string> tableNameFunc = null)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Avg(expression, tableNameFunc);
        #endregion

        #region Count
        /// <summary>
        /// Count
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Count<T>(
            Expression<Func<T, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Count(expression, tableNameFunc);

        /// <summary>
        /// Count
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Count<T, T2>(
            Expression<Func<T, T2, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Count(expression, tableNameFunc);

        /// <summary>
        /// Count
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Count<T, T2, T3>(
            Expression<Func<T, T2, T3, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Count(expression, tableNameFunc);

        /// <summary>
        /// Count
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Count<T, T2, T3, T4>(
            Expression<Func<T, T2, T3, T4, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Count(expression, tableNameFunc);

        /// <summary>
        /// Count
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Count<T, T2, T3, T4, T5>(
            Expression<Func<T, T2, T3, T4, T5, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Count(expression, tableNameFunc);

        /// <summary>
        /// Count
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <typeparam name="T6">泛型类型6</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Count<T, T2, T3, T4, T5, T6>(
            Expression<Func<T, T2, T3, T4, T5, T6, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class
            where T6 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Count(expression, tableNameFunc);

        /// <summary>
        /// Count
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <typeparam name="T6">泛型类型6</typeparam>
        /// <typeparam name="T7">泛型类型7</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Count<T, T2, T3, T4, T5, T6, T7>(
            Expression<Func<T, T2, T3, T4, T5, T6, T7, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class
            where T6 : class
            where T7 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Count(expression, tableNameFunc);

        /// <summary>
        /// Count
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <typeparam name="T6">泛型类型6</typeparam>
        /// <typeparam name="T7">泛型类型7</typeparam>
        /// <typeparam name="T8">泛型类型8</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Count<T, T2, T3, T4, T5, T6, T7, T8>(
            Expression<Func<T, T2, T3, T4, T5, T6, T7, T8, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class
            where T6 : class
            where T7 : class
            where T8 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Count(expression, tableNameFunc);

        /// <summary>
        /// Count
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <typeparam name="T6">泛型类型6</typeparam>
        /// <typeparam name="T7">泛型类型7</typeparam>
        /// <typeparam name="T8">泛型类型8</typeparam>
        /// <typeparam name="T9">泛型类型9</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Count<T, T2, T3, T4, T5, T6, T7, T8, T9>(
            Expression<Func<T, T2, T3, T4, T5, T6, T7, T8, T9, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class
            where T6 : class
            where T7 : class
            where T8 : class
            where T9 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Count(expression, tableNameFunc);

        /// <summary>
        /// Count
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <typeparam name="T2">泛型类型2</typeparam>
        /// <typeparam name="T3">泛型类型3</typeparam>
        /// <typeparam name="T4">泛型类型4</typeparam>
        /// <typeparam name="T5">泛型类型5</typeparam>
        /// <typeparam name="T6">泛型类型6</typeparam>
        /// <typeparam name="T7">泛型类型7</typeparam>
        /// <typeparam name="T8">泛型类型8</typeparam>
        /// <typeparam name="T9">泛型类型9</typeparam>
        /// <typeparam name="T10">泛型类型10</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Count<T, T2, T3, T4, T5, T6, T7, T8, T9, T10>(
            Expression<Func<T, T2, T3, T4, T5, T6, T7, T8, T9, T10, object>> expression = null,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string[], string> tableNameFunc = null)
            where T : class
            where T2 : class
            where T3 : class
            where T4 : class
            where T5 : class
            where T6 : class
            where T7 : class
            where T8 : class
            where T9 : class
            where T10 : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Count(expression, tableNameFunc);
        #endregion

        #region Sum
        /// <summary>
        /// Sum
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="expression">表达式树</param>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="sqlIntercept">sql拦截委托</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <param name="tableNameFunc">表名自定义委托</param>
        /// <returns>ExpressionSqlCore</returns>
        public static ExpressionSqlCore<T> Sum<T>(
            Expression<Func<T, object>> expression,
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            Func<string, object, string> sqlIntercept = null,
            bool isEnableFormat = false,
            Func<string, string> tableNameFunc = null)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, sqlIntercept, isEnableFormat).Sum(expression, tableNameFunc);
        #endregion

        #region GetTableName
        /// <summary>
        /// 获取实体对应的数据库表名
        /// </summary>
        /// <typeparam name="T">泛型类型</typeparam>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <returns>string</returns>
        public static string GetTableName<T>(
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            bool isEnableFormat = false)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, isEnableFormat).GetTableName();
        #endregion

        #region GetPrimaryKey
        /// <summary>
        /// 获取实体对应的数据库表的主键名(多主键)
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="databaseTypeEnum">数据库类型</param>
        /// <param name="isEnableFormat">是否启用对表名和列名格式化，默认：否</param>
        /// <returns></returns>
        public static List<ColumnInfo> GetPrimaryKey<T>(
            DatabaseTypeEnum databaseTypeEnum = DatabaseTypeEnum.SqlServer,
            bool isEnableFormat = false)
            where T : class =>
            new ExpressionSqlCore<T>(databaseTypeEnum, isEnableFormat).GetPrimaryKey();
        #endregion
    }
}