using System.Text;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace EIS.Shared.Extensions;

public static class SerializeExtensions
{
    /// <summary>
    /// 将对象数据转换为指定类对象实体
    /// </summary>
    /// <typeparam name="T">需要转换成的类</typeparam>
    /// <param name="objParam"></param>
    /// <returns></returns>
    public static T FromObject<T>(this object objParam)
    {
        if (objParam == null) return default(T);
        string strParam = objParam.ToJson();
        if (string.IsNullOrEmpty(strParam)) return default(T);
        T entity = strParam.FromJson<T>();
        return entity;
    }

    /// <summary>
    /// 实体对象转JSON字符串
    /// </summary>
    /// <param name="obj"></param>
    /// <param name="ignoreNull"></param>
    /// <returns></returns>
    public static string ToJson(this object obj, bool ignoreNull = false)
    {
        return JsonConvert.SerializeObject(obj, Formatting.None, new JsonSerializerSettings
        {
            DateFormatString = "yyyy-MM-dd HH:mm:ss",
            NullValueHandling = ignoreNull ? NullValueHandling.Ignore : NullValueHandling.Include
        });
    }

    /// <summary>
    /// JSON字符串转实体对象
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="jsonStr"></param>
    /// <returns></returns>
    public static T FromJson<T>(this string jsonStr)
    {
        return jsonStr.IsNullOrEmpty() ? default : JsonConvert.DeserializeObject<T>(jsonStr);
    }
    
    /// <summary>
    /// JSON字符串转实体对象
    /// </summary>
    /// <param name="jsonStr"></param>
    /// <returns></returns>
    public static object FromJson(this string jsonStr)
    {
        return jsonStr.IsNullOrEmpty() ? default(object) : JsonConvert.DeserializeObject(jsonStr);
    }

    /// <summary>
    /// 字符串序列化成字节序列
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static byte[] SerializeUtf8(this string str)
    {
        return str == null ? null : Encoding.UTF8.GetBytes(str);
    }

    /// <summary>
    /// 字节序列序列化成字符串
    /// </summary>
    /// <param name="stream"></param>
    /// <returns></returns>
    public static string DeserializeUtf8(this byte[] stream)
    {
        return stream == null ? null : Encoding.UTF8.GetString(stream);
    }

    /// <summary>
    /// 根据key将json文件内容转换为指定对象
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="filePath"></param>
    /// <param name="key"></param>
    /// <returns></returns>
    public static async Task<T> FromJsonFile<T>(this string filePath, string key = "") where T : new()
    {
        if (!File.Exists(filePath)) return new T();

        StreamReader reader = new StreamReader(filePath);
        var json = await reader.ReadToEndAsync();

        if (string.IsNullOrEmpty(key)) return JsonConvert.DeserializeObject<T>(json);

        return !(JsonConvert.DeserializeObject<object>(json) is JObject obj)
            ? new T()
            : JsonConvert.DeserializeObject<T>(obj[key]!.ToString());
    }

    /// <summary>
    /// 根据json的key获取json的值
    /// </summary>
    /// <param name="jsonStr"></param>
    /// <param name="key"></param>
    /// <returns></returns>
    public static string GetJsonValue(this string jsonStr, string key)
    {
        JObject jsonObj = JObject.Parse(jsonStr);
        using var enumerator = jsonObj.Children().GetEnumerator();
        if (enumerator.IsNull()) return null;
        while (enumerator.MoveNext())
        {
            var jc = enumerator.Current;
            if (jc.IsNull()) continue;
            if (((JProperty)jc).Name.Equals(key))
            {
                return ((JProperty)jc).Value.ToString();
            }
        }

        return null;
    }

    /// <summary>
    /// 字符串转换为UUID
    /// </summary>
    /// <param name="uuidStr"></param>
    /// <returns></returns>
    public static Guid ToGuid(this string uuidStr)
    {
        if (Guid.TryParse(uuidStr, out var uuid))
        {
            return uuid;
        }
        return Guid.Empty;
    }
}