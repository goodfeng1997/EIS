
namespace EIS.Shared.Extensions
{
    public static class DownloadExtensions
    {
        /// <summary>
        /// 将数组类型文件保存至指定路径
        /// </summary>
        /// <param name="buffer"></param>
        /// <param name="path"></param>
        /// <returns></returns>
        public static async Task DownloadAsync(this byte[] buffer, string path)
        {
            var ms = new MemoryStream(buffer);
            var stream = new FileStream(path, FileMode.Create);

            var bytes = new byte[1024];
            var size = await ms.ReadAsync(bytes, 0, bytes.Length);
            while (size > 0)
            {
                await stream.WriteAsync(bytes, 0, size);
                size = await ms.ReadAsync(bytes, 0, bytes.Length);
            }
        }

        /// <summary>
        /// 删除指定文件
        /// </summary>
        /// <param name="deletePath"></param>
        public static void DeleteAsync(string deletePath)
        {
            if (File.Exists(deletePath))
            {
                File.Delete(deletePath);
            }
        }
    }
}