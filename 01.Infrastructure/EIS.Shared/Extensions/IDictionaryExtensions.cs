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
using MySqlConnector;
using Npgsql;
using Oracle.ManagedDataAccess.Client;
using EIS.Shared.ExpressionToSql.Attributes;
using EIS.Shared.ExpressionToSql.Parameters;
using System.Data.Common;
using System.Data.SQLite;
using Microsoft.Data.SqlClient;
using static Dapper.SqlMapper;

namespace EIS.Shared.Extensions
{
    /// <summary>
    /// IDictionary扩展类
    /// </summary>
    public static class IDictionaryExtensions
    {
        #region ToDynamicParameters
        /// <summary>
        /// DbParameter转换为DynamicParameters
        /// </summary>
        /// <param name="this"></param>
        /// <returns></returns>
        public static IDynamicParameters ToDynamicParameters(this DbParameter[] @this)
        {
            if (@this == null || @this.Length == 0)
                return null;

            var args = new DynamicParameters();
            @this.ToList().ForEach(p => args.Add(p.ParameterName, p.Value, p.DbType, p.Direction, p.Size));
            return args;
        }

        /// <summary>
        /// DbParameter转换为DynamicParameters
        /// </summary>
        /// <param name="this"></param>
        /// <returns></returns>
        public static IDynamicParameters ToDynamicParameters(this List<DbParameter> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            var args = new DynamicParameters();
            @this.ForEach(p => args.Add(p.ParameterName, p.Value, p.DbType, p.Direction, p.Size));
            return args;
        }

        /// <summary>
        ///  DbParameter转换为DynamicParameters
        /// </summary>
        /// <param name="this"></param>
        /// <returns></returns>
        public static IDynamicParameters ToDynamicParameters(this DbParameter @this)
        {
            if (@this == null)
                return null;

            var args = new DynamicParameters();
            args.Add(@this.ParameterName, @this.Value, @this.DbType, @this.Direction, @this.Size);
            return args;
        }

        /// <summary>
        ///  IDictionary转换为DynamicParameters
        /// </summary>
        /// <param name="this"></param>        
        /// <returns></returns>
        public static IDynamicParameters ToDynamicParameters(this IDictionary<string, object> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            var args = new DynamicParameters();
            foreach (var item in @this)
                args.Add(item.Key, item.Value);

            return args;
        }

        /// <summary>
        ///  IDictionary转换为DynamicParameters
        /// </summary>
        /// <param name="this"></param>        
        /// <returns></returns>
        public static IDynamicParameters ToDynamicParameters(this IDictionary<string, (object data, DataTypeAttribute type)> @this)
        {
            if (@this.IsNull() || @this.Count == 0)
                return null;

            //OracleDbType
            if (@this.Values.Any(x => x.type?.IsOracleDbType == true))
            {
                var parameter = new OracleDynamicParameters();

                foreach (var item in @this)
                    parameter.Add(item.Key, item.Value.data,
                        item.Value.type?.IsOracleDbType == true
                            ? item.Value.type.OracleDbType
                            : null,
                        item.Value.type?.IsFixedLength == true
                            ? item.Value.type.FixedLength
                            : null);

                return parameter;
            }
            //DbType
            else
            {
                var parameter = new DynamicParameters();

                foreach (var item in @this)
                    parameter.Add(item.Key, item.Value.data,
                        item.Value.type?.IsDbType == true
                            ? item.Value.type.DbType
                            : null,
                        size: item.Value.type?.IsFixedLength == true
                            ? item.Value.type.FixedLength
                            : null);

                return parameter;
            }
        }
        #endregion

