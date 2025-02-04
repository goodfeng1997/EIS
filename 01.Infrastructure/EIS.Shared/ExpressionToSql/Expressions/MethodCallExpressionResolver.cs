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

using EIS.Shared.ExpressionToSql.Entry;
using EIS.Shared.Enums;
using EIS.Shared.Extensions;
using System.Collections;
using System.Linq.Expressions;

namespace EIS.Shared.ExpressionToSql.Expressions
{
    /// <summary>
    /// 表示对静态方法或实例方法的调用
    /// </summary>
    public class MethodCallExpressionResolver : BaseExpression<MethodCallExpression>
    {
        #region Methods
        #region Field
        /// <summary>
        /// methods
        /// </summary>
        private static readonly Dictionary<string, Action<MethodCallExpression, SqlWrapper>> methods =
            new()
            {
                ["Like"] = Like,
                ["NotLike"] = NotLike,
                ["StartsWith"] = StartsWith,
                ["StartsWithIgnoreCase"] = StartsWithIgnoreCase,
                ["EndsWith"] = EndsWith,
                ["EndsWithIgnoreCase"] = EndsWithIgnoreCase,
                ["Contains"] = Contains,
                ["ContainsIgnoreCase"] = ContainsIgnoreCase,
                ["In"] = SqlIn,
                ["NotIn"] = NotIn,
                ["IsNullOrEmpty"] = IsNullOrEmpty,
                ["Equals"] = Equals,
                ["ToUpper"] = ToUpper,
                ["ToLower"] = ToLower,
                ["Trim"] = Trim,
                ["TrimStart"] = TrimStart,
                ["TrimEnd"] = TrimEnd,
                ["Count"] = SqlCount,
                ["Sum"] = SqlSum,
                ["Avg"] = SqlAvg,
                ["Max"] = SqlMax,
                ["Min"] = SqlMin
            };
        #endregion

        #region SqlIn
        /// <summary>
        /// In
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void SqlIn(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);
            sqlWrapper += " IN ";
            SqlExpressionProvider.In(expression.Arguments[1], sqlWrapper);
        }
        #endregion

