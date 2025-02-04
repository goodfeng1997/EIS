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

using Dapper;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace EIS.Shared.ExpressionToSql.Parameters
{
    /// <summary>
    /// Oracle的DynamicParameters实现，用于支持Oracle游标类型
    /// </summary>
    public class OracleDynamicParameters : SqlMapper.IDynamicParameters
    {
        /// <summary>
        /// 动态参数
        /// </summary>
        public DynamicParameters DynamicParameters { get; }

        /// <summary>
        /// Oracle参数
        /// </summary>
        public List<OracleParameter> OracleParameters { get; }

        /// <summary>
        /// 构造函数
        /// </summary>
        public OracleDynamicParameters()
        {
            DynamicParameters = new();
            OracleParameters = new();
        }

        /// <summary>
        /// 新增参数
        /// </summary>
        /// <param name="name"></param>
        /// <param name="value"></param>
        /// <param name="oracleDbType"></param>
        public void Add(string name, object value, OracleDbType? oracleDbType)
        {
            this.Add(name, oracleDbType, ParameterDirection.Input, value);
        }

        /// <summary>
        /// 新增参数
        /// </summary>
        /// <param name="name"></param>
        /// <param name="value"></param>
        /// <param name="oracleDbType"></param>
        /// <param name="size"></param>
        public void Add(string name, object value, OracleDbType? oracleDbType, int? size)
        {
            this.Add(name, oracleDbType, ParameterDirection.Input, value, size);
        }

        /// <summary>
        /// 新增参数
        /// </summary>
        /// <param name="name"></param>
        /// <param name="oracleDbType"></param>
        /// <param name="direction"></param>
        public void Add(string name, OracleDbType? oracleDbType, ParameterDirection direction)
        {
            var oracleParameter = new OracleParameter
            {
                ParameterName = name,
                Direction = direction
            };

            if (oracleDbType != null)
                oracleParameter.OracleDbType = oracleDbType.Value;

            OracleParameters.Add(oracleParameter);
        }

        /// <summary>
        /// 新增参数
        /// </summary>
        /// <param name="name"></param>
        /// <param name="oracleDbType"></param>
        /// <param name="direction"></param>
        /// <param name="value"></param>
        /// <param name="size"></param>
        public void Add(string name, OracleDbType? oracleDbType, ParameterDirection direction, object value = null, int? size = null)
        {
            var oracleParameter = new OracleParameter
            {
                ParameterName = name,
                Value = value,
                Direction = direction
            };

            if (oracleDbType != null)
                oracleParameter.OracleDbType = oracleDbType.Value;

            if (size != null)
                oracleParameter.Size = size.Value;

            OracleParameters.Add(oracleParameter);
        }

        /// <summary>
        /// 新增参数
        /// </summary>
        /// <param name="command"></param>
        /// <param name="identity"></param>
        public void AddParameters(IDbCommand command, SqlMapper.Identity identity)
        {
            ((SqlMapper.IDynamicParameters)DynamicParameters).AddParameters(command, identity);

            if (command is OracleCommand oracleCommand)
                oracleCommand.Parameters.AddRange(OracleParameters.ToArray());
        }
    }
}
