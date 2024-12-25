using System.Linq.Expressions;
using EIS.Core.Services;
using EIS.Shared.Enums;
using EIS.Shared.Extensions;

namespace EIS.Core.Base.DataBaseLinq.Impl;

public class FreeSqlDbService(IAppDbService appDbService) : IDbService
{
    public readonly IAppDbService AppDbService = appDbService;

    /// <summary>
    /// 查询单个对象
    /// </summary>
    /// <param name="expression"></param>
    /// <param name="tenantId"></param>
    /// <typeparam name="T"></typeparam>
    /// <returns></returns>
    public async Task<T?> Query<T>(Expression<Func<T, bool>> expression, string tenantId = "") where T : class
    {
        if (tenantId.IsNullOrWhiteSpace())
        {
            return await AppDbService.AdminHost?.Select<T>().Where(expression)?.ToOneAsync()!;
        }
        else
        {
            return await AppDbService[tenantId]?.Select<T>().Where(expression)?.ToOneAsync()!;
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
        if (tenantId.IsNullOrWhiteSpace())
        {
            return await AppDbService.AdminHost?.Select<T>().Where(expression)?.ToListAsync()!;
        }
        else
        {
            return await AppDbService[tenantId]?.Select<T>().Where(expression)?.ToListAsync()!;
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
        switch (joinType)
        {
            case JoinTypeEnum.LEFT when orderbyExpression == null:
                return await databaseSql.Select<T1, T2>().LeftJoin(joinExpression).Where(expression)
                    .ToListAsync(selectExpression);
            case JoinTypeEnum.LEFT when orderByType == OrderTypeEnum.Ascending:
                return await databaseSql.Select<T1, T2>().LeftJoin(joinExpression).Where(expression)
                    .OrderBy(orderbyExpression).ToListAsync(selectExpression);
            case JoinTypeEnum.LEFT:
                return await databaseSql.Select<T1, T2>().LeftJoin(joinExpression).Where(expression)
                    .OrderByDescending(orderbyExpression).ToListAsync(selectExpression);
            case JoinTypeEnum.RIGHT when orderbyExpression == null:
                return await databaseSql.Select<T1, T2>().RightJoin(joinExpression).Where(expression)
                    .ToListAsync(selectExpression);
            case JoinTypeEnum.RIGHT when orderByType == OrderTypeEnum.Ascending:
                return await databaseSql.Select<T1, T2>().RightJoin(joinExpression).Where(expression)
                    .OrderBy(orderbyExpression).ToListAsync(selectExpression);
            case JoinTypeEnum.RIGHT:
                return await databaseSql.Select<T1, T2>().RightJoin(joinExpression).Where(expression)
                    .OrderByDescending(orderbyExpression).ToListAsync(selectExpression);
            case JoinTypeEnum.INNER:
            default:
            {
                if (orderbyExpression == null)
                {
                    return await databaseSql.Select<T1, T2>().InnerJoin(joinExpression).Where(expression)
                        .ToListAsync(selectExpression);
                }

                if (orderByType == OrderTypeEnum.Ascending)
                {
                    return await databaseSql.Select<T1, T2>().InnerJoin(joinExpression).Where(expression)
                        .OrderBy(orderbyExpression).ToListAsync(selectExpression);
                }

                return await databaseSql.Select<T1, T2>().InnerJoin(joinExpression).Where(expression)
                    .OrderByDescending(orderbyExpression).ToListAsync(selectExpression);
            }
        }
    }
}