        #region NotIn
        /// <summary>
        /// Not In
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void NotIn(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);
            sqlWrapper += " NOT IN ";
            SqlExpressionProvider.In(expression.Arguments[1], sqlWrapper);
        }
        #endregion

        #region Like
        /// <summary>
        /// Like
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void Like(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Object != null)
            {
                SqlExpressionProvider.Where(expression.Object, sqlWrapper);
            }
            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);
            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                    sqlWrapper += " LIKE '%' + ";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += " LIKE CONCAT('%',";
                    break;
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " LIKE '%' || ";
                    break;
                default:
                    break;
            }
            SqlExpressionProvider.Where(expression.Arguments[1], sqlWrapper);
            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                    sqlWrapper += " + '%'";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += ",'%')";
                    break;
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " || '%'";
                    break;
                default:
                    break;
            }
        }
        #endregion

        #region NotLike
        /// <summary>
        /// NotLike
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void NotLike(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Object != null)
                SqlExpressionProvider.Where(expression.Object, sqlWrapper);

            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);
            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                    sqlWrapper += " NOT LIKE '%' + ";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += " NOT LIKE CONCAT('%',";
                    break;
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " NOT LIKE '%' || ";
                    break;
                default:
                    break;
            }
            SqlExpressionProvider.Where(expression.Arguments[1], sqlWrapper);
            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                    sqlWrapper += " + '%'";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += ",'%')";
                    break;
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " || '%'";
                    break;
                default:
                    break;
            }
        }
        #endregion

        #region StartsWith
        /// <summary>
        /// StartsWith
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void StartsWith(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            SqlExpressionProvider.Where(expression.Object, sqlWrapper);

            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " LIKE ";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += " LIKE CONCAT(";
                    break;
                default:
                    break;
            }

            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);

            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                    sqlWrapper += " + '%'";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += ",'%')";
                    break;
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " || '%'";
                    break;
                default:
                    break;
            }
        }
        #endregion

        #region StartsWithIgnoreCase
        /// <summary>
        /// StartsWithIgnoreCase
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void StartsWithIgnoreCase(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            sqlWrapper += "UPPER(";
            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);
            sqlWrapper += ")";

            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " LIKE ";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += " LIKE CONCAT(";
                    break;
                default:
                    break;
            }

            sqlWrapper += "UPPER(";
            SqlExpressionProvider.Where(expression.Arguments[1], sqlWrapper);
            sqlWrapper += ")";

            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                    sqlWrapper += " + '%'";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += ",'%')";
                    break;
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " || '%'";
                    break;
                default:
                    break;
            }
        }
        #endregion

        #region EndsWith
        /// <summary>
        /// EndsWith
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void EndsWith(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            SqlExpressionProvider.Where(expression.Object, sqlWrapper);

            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                    sqlWrapper += " LIKE '%' + ";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += " LIKE CONCAT('%',";
                    break;
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " LIKE '%' || ";
                    break;
                default:
                    break;
            }

            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);

            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += ")";
                    break;
                default:
                    break;
            }
        }
        #endregion

        #region EndsWithIgnoreCase
        /// <summary>
        /// EndsWithIgnoreCase
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void EndsWithIgnoreCase(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            sqlWrapper += "UPPER(";
            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);
            sqlWrapper += ")";

            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                    sqlWrapper += " LIKE '%' + ";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += " LIKE CONCAT('%',";
                    break;
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " LIKE '%' || ";
                    break;
                default:
                    break;
            }

            sqlWrapper += "UPPER(";
            SqlExpressionProvider.Where(expression.Arguments[1], sqlWrapper);
            sqlWrapper += ")";

            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += ")";
                    break;
                default:
                    break;
            }
        }
        #endregion

        #region Contains
        /// <summary>
        /// Contains
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void Contains(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Object != null)
            {
                if (typeof(IList).IsAssignableFrom(expression.Object.Type))
                {
                    SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);
                    sqlWrapper += " IN ";
                    SqlExpressionProvider.In(expression.Object, sqlWrapper);
                }
                else
                {
                    SqlExpressionProvider.Where(expression.Object, sqlWrapper);

                    switch (sqlWrapper.DatabaseTypeEnum)
                    {
                        case DatabaseTypeEnum.SqlServer:
                            sqlWrapper += " LIKE '%' + ";
                            break;
                        case DatabaseTypeEnum.MySql:
                        case DatabaseTypeEnum.PostgreSql:
                            sqlWrapper += " LIKE CONCAT('%',";
                            break;
                        case DatabaseTypeEnum.Oracle:
                        case DatabaseTypeEnum.Sqlite:
                            sqlWrapper += " LIKE '%' || ";
                            break;
                        default:
                            break;
                    }

                    SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);

                    switch (sqlWrapper.DatabaseTypeEnum)
                    {
                        case DatabaseTypeEnum.SqlServer:
                            sqlWrapper += " + '%'";
                            break;
                        case DatabaseTypeEnum.MySql:
                        case DatabaseTypeEnum.PostgreSql:
                            sqlWrapper += ",'%')";
                            break;
                        case DatabaseTypeEnum.Oracle:
                        case DatabaseTypeEnum.Sqlite:
                            sqlWrapper += " || '%'";
                            break;
                        default:
                            break;
                    }
                }
            }
            else if (expression.Arguments.Count > 1 && expression.Arguments[1] is MemberExpression memberExpression)
            {
                SqlExpressionProvider.Where(memberExpression, sqlWrapper);
                sqlWrapper += " IN ";
                SqlExpressionProvider.In(expression.Arguments[0], sqlWrapper);
            }
        }
        #endregion

        #region ContainsIgnoreCase
        /// <summary>
        /// ContainsIgnoreCase
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void ContainsIgnoreCase(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            sqlWrapper += "UPPER(";
            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);
            sqlWrapper += ")";

            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                    sqlWrapper += " LIKE '%' + ";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += " LIKE CONCAT('%',";
                    break;
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " LIKE '%' || ";
                    break;
                default:
                    break;
            }

            sqlWrapper += "UPPER(";
            SqlExpressionProvider.Where(expression.Arguments[1], sqlWrapper);
            sqlWrapper += ")";

            switch (sqlWrapper.DatabaseTypeEnum)
            {
                case DatabaseTypeEnum.SqlServer:
                    sqlWrapper += " + '%'";
                    break;
                case DatabaseTypeEnum.MySql:
                case DatabaseTypeEnum.PostgreSql:
                    sqlWrapper += ",'%')";
                    break;
                case DatabaseTypeEnum.Oracle:
                case DatabaseTypeEnum.Sqlite:
                    sqlWrapper += " || '%'";
                    break;
                default:
                    break;
            }
        }
        #endregion

        #region IsNullOrEmpty
        /// <summary>
        /// IsNullOrEmpty
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void IsNullOrEmpty(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            sqlWrapper += "(";
            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);
            sqlWrapper += " IS NULL OR ";
            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);
            sqlWrapper += " = ''";
            sqlWrapper += ")";
        }
        #endregion

        #region Equals
        /// <summary>
        /// Equals
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void Equals(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Object != null)
                SqlExpressionProvider.Where(expression.Object, sqlWrapper);

            var signIndex = sqlWrapper.Length;
            SqlExpressionProvider.Where(expression.Arguments[0], sqlWrapper);

            if (sqlWrapper.EndsWith("NULL"))
                sqlWrapper.Insert(signIndex, " IS ");
            else
                sqlWrapper.Insert(signIndex, " = ");
        }
        #endregion

        #region ToUpper
        /// <summary>
        /// ToUpper
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void ToUpper(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Object != null)
            {
                sqlWrapper += "UPPER(";
                SqlExpressionProvider.Where(expression.Object, sqlWrapper);
                sqlWrapper += ")";
            }
        }
        #endregion

        #region ToLower
        /// <summary>
        /// ToLower
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void ToLower(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Object != null)
            {
                sqlWrapper += "LOWER(";
                SqlExpressionProvider.Where(expression.Object, sqlWrapper);
                sqlWrapper += ")";
            }
        }
        #endregion

        #region Trim
        /// <summary>
        /// Trim
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void Trim(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Object != null)
            {
                var hasArguments = expression.Arguments?.Count > 0;
                if (hasArguments)
                    hasArguments = (expression.Arguments[0] as NewArrayExpression)?.Expressions.Count > 0;

                if (hasArguments)
                {
                    var trimString = expression.Object.ToObject()?.ToString();
                    if (trimString.IsNotNullOrEmpty())
                    {
                        string constant;
                        var argument = expression.Arguments[0].ToObject();
                        if (argument is char @char)
                            constant = trimString.Trim(@char);
                        else
                            constant = trimString.Trim((char[])argument);

                        SqlExpressionProvider.Where(Expression.Constant(constant), sqlWrapper);
                    }
                }
                else
                {
                    if (sqlWrapper.DatabaseTypeEnum == DatabaseTypeEnum.SqlServer)
                        sqlWrapper += "LTRIM(RTRIM(";
                    else
                        sqlWrapper += "TRIM(";

                    SqlExpressionProvider.Where(expression.Object, sqlWrapper);

                    if (sqlWrapper.DatabaseTypeEnum == DatabaseTypeEnum.SqlServer)
                        sqlWrapper += "))";
                    else
                        sqlWrapper += ")";
                }
            }
        }
        #endregion

        #region TrimStart
        /// <summary>
        /// TrimStart
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void TrimStart(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Object != null)
            {
                var hasArguments = expression.Arguments?.Count > 0;
                if (hasArguments)
                    hasArguments = (expression.Arguments[0] as NewArrayExpression)?.Expressions.Count > 0;

                if (hasArguments)
                {
                    var trimString = expression.Object.ToObject()?.ToString();
                    if (trimString.IsNotNullOrEmpty())
                    {
                        string constant;
                        var argument = expression.Arguments[0].ToObject();
                        if (argument is char @char)
                            constant = trimString.TrimStart(@char);
                        else
                            constant = trimString.TrimStart((char[])argument);

                        SqlExpressionProvider.Where(Expression.Constant(constant), sqlWrapper);
                    }
                }
                else
                {
                    sqlWrapper += "LTRIM(";
                    SqlExpressionProvider.Where(expression.Object, sqlWrapper);
                    sqlWrapper += ")";
                }
            }
        }
        #endregion

        #region TrimEnd
        /// <summary>
        /// TrimEnd
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void TrimEnd(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Object != null)
            {
                var hasArguments = expression.Arguments?.Count > 0;
                if (hasArguments)
                    hasArguments = (expression.Arguments[0] as NewArrayExpression)?.Expressions.Count > 0;

                if (hasArguments)
                {
                    var trimString = expression.Object.ToObject()?.ToString();
                    if (trimString.IsNotNullOrEmpty())
                    {
                        string constant;
                        var argument = expression.Arguments[0].ToObject();
                        if (argument is char @char)
                            constant = trimString.TrimEnd(@char);
                        else
                            constant = trimString.TrimEnd((char[])argument);

                        SqlExpressionProvider.Where(Expression.Constant(constant), sqlWrapper);
                    }
                }
                else
                {
                    sqlWrapper += "RTRIM(";
                    SqlExpressionProvider.Where(expression.Object, sqlWrapper);
                    sqlWrapper += ")";
                }
            }
        }
        #endregion

        #region SqlCount
        /// <summary>
        /// Count
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void SqlCount(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Arguments?.Count > 0)
            {
                if (sqlWrapper.IsHavingSyntax)
                {
                    sqlWrapper += "COUNT(";
                    SqlExpressionProvider.Having(expression.Arguments[0], sqlWrapper);
                    sqlWrapper += ")";
                }
                else
                {
                    SqlSelect(expression, sqlWrapper, "COUNT({0})");
                }
            }
        }
        #endregion

        #region SqlSum
        /// <summary>
        /// Sum
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void SqlSum(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Arguments?.Count > 0)
            {
                if (sqlWrapper.IsHavingSyntax)
                {
                    sqlWrapper += "SUM(";
                    SqlExpressionProvider.Having(expression.Arguments[0], sqlWrapper);
                    sqlWrapper += ")";
                }
                else
                {
                    SqlSelect(expression, sqlWrapper, "SUM({0})");
                }
            }
        }
        #endregion

        #region SqlAvg
        /// <summary>
        /// Avg
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void SqlAvg(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Arguments?.Count > 0)
            {
                if (sqlWrapper.IsHavingSyntax)
                {
                    sqlWrapper += "AVG(";
                    SqlExpressionProvider.Having(expression.Arguments[0], sqlWrapper);
                    sqlWrapper += ")";
                }
                else
                {
                    SqlSelect(expression, sqlWrapper, "AVG({0})");
                }
            }
        }
        #endregion

        #region SqlMax
        /// <summary>
        /// Max
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void SqlMax(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Arguments?.Count > 0)
            {
                if (sqlWrapper.IsHavingSyntax)
                {
                    sqlWrapper += "MAX(";
                    SqlExpressionProvider.Having(expression.Arguments[0], sqlWrapper);
                    sqlWrapper += ")";
                }
                else
                {
                    SqlSelect(expression, sqlWrapper, "MAX({0})");
                }
            }
        }
        #endregion

        #region SqlMin
        /// <summary>
        /// Min
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        private static void SqlMin(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.Arguments?.Count > 0)
            {
                if (sqlWrapper.IsHavingSyntax)
                {
                    sqlWrapper += "MIN(";
                    SqlExpressionProvider.Having(expression.Arguments[0], sqlWrapper);
                    sqlWrapper += ")";
                }
                else
                {
                    SqlSelect(expression, sqlWrapper, "MIN({0})");
                }
            }
        }
        #endregion

        #region SqlSelect
        /// <summary>
        /// SqlSelect
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        /// <param name="methodFormat">sql方法</param>
        private static void SqlSelect(MethodCallExpression expression, SqlWrapper sqlWrapper, string methodFormat)
        {
            var memberExpr = GetMemberExpression(expression);
            if (memberExpr != null)
            {
                var type = memberExpr.Expression.Type != memberExpr.Member.DeclaringType ?
                           memberExpr.Expression.Type :
                           memberExpr.Member.DeclaringType;

                var tableName = sqlWrapper.GetTableName(type);
                var parameter = memberExpr.Expression as ParameterExpression;
                var tableAlias = sqlWrapper.GetTableAlias(tableName, parameter?.Name);

                if (tableAlias.IsNotNullOrEmpty())
                    tableAlias += ".";

                var columnName = tableAlias + sqlWrapper.GetColumnInfo(memberExpr.Member.DeclaringType, memberExpr.Member).ColumnName;

                var field = string.Format(methodFormat, columnName);

                SqlExpressionProvider.Select(Expression.Constant(field), sqlWrapper);
            }
        }
        #endregion

        #region GetMethodHandler
        /// <summary>
        /// 获取方法处理委托
        /// </summary>
        /// <param name="expression"></param>
        /// <returns></returns>
        private static Action<MethodCallExpression, SqlWrapper> GetMethodHandler(MethodCallExpression expression)
        {
            var method = expression.Method;
            if (method.IsGenericMethod)
                method = method.GetGenericMethodDefinition();

            //匹配到方法
            if (methods.TryGetValue(method.Name, out Action<MethodCallExpression, SqlWrapper> handler))
                return handler;

            return null;
        }
        #endregion

        #region GetMemberExpression
        /// <summary>
        /// 获取MemberExpression
        /// </summary>
        /// <param name="expression"></param>
        /// <returns></returns>
        private static MemberExpression GetMemberExpression(MethodCallExpression expression)
        {
            var expr = expression.Arguments[0];

            var memberExpr = expr as MemberExpression;
            if (memberExpr.IsNull() && expr is UnaryExpression unaryExpr)
                memberExpr = unaryExpr.Operand as MemberExpression;

            return memberExpr;
        }
        #endregion
        #endregion

        #region In
        /// <summary>
        /// In
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        /// <returns>SqlWrapper</returns>
        public override SqlWrapper In(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            var convertRes = expression?.ToObject();
            if (convertRes != null)
            {
                sqlWrapper += "(";

                if (convertRes is IEnumerable collection)
                {
                    foreach (var item in collection)
                    {
                        SqlExpressionProvider.In(Expression.Constant(item), sqlWrapper);
                        sqlWrapper += ",";
                    }
                }
                else
                {
                    SqlExpressionProvider.In(Expression.Constant(convertRes), sqlWrapper);
                }

                sqlWrapper.RemoveLast(',');

                sqlWrapper += ")";
            }

            return sqlWrapper;
        }
        #endregion

        #region Select
        /// <summary>
        /// Select
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        /// <returns>SqlWrapper</returns>
        public override SqlWrapper Select(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            try
            {
                var field = expression.ToObject()?.ToString();
                if (field.IsNotNullOrEmpty())
                    sqlWrapper.AddField(field);
            }
            catch
            {
                var handler = GetMethodHandler(expression);
                if (handler != null)
                {
                    sqlWrapper.IsHavingSyntax = false;
                    handler(expression, sqlWrapper);
                }
            }

            return sqlWrapper;
        }
        #endregion

        #region Where
        /// <summary>
        /// Where
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        /// <returns>SqlWrapper</returns>
        public override SqlWrapper Where(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            var handler = GetMethodHandler(expression);
            if (handler != null)
                handler(expression, sqlWrapper);
            else
            {
                try
                {
                    sqlWrapper.AddDbParameter(expression.ToObject());
                }
                catch
                {
                    throw new NotImplementedException("无法解析方法" + expression.Method);
                }
            }

            return sqlWrapper;
        }
        #endregion

        #region Insert
        /// <summary>
        /// Insert
        /// </summary>
        /// <param name="expression"></param>
        /// <param name="sqlWrapper"></param>
        /// <returns></returns>
        public override SqlWrapper Insert(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.ToObject() is IEnumerable collection)
            {
                var i = 0;
                var fields = new List<string>();

                foreach (var item in collection)
                {
                    if (sqlWrapper.DatabaseTypeEnum != DatabaseTypeEnum.Oracle)
                        sqlWrapper.Append("(");

                    if (i > 0 && sqlWrapper.DatabaseTypeEnum == DatabaseTypeEnum.Oracle)
                        sqlWrapper.Append(" UNION ALL SELECT ");

                    var properties = item?.GetType().GetProperties();
                    foreach (var p in properties)
                    {
                        var type = p.DeclaringType.IsAnonymousType() ?
                            sqlWrapper.DefaultType :
                            p.DeclaringType;

                        var columnInfo = sqlWrapper.GetColumnInfo(type, p);
                        if (columnInfo.IsInsert)
                        {
                            var value = p.GetValue(item, null);
                            if (value != null || (sqlWrapper.IsEnableNullValue && value == null))
                            {
                                sqlWrapper.AddDbParameter(value, columnInfo.DataType);
                                if (!fields.Contains(columnInfo.ColumnName))
                                    fields.Add(columnInfo.ColumnName);
                                sqlWrapper += ",";
                            }
                        }
                    }

                    if (sqlWrapper[sqlWrapper.Length - 1] == ',')
                    {
                        sqlWrapper.Remove(sqlWrapper.Length - 1, 1);
                        if (sqlWrapper.DatabaseTypeEnum != DatabaseTypeEnum.Oracle)
                            sqlWrapper.Append("),");
                        else
                            sqlWrapper.Append(" FROM DUAL");
                    }

                    i++;
                }

                sqlWrapper.RemoveLast(',');

                sqlWrapper.Reset(string.Format(sqlWrapper.ToString(), string.Join(",", fields).TrimEnd(',')));
            }

            return sqlWrapper;
        }
        #endregion

        #region GroupBy
        /// <summary>
        /// GroupBy
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        /// <returns>SqlWrapper</returns>
        public override SqlWrapper GroupBy(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            if (expression.ToObject() is IEnumerable collection)
            {
                foreach (var item in collection)
                {
                    SqlExpressionProvider.GroupBy(Expression.Constant(item), sqlWrapper);

                    sqlWrapper += ",";
                }

                sqlWrapper.RemoveLast(',');
            }

            return sqlWrapper;
        }
        #endregion

        #region Having
        /// <summary>
        /// Having
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        /// <returns>SqlWrapper</returns>
        public override SqlWrapper Having(MethodCallExpression expression, SqlWrapper sqlWrapper)
        {
            var handler = GetMethodHandler(expression);

            var memberExpr = GetMemberExpression(expression);

            if (memberExpr?.Expression is ParameterExpression && handler != null)
            {
                sqlWrapper.IsHavingSyntax = true;
                handler(expression, sqlWrapper);
            }
            else
            {
                try
                {
                    sqlWrapper.AddDbParameter(expression.ToObject());
                }
                catch
                {
                    throw new NotImplementedException("无法解析方法" + expression.Method);
                }
            }

            return sqlWrapper;
        }
        #endregion

        #region OrderBy
        /// <summary>
        /// OrderBy
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        /// <param name="orders">排序方式</param>
        /// <returns>SqlWrapper</returns>
        public override SqlWrapper OrderBy(MethodCallExpression expression, SqlWrapper sqlWrapper, params OrderTypeEnum[] orders)
        {
            if (expression.ToObject() is IEnumerable collection)
            {
                var i = 0;

                foreach (var item in collection)
                {
                    SqlExpressionProvider.OrderBy(Expression.Constant(item), sqlWrapper);

                    if (i <= orders.Length - 1)
                        sqlWrapper += $" { (orders[i] == OrderTypeEnum.Descending ? "DESC" : "ASC")},";
                    else if (!item.ToString().ContainsIgnoreCase("ASC", "DESC"))
                        sqlWrapper += " ASC,";
                    else
                        sqlWrapper += ",";

                    i++;
                }

                sqlWrapper.RemoveLast(',');
            }

            return sqlWrapper;
        }
        #endregion
    }
}