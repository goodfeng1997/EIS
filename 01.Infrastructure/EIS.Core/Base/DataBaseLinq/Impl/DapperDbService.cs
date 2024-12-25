using System.Linq.Expressions;
using Dapper;
using EIS.Core.Services;
using EIS.Shared.Enums;
using EIS.Shared.ExpressionToSql.Entry;
using EIS.Shared.Extensions;

namespace EIS.Core.Base.DataBaseLinq.Impl;

public class DapperDbService(IAppDbService appDbService) : IDbService
{
    public readonly IAppDbService  AppDbService = appDbService;

    #region 查询
    /// <summary>
    /// 查询单个对象
    /// </summary>
    /// <param name="expression"></param>
    /// <param name="tenantId"></param>
    /// <typeparam name="T"></typeparam>
    /// <returns></returns>
    public async Task<T?> Query<T>(Expression<Func<T, bool>> expression, string tenantId = "") where T : class
    {
        var expressionSql = ExpressionSql.Select<T>().Where(expression);
        if (tenantId.IsNullOrWhiteSpace())
        {
            return await AppDbService.AdminHost?.QuerySingleOrDefaultAsync<T>(expressionSql.Sql,expressionSql.Parameters)!;
        }
        else
        {
            return await AppDbService[tenantId]?.QuerySingleOrDefaultAsync<T>(expressionSql.Sql,expressionSql.Parameters)!;
        }
    }
    
    /// <summary>
    /// 查询符合条件的列表
    /// </summary>
    /// <param name="expression"></param>
    /// <param name="tenantId"></param>
    /// <typeparam name="T"></typeparam>
    /// <returns></returns>
    public async Task<List<T>> QueryList<T>(Expression<Func<T, bool>> expression, string tenantId = "") where T : class
    {
        var expressionSql = ExpressionSql.Select<T>().Where(expression);
        if (tenantId.IsNullOrWhiteSpace())
        {
            return (await AppDbService.AdminHost?.QueryAsync<T>(expressionSql.Sql,expressionSql.Parameters)!).ToList();
        }
        else
        {
            return (await AppDbService[tenantId]?.QueryAsync<T>(expressionSql.Sql,expressionSql.Parameters)!).ToList();
        }
    }
    
    /// <summary>
    /// 两表查询 带查询排序及连接方式 
    /// </summary>
    /// <typeparam name="T1"></typeparam>
    /// <typeparam name="T2"></typeparam>
    /// <typeparam name="TResult"></typeparam>
    /// <param name="expression">筛选表达式</param>
    /// <param name="joinExpression">连接表达式</param>
    /// <param name="selectExpression">转化表达式</param>
    /// <param name="tenantId">转化表达式</param>
    /// <param name="joinType">0 左连接 1 右连接 2内连接</param>
    /// <param name="orderByType">排序方式（true:正向排序 false:倒向排序）</param>
    /// <param name="orderbyExpression">排序表达式</param>
    /// <returns></returns>
    public async Task<List<TResult>> QueryList<T1, T2, TResult>(Expression<Func<T1, T2, bool>> expression,
        Expression<Func<T1, T2, bool>> joinExpression,
        Expression<Func<T1, T2, TResult>> selectExpression,
        string tenantId = "",
        JoinTypeEnum joinType = JoinTypeEnum.LEFT,
        OrderTypeEnum orderByType= OrderTypeEnum.Ascending,
        Expression<Func<T1, T2, object>>? orderbyExpression = null)
        where T1 : class, new()
        where T2 : class, new()
        where TResult : class, new()
    {
        var databaseSql = tenantId.IsNullOrWhiteSpace() ? AppDbService.AdminHost : AppDbService[tenantId];
        var expressionSql = ExpressionSql.Select<T1,T2>().LeftJoin<T1,T2>(joinExpression).Where(expression).Select(selectExpression);
        return (await databaseSql?.QueryAsync<TResult>(expressionSql.Sql, expressionSql.Parameters)!).ToList(); 
    }
    #endregion
}