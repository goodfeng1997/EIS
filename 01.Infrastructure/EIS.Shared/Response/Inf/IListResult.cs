namespace EIS.Shared.Response.Inf
{
    public interface IListResult<T>
    {
        IReadOnlyList<T> Items { get; set; }
    }
}