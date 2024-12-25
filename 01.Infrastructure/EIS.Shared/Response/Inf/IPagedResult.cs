namespace EIS.Shared.Response.Inf
{
    public interface IPagedResult<T> : IListResult<T>, ITotalCount
    {
        
    }
}