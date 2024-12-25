using System.Text.RegularExpressions;
using EIS.Shared.Enums;

namespace EIS.Shared.Extensions
{
    public static class StringExtensions
    {
        #region 空判断

        /// <summary>
        /// </summary>
        /// <param name="inputStr"></param>
        /// <returns></returns>
        public static bool IsNullOrEmpty(this string inputStr)
        {
            return string.IsNullOrEmpty(inputStr);
        }

        /// <summary>
        /// 判断集合是否为空
        /// </summary>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="this">The collection to act on.</param>
        /// <returns>true if a null or is t>, false if not.</returns>
        public static bool IsNullOrEmpty<T>(this IEnumerable<T> @this)
        {
            return @this == null || !@this.Any();
        }
        
        /// <summary>
        /// </summary>
        /// <param name="inputStr"></param>
        /// <returns></returns>
        public static bool IsNullOrWhiteSpace(this string inputStr)
        {
            return string.IsNullOrWhiteSpace(inputStr);
        }

        /// <summary>
        /// </summary>
        /// <param name="inputStr"></param>
        /// <returns></returns>
        public static bool IsNotNullOrEmpty(this string inputStr)
        {
            return !string.IsNullOrEmpty(inputStr);
        }

        /// <summary>
        /// </summary>
        /// <param name="inputStr"></param>
        /// <returns></returns>
        public static bool IsNotNullOrWhiteSpace(this string inputStr)
        {
            return !string.IsNullOrWhiteSpace(inputStr);
        }

        /// <summary>
        /// 判断集合是否不为空
        /// </summary>
        /// <typeparam name="T">Generic type parameter.</typeparam>
        /// <param name="this">The collection to act on.</param>
        /// <returns>true if a not null or is t>, false if not.</returns>
        public static bool IsNotNullOrEmpty<T>(this IEnumerable<T> @this)
        {
            return @this != null && @this.Any();
        }
        #endregion

        #region 常用正则表达式

        private static readonly Regex EmailRegex = new Regex(@"\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*", RegexOptions.IgnoreCase);

        private static readonly Regex MobileRegex = new Regex("^1[0-9]{10}$");

        private static readonly Regex PhoneRegex = new Regex(@"^(\d{3,4}-?)?\d{7,8}$");

        private static readonly Regex IpRegex = new Regex(@"^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$");

        private static readonly Regex DateRegex = new Regex(@"(\d{4})-(\d{1,2})-(\d{1,2})");

        private static readonly Regex NumericRegex = new Regex(@"^[-]?[0-9]+(\.[0-9]+)?$");

        private static readonly Regex ZipcodeRegex = new Regex(@"^\d{6}$");

        private static readonly Regex IdRegex = new Regex(@"^[1-9]\d{16}[\dXx]$");

        /// <summary>
        /// 是否中文
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static bool IsChinese(this string str)
        {
            return Regex.IsMatch(@"^[\u4e00-\u9fa5]+$", str);
        }

        /// <summary>
        /// 是否为邮箱名
        /// </summary>
        public static bool IsEmail(this string s)
        {
            if (string.IsNullOrEmpty(s))
                return false;
            return EmailRegex.IsMatch(s);
        }

        /// <summary>
        /// 是否为手机号
        /// </summary>
        public static bool IsMobile(this string s)
        {
            if (string.IsNullOrEmpty(s))
                return false;
            return MobileRegex.IsMatch(s);
        }

        /// <summary>
        /// 是否为固话号
        /// </summary>
        public static bool IsPhone(this string s)
        {
            if (string.IsNullOrEmpty(s))
                return false;
            return PhoneRegex.IsMatch(s);
        }

        /// <summary>
        /// 是否为IP
        /// </summary>
        public static bool IsIp(this string s)
        {
            return IpRegex.IsMatch(s);
        }

        /// <summary>
        /// 是否是身份证号
        /// </summary>
        public static bool IsIdCard(this string idCard)
        {
            if (string.IsNullOrEmpty(idCard))
                return false;
            return IdRegex.IsMatch(idCard);
        }

