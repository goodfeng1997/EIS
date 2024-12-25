using EIS.Shared.Response.Inf;

namespace EIS.Shared.Response
{
    public class PagedResult<T> : ListResult<T>, IPagedResult<T>
    {
        public int Total { get; set; }

        public PagedResult(int total, IReadOnlyList<T> result) : base(result)
        {
            Total = total;
        }
    }
}