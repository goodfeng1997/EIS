using EIS.Shared.Response.Inf;

namespace EIS.Shared.Response
{
    public class ListResult<T> : IListResult<T>
    {
        private IReadOnlyList<T> _items;

        public IReadOnlyList<T> Items
        {
            get => _items ??= new List<T>();
            set => _items = value;
        }

        public ListResult(IReadOnlyList<T> item)
        {
            Items = item;
        }
    }
}