        /// <summary>
        /// 是否为日期
        /// </summary>
        public static bool IsDate(this string s)
        {
            return DateRegex.IsMatch(s);
        }

        /// <summary>
        /// 是否是数值(包括整数和小数)
        /// </summary>
        public static bool IsNumeric(this string numericStr)
        {
            return NumericRegex.IsMatch(numericStr);
        }

        /// <summary>
        /// 是否为邮政编码
        /// </summary>
        public static bool IsZipCode(this string s)
        {
            if (string.IsNullOrEmpty(s))
                return true;
            return ZipcodeRegex.IsMatch(s);
        }

        /// <summary>
        /// 是否是图片文件名
        /// </summary>
        /// <param name="fileName"></param>
        /// <returns></returns>
        public static bool IsImgFileName(this string fileName)
        {
            var suffix = new List<string>() { ".jpg", ".jpeg", ".png" };

            var fileSuffix = Path.GetExtension(fileName).ToLower();

            return suffix.Contains(fileSuffix);
        }

        #endregion

        #region 字符串截取

        /// <summary>
        /// </summary>
        /// <param name="inputStr"></param>
        /// <param name="length"></param>
        /// <returns></returns>
        public static string Sub(this string inputStr, int length)
        {
            if (inputStr.IsNullOrEmpty())
                return null;

            return inputStr.Length >= length ? inputStr.Substring(0, length) : inputStr;
        }

        /// <summary>
        /// </summary>
        /// <param name="inputStr"></param>
        /// <param name="oldStr"></param>
        /// <param name="newStr"></param>
        /// <returns></returns>
        public static string TryReplace(this string inputStr, string oldStr, string newStr)
        {
            return inputStr.IsNullOrEmpty() ? inputStr : inputStr.Replace(oldStr, newStr);
        }

        /// <summary>
        /// </summary>
        /// <param name="inputStr"></param>
        /// <param name="pattern"></param>
        /// <param name="replacement"></param>
        /// <returns></returns>
        public static string RegexReplace(this string inputStr, string pattern, string replacement)
        {
            return inputStr.IsNullOrEmpty() ? inputStr : Regex.Replace(inputStr, pattern, replacement);
        }

        #endregion

        #region Format

        /// <summary>
        /// Format
        /// </summary>
        /// <param name="format"></param>
        /// <param name="arg0"></param>
        /// <param name="arg1"></param>
        /// <returns></returns>
        public static string Format(this string format, object arg0, object arg1)
        {
            return string.Format(format, arg0, arg1);
        }

        /// <summary>
        /// Format
        /// </summary>
        /// <param name="format"></param>
        /// <param name="args"></param>
        /// <returns></returns>
        public static string Format(this string format, object[] args)
        {
            return string.Format(format, args);
        }

        /// <summary>
        /// Format
        /// </summary>
        /// <param name="format"></param>
        /// <param name="arg0"></param>
        /// <param name="arg1"></param>
        /// <param name="arg2"></param>
        /// <returns></returns>
        public static string Format(this string format, object arg0, object arg1, object arg2)
        {
            return string.Format(format, arg0, arg1, arg2);
        }

        /// <summary>
        /// Format
        /// </summary>
        /// <param name="format"></param>
        /// <param name="arg0"></param>
        /// <returns></returns>
        public static string Format(this string format, object arg0)
        {
            return string.Format(format, arg0);
        }

        /// <summary>
        /// FormatWith
        /// </summary>
        /// <param name="this"></param>
        /// <param name="values"></param>
        /// <returns></returns>
        public static string FormatWith(this string @this, params object[] values)
        {
            return string.Format(@this, values);
        }

        /// <summary>
        /// FormatWith
        /// </summary>
        /// <param name="this"></param>
        /// <param name="arg0"></param>
        /// <param name="arg1"></param>
        /// <param name="arg2"></param>
        /// <returns></returns>
        public static string FormatWith(this string @this, object arg0, object arg1, object arg2)
        {
            return string.Format(@this, arg0, arg1, arg2);
        }