        #region ToDbParameters
        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts this object to a database parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>
        /// <param name="command">The command.</param>        
        /// <returns>The given data converted to a DbParameter[].</returns>
        public static DbParameter[] ToDbParameters(this IDictionary<string, object> @this, DbCommand command)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x =>
            {
                var parameter = command.CreateParameter();
                parameter.ParameterName = x.Key;
                parameter.Value = x.Value;

                return parameter;

            }).ToArray();
        }

        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts this object to a database parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>
        /// <param name="command">The command.</param>        
        /// <returns>The given data converted to a DbParameter[].</returns>
        public static DbParameter[] ToDbParameters(this IDictionary<string, (object data, DataTypeAttribute type)> @this, DbCommand command)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x =>
            {
                var parameter = command.CreateParameter();
                parameter.ParameterName = x.Key;
                parameter.Value = x.Value.data;

                if (x.Value.type == null)
                    return parameter;

                if (x.Value.type.IsDbType)
                    parameter.DbType = x.Value.type.DbType;

                if (x.Value.type.IsFixedLength)
                    parameter.Size = x.Value.type.FixedLength;

                return parameter;

            }).ToArray();
        }

        /// <summary>
        ///  An IDictionary&lt;string,object&gt; extension method that converts this object to a database parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>
        /// <param name="connection">The connection.</param>        
        /// <returns>The given data converted to a DbParameter[].</returns>
        public static DbParameter[] ToDbParameters(this IDictionary<string, object> @this, DbConnection connection)
        {
            if (@this == null || @this.Count == 0)
                return null;

            var command = connection.CreateCommand();
            return @this.Select(x =>
            {
                var parameter = command.CreateParameter();
                parameter.ParameterName = x.Key;
                parameter.Value = x.Value;

                return parameter;

            }).ToArray();
        }

        /// <summary>
        ///  An IDictionary&lt;string,object&gt; extension method that converts this object to a database parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>
        /// <param name="connection">The connection.</param>        
        /// <returns>The given data converted to a DbParameter[].</returns>
        public static DbParameter[] ToDbParameters(this IDictionary<string, (object data, DataTypeAttribute type)> @this, DbConnection connection)
        {
            if (@this == null || @this.Count == 0)
                return null;

            var command = connection.CreateCommand();
            return @this.Select(x =>
            {
                var parameter = command.CreateParameter();
                parameter.ParameterName = x.Key;
                parameter.Value = x.Value.data;

                if (x.Value.type == null)
                    return parameter;

                if (x.Value.type.IsDbType)
                    parameter.DbType = x.Value.type.DbType;

                if (x.Value.type.IsFixedLength)
                    parameter.Size = x.Value.type.FixedLength;

                return parameter;

            }).ToArray();
        }
        #endregion

        #region ToSqlParameters
        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts the @this to a SQL parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>        
        /// <returns>@this as a SqlParameter[].</returns>
        public static SqlParameter[] ToSqlParameters(this IDictionary<string, object> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x => new SqlParameter(x.Key.Replace("?", "@").Replace(":", "@"), x.Value)).ToArray();
        }

        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts the @this to a SQL parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>        
        /// <returns>@this as a SqlParameter[].</returns>
        public static SqlParameter[] ToSqlParameters(this IDictionary<string, (object data, DataTypeAttribute type)> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x =>
            {
                var parameter = new SqlParameter(x.Key.Replace("?", "@").Replace(":", "@"), x.Value.data);

                if (x.Value.type == null)
                    return parameter;

                if (x.Value.type.IsDbType)
                    parameter.DbType = x.Value.type.DbType;

                if (x.Value.type.IsSqlDbType)
                    parameter.SqlDbType = x.Value.type.SqlDbType;

                if (x.Value.type.IsFixedLength)
                    parameter.Size = x.Value.type.FixedLength;

                return parameter;

            }).ToArray();
        }
        #endregion

        #region ToMySqlParameters
        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts the @this to a MySQL parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>        
        /// <returns>@this as a MySqlParameter[].</returns>
        public static MySqlParameter[] ToMySqlParameters(this IDictionary<string, object> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x => new MySqlParameter(x.Key.Replace("@", "?").Replace(":", "?"), x.Value)).ToArray();
        }

        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts the @this to a MySQL parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>        
        /// <returns>@this as a MySqlParameter[].</returns>
        public static MySqlParameter[] ToMySqlParameters(this IDictionary<string, (object data, DataTypeAttribute type)> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x =>
            {
                var parameter = new MySqlParameter(x.Key.Replace("@", "?").Replace(":", "?"), x.Value.data);

                if (x.Value.type == null)
                    return parameter;

                if (x.Value.type.IsDbType)
                    parameter.DbType = x.Value.type.DbType;

                if (x.Value.type.IsMySqlDbType)
                    parameter.MySqlDbType = x.Value.type.MySqlDbType;

                if (x.Value.type.IsFixedLength)
                    parameter.Size = x.Value.type.FixedLength;

                return parameter;

            }).ToArray();
        }
        #endregion

        #region ToSqliteParameters
        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts the @this to a Sqlite parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>        
        /// <returns>@this as a SQLiteParameter[].</returns>
        public static SQLiteParameter[] ToSqliteParameters(this IDictionary<string, object> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x => new SQLiteParameter(x.Key.Replace("?", "@").Replace(":", "@"), x.Value)).ToArray();
        }

        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts the @this to a Sqlite parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>        
        /// <returns>@this as a SQLiteParameter[].</returns>
        public static SQLiteParameter[] ToSqliteParameters(this IDictionary<string, (object data, DataTypeAttribute type)> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x =>
            {
                var parameter = new SQLiteParameter(x.Key.Replace("?", "@").Replace(":", "@"), x.Value.data);

                if (x.Value.type == null)
                    return parameter;

                if (x.Value.type.IsDbType)
                    parameter.DbType = x.Value.type.DbType;

                if (x.Value.type.IsFixedLength)
                    parameter.Size = x.Value.type.FixedLength;

                return parameter;

            }).ToArray();
        }
        #endregion

        #region ToOracleParameters
        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts the @this to a Oracle parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>        
        /// <returns>@this as a OracleParameter[].</returns>
        public static OracleParameter[] ToOracleParameters(this IDictionary<string, object> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x => new OracleParameter(x.Key.Replace("?", ":").Replace("@", ":"), x.Value)).ToArray();
        }

        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts the @this to a Oracle parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>        
        /// <returns>@this as a OracleParameter[].</returns>
        public static OracleParameter[] ToOracleParameters(this IDictionary<string, (object data, DataTypeAttribute type)> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x =>
            {
                var parameter = new OracleParameter(x.Key.Replace("?", ":").Replace("@", ":"), x.Value.data);

                if (x.Value.type == null)
                    return parameter;

                if (x.Value.type.IsDbType)
                    parameter.DbType = x.Value.type.DbType;

                if (x.Value.type.IsOracleDbType)
                    parameter.OracleDbType = x.Value.type.OracleDbType;

                if (x.Value.type.IsFixedLength)
                    parameter.Size = x.Value.type.FixedLength;

                return parameter;

            }).ToArray();
        }
        #endregion

        #region ToNpgsqlParameters
        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts the @this to a PostgreSQL parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>        
        /// <returns>@this as a NpgsqlParameter[].</returns>
        public static NpgsqlParameter[] ToNpgsqlParameters(this IDictionary<string, object> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x => new NpgsqlParameter(x.Key.Replace("?", ":").Replace("@", ":"), x.Value)).ToArray();
        }

        /// <summary>
        /// An IDictionary&lt;string,object&gt; extension method that converts the @this to a PostgreSQL parameters.
        /// </summary>
        /// <param name="this">The @this to act on.</param>        
        /// <returns>@this as a NpgsqlParameter[].</returns>
        public static NpgsqlParameter[] ToNpgsqlParameters(this IDictionary<string, (object data, DataTypeAttribute type)> @this)
        {
            if (@this == null || @this.Count == 0)
                return null;

            return @this.Select(x =>
            {
                var parameter = new NpgsqlParameter(x.Key.Replace("?", ":").Replace("@", ":"), x.Value.data);

                if (x.Value.type == null)
                    return parameter;

                if (x.Value.type.IsDbType)
                    parameter.DbType = x.Value.type.DbType;

                if (x.Value.type.IsNpgsqlDbType)
                    parameter.NpgsqlDbType = x.Value.type.NpgsqlDbType;

                if (x.Value.type.IsFixedLength)
                    parameter.Size = x.Value.type.FixedLength;

                return parameter;

            }).ToArray();
        }
        #endregion
    }
}
