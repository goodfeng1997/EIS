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
    /// 表示包含集合初始值设定项的构造函数调用
    /// </summary>
    public class ListInitExpressionResolver : BaseExpression<ListInitExpression>
    {
        #region Insert
        /// <summary>
        /// Insert
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        /// <returns>SqlWrapper</returns>
        public override SqlWrapper Insert(ListInitExpression expression, SqlWrapper sqlWrapper)
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
        public override SqlWrapper GroupBy(ListInitExpression expression, SqlWrapper sqlWrapper)
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

        #region OrderBy
        /// <summary>
        /// OrderBy
        /// </summary>
        /// <param name="expression">表达式树</param>
        /// <param name="sqlWrapper">sql包装器</param>
        /// <param name="orders">排序方式</param>
        /// <returns>SqlWrapper</returns>
        public override SqlWrapper OrderBy(ListInitExpression expression, SqlWrapper sqlWrapper, params OrderTypeEnum[] orders)
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