        /// <summary>
        /// FormatWith
        /// </summary>
        /// <param name="this"></param>
        /// <param name="arg0"></param>
        /// <param name="arg1"></param>
        /// <returns></returns>
        public static string FormatWith(this string @this, object arg0, object arg1)
        {
            return string.Format(@this, arg0, arg1);
        }

        /// <summary>
        /// FormatWith
        /// </summary>
        /// <param name="this"></param>
        /// <param name="arg0"></param>
        /// <returns></returns>
        public static string FormatWith(this string @this, object arg0)
        {
            return string.Format(@this, arg0);
        }

        #endregion
        
        #region Substring
        /// <summary>
        /// 忽略大小写从分隔符开始向尾部截取字符串，不包含分隔符字符串
        /// </summary>
        /// <param name="this">源字符串</param>
        /// <param name="separator">分隔符</param>
        /// <param name="lastIndexOf">true：从最后一个匹配的分隔符开始截取，false：从第一个匹配的分隔符开始截取，默认：true</param>
        /// <returns>string</returns>
        public static string SubstringIgnoreCase(this string @this, string separator, bool lastIndexOf = true)
        {
            return @this.Substring(separator, lastIndexOf, StringComparison.OrdinalIgnoreCase);
        }

        /// <summary>
        /// 忽略大小写根据开始和结束字符串截取字符串，不包含开始和结束字符串
        /// </summary>
        /// <param name="this">源字符串</param>
        /// <param name="start">开始字符串</param>
        /// <param name="end">结束字符串</param>
        /// <param name="startIsIndexOf">开始字符串是否是IndexOf，默认true，否则LastIndexOf</param>
        /// <param name="endIsIndexOf">结束字符串是否是IndexOf，默认true，否则LastIndexOf</param>
        /// <returns>string</returns>
        public static string SubstringIgnoreCase(this string @this, string start, string end, bool startIsIndexOf = true, bool endIsIndexOf = true)
        {
            return @this.Substring(start, end, startIsIndexOf, endIsIndexOf, StringComparison.OrdinalIgnoreCase);
        }

        /// <summary>
        /// 从分隔符开始向尾部截取字符串，不包含分隔符字符串
        /// </summary>
        /// <param name="this">源字符串</param>
        /// <param name="separator">分隔符</param>
        /// <param name="lastIndexOf">true：从最后一个匹配的分隔符开始截取，false：从第一个匹配的分隔符开始截取，默认：true</param>
        /// <param name="comparisonType">字符串比较类型，默认区分大小写</param>
        /// <returns>string</returns>
        public static string Substring(this string @this, string separator, bool lastIndexOf = true, StringComparison comparisonType = StringComparison.Ordinal)
        {
            if (@this.IsNullOrEmpty())
                return string.Empty;

            if (separator.IsNullOrEmpty())
                return string.Empty;

            //分隔符索引
            var startIndex = lastIndexOf
                ? @this.LastIndexOf(separator, comparisonType)
                : @this.IndexOf(separator, comparisonType);

            if (startIndex == -1)
                return string.Empty;

            startIndex += separator.Length;

            //截取长度
            var length = @this.Length - startIndex;

            return @this.Substring(startIndex, length);
        }

        /// <summary>
        /// 根据开始和结束字符串截取字符串，不包含开始和结束字符串
        /// </summary>
        /// <param name="this">源字符串</param>
        /// <param name="start">开始字符串</param>
        /// <param name="end">结束字符串</param>
        /// <param name="startIsIndexOf">开始字符串是否是IndexOf，默认true，否则LastIndexOf</param>
        /// <param name="endIsIndexOf">结束字符串是否是IndexOf，默认true，否则LastIndexOf</param>
        /// <param name="comparisonType">字符串比较类型，默认区分大小写</param>
        /// <returns>string</returns>
        public static string Substring(this string @this, string start, string end, bool startIsIndexOf = true, bool endIsIndexOf = true, StringComparison comparisonType = StringComparison.Ordinal)
        {
            if (@this.IsNullOrEmpty())
                return string.Empty;

            if (start.IsNullOrEmpty())
                return string.Empty;

            if (end.IsNullOrEmpty())
                return string.Empty;

            //开始字符串索引

            var startIndex = startIsIndexOf ? @this.IndexOf(start, comparisonType) : @this.LastIndexOf(start, comparisonType);

            if (startIndex == -1)
                return string.Empty;

            startIndex += start.Length;

            //结束字符串索引

            var endIndex = endIsIndexOf ? @this.IndexOf(end, startIndex, comparisonType) : @this.LastIndexOf(end, comparisonType);

            if (endIndex == -1)
                return string.Empty;

            //截取长度
            var length = endIndex - startIndex;

            if (length < 0)
                return string.Empty;

            return @this.Substring(startIndex, length);
        }
        #endregion
        
        #region SqlInject
        /// <summary>
        /// 判断是否sql注入
        /// </summary>
        /// <param name="this">sql字符串</param>
        /// <param name="pattern">正则表达式</param>
        /// <returns></returns>
        public static bool IsSqlInject(this string @this, string pattern = @"(?:')|(?:--)|(/\*(?:.|[\n\r])*?\*/)|(\b(select|update|union|and|or|delete|insert|trancate|char|into|substr|ascii|declare|exec|count|master|into|drop|execute)\b)")
        {
            if (@this.IsNullOrEmpty())
                return false;
            return Regex.IsMatch(@this, pattern, RegexOptions.IgnoreCase);
        }

        /// <summary>
        /// 正则表达式替换sql
        /// </summary>
        /// <param name="this">sql字符串</param>
        /// <param name="pattern">正则表达式</param>
        /// <returns></returns>
        public static string ReplaceSqlWithRegex(this string @this, string pattern = @"(?:')|(?:--)|(/\*(?:.|[\n\r])*?\*/)|(\b(select|update|union|and|or|delete|insert|trancate|char|into|substr|ascii|declare|exec|count|master|into|drop|execute)\b)")
        {
            if (@this.IsNullOrEmpty())
                return @this;
            return Regex.Replace(@this, pattern, "");
        }
        #endregion

        #region Contains

        /// <summary>
        /// 判断是否包含目标字符串，区分大小写，任意一个满足即可
        /// </summary>
        /// <param name="this">源字符串</param>
        /// <param name="strs">目标字符串数组"</param>
        /// <returns></returns>
        public static bool Contains(this string @this, params string[] strs)
        {
            return @this.Contains(MatchTypeEnum.Any, strs);
        }

        /// <summary>
        /// 判断是否包含目标字符串，区分大小写
        /// </summary>
        /// <param name="this">源字符串</param>
        /// <param name="type">匹配类型</param>
        /// <param name="strs">目标字符串数组"</param>
        /// <returns></returns>
        public static bool Contains(this string @this, MatchTypeEnum type, params string[] strs)
        {
            if (@this.IsNullOrEmpty())
                return false;

            if (strs.IsNullOrEmpty())
                return false;

            foreach (var item in strs)
            {
                if (type == MatchTypeEnum.Any)
                {
                    if (item != null && @this.Contains(item))
                        return true;
                }
                else
                {
                    if (item == null || !@this.Contains(item))
                        return false;
                }
            }

            if (type == MatchTypeEnum.Any)
                return false;

            return true;
        }

        /// <summary>
        /// 正则判断是否包含目标字符串
        /// </summary>
        /// <param name="this">源字符串</param>
        /// <param name="value">目标字符串，例如：判断是否包含ASC或DESC为@"(/\*(?:|)*?\*/)|(\b(ASC|DESC)\b)"</param>
        /// <param name="options">匹配模式</param>
        /// <returns></returns>
        public static bool Contains(this string @this, string value, RegexOptions options)
        {
            return Regex.IsMatch(@this, value, options);
        }
        #endregion

        #region ContainsIgnoreCase
        /// <summary>
        /// 忽略大小写的字符串包含比较，任意一个满足即可
        /// </summary>
        /// <param name="this">源字符串</param>
        /// <param name="strs">目标字符串数组</param>
        /// <returns></returns>
        public static bool ContainsIgnoreCase(this string @this, params string[] strs)
        {
            return @this.ContainsIgnoreCase(MatchTypeEnum.Any, strs);
        }

        /// <summary>
        /// 忽略大小写的字符串包含比较
        /// </summary>
        /// <param name="this">源字符串</param>
        /// <param name="type">匹配类型</param>
        /// <param name="strs">目标字符串数组</param>
        /// <returns></returns>
        public static bool ContainsIgnoreCase(this string @this, MatchTypeEnum type, params string[] strs)
        {
            if (@this.IsNullOrEmpty())
                return false;

            if (strs.IsNullOrEmpty())
                return false;

            foreach (var item in strs)
            {
                if (type == MatchTypeEnum.Any)
                {
                    if (item.IsNotNull() && @this.IndexOf(item, StringComparison.OrdinalIgnoreCase) >= 0)
                        return true;
                }
                else
                {
                    if (item.IsNull() || @this.IndexOf(item, StringComparison.OrdinalIgnoreCase) < 0)
                        return false;
                }
            }

            if (type == MatchTypeEnum.Any)
                return false;

            return true;
        }
        #endregion

        #region Equals
        /// <summary>
        /// 字符串相等比较，判断是否以任意一个待比较字符串相等
        /// </summary>
        /// <param name="this">当前字符串</param>
        /// <param name="ignoreCase">是否忽略大小写</param>
        /// <param name="strs">待比较字符串数组</param>
        /// <returns></returns>
        public static bool Equals(this string @this, bool ignoreCase, params string[] strs)
        {
            if (strs.IsNotNullOrEmpty())
            {
                foreach (var item in strs)
                {
                    if (ignoreCase)
                    {
                        if (string.Equals(@this, item, StringComparison.OrdinalIgnoreCase))
                            return true;
                    }
                    else
                    {
                        if (string.Equals(@this, item))
                            return true;
                    }
                }
            }

            return false;
        }
        #endregion

        #region EqualIgnoreCase
        /// <summary>
        /// 忽略大小写的字符串相等比较，判断是否以任意一个待比较字符串相等
        /// </summary>
        /// <param name="this">当前字符串</param>
        /// <param name="strs">待比较字符串数组</param>
        /// <returns>bool</returns>
        public static bool EqualIgnoreCase(this string @this, params string[] strs)
        {
            if (strs.IsNotNullOrEmpty())
            {
                foreach (var item in strs)
                {
                    if (string.Equals(@this, item, StringComparison.OrdinalIgnoreCase))
                        return true;
                }
            }

            return false;
        }
        #endregion

        #region StartsWithIgnoreCase
        /// <summary>
        /// 忽略大小写的字符串开始比较，判断是否以任意一个待比较字符串开始
        /// </summary>
        /// <param name="this">当前字符串</param>
        /// <param name="strs">待比较字符串数组</param>
        /// <returns>bool</returns>
        public static bool StartsWithIgnoreCase(this string @this, params string[] strs)
        {
            if (@this.IsNullOrEmpty())
                return false;

            if (strs.IsNotNullOrEmpty())
            {
                foreach (var item in strs)
                {
                    if (item != null && @this.StartsWith(item, StringComparison.OrdinalIgnoreCase))
                        return true;
                }
            }

            return false;
        }
        #endregion

        #region EndsWithIgnoreCase
        /// <summary>
        /// 忽略大小写的字符串结束比较，判断是否以任意一个待比较字符串结束
        /// </summary>
        /// <param name="this">当前字符串</param>
        /// <param name="strs">待比较字符串数组</param>
        /// <returns>bool</returns>
        public static bool EndsWithIgnoreCase(this string @this, params string[] strs)
        {
            if (@this.IsNullOrEmpty())
                return false;

            if (strs.IsNotNullOrEmpty())
            {
                foreach (var item in strs)
                {
                    if (item != null && @this.EndsWith(item, StringComparison.OrdinalIgnoreCase))
                        return true;
                }
            }

            return false;
        }
        #endregion
    }
}