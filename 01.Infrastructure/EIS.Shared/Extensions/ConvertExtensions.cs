﻿using System.Globalization;

namespace EIS.Shared.Extensions
{
    public static class ConvertExtensions
    {
        /// <summary>
        /// string转int
        /// </summary>
        /// <param name="input">输入</param>
        /// <param name="defaultNumber">转换失败默认</param>
        /// <returns></returns>
        public static int TryToInt(this object  input, int defaultNumber = 0)
        {
            if (input == null)
                return defaultNumber;

            return int.TryParse(input.ToString(), out var number) ? number : defaultNumber;
        }

        /// <summary>
        /// string转long
        /// </summary>
        /// <param name="input">输入</param>
        /// <param name="defaultNumber">转换失败默认</param>
        /// <returns></returns>
        public static long TryToLong(this object input, long defaultNumber = 0)
        {
            if (input == null)
                return defaultNumber;

            return long.TryParse(input.ToString(), out var number) ? number : defaultNumber;
        }

        /// <summary>
        /// string转double
        /// </summary>
        /// <param name="input">输入</param>
        /// <param name="defaultNumber">转换失败默认值</param>
        /// <returns></returns>
        public static double TryToDouble(this object input, double defaultNumber = 0)
        {
            if (input == null)
                return defaultNumber;

            return double.TryParse(input.ToString(), out var number) ? number : defaultNumber;
        }

        /// <summary>
        /// string转decimal
        /// </summary>
        /// <param name="input">输入</param>
        /// <param name="defaultNumber">转换失败默认值</param>
        /// <returns></returns>
        public static decimal TryToDecimal(this object input, decimal defaultNumber = 0)
        {
            if (input == null)
                return defaultNumber;

            return decimal.TryParse(input.ToString(), out var number) ? number : defaultNumber;
        }

        /// <summary>
        /// string转decimal
        /// </summary>
        /// <param name="input">输入</param>
        /// <param name="defaultNumber">转换失败默认值</param>
        /// <returns></returns>
        public static float TryToFloat(this object input, float defaultNumber = 0)
        {
            if (input == null)
                return defaultNumber;

            return float.TryParse(input.ToString(), out var number) ? number : defaultNumber;
        }

        /// <summary>
        /// string转bool
        /// </summary>
        /// <param name="input">输入</param>
        /// <param name="falseVal"></param>
        /// <param name="defaultBool">转换失败默认值</param>
        /// <param name="trueVal"></param>
        /// <returns></returns>
        public static bool TryToBool(this object input, bool defaultBool = false, string trueVal = "1", string falseVal = "0")
        {
            if (input == null)
                return defaultBool;

            var str = input.ToString();
            if (bool.TryParse(str, out var outBool))
                return outBool;

            outBool = defaultBool;

            if (trueVal == str)
                return true;
            if (falseVal == str)
                return false;

            return outBool;
        }

        /// <summary>
        /// 值类型转string
        /// </summary>
        /// <param name="inputObj">输入</param>
        /// <param name="defaultStr">转换失败默认值</param>
        /// <returns></returns>
        public static string TryToString(this ValueType inputObj, string defaultStr = "")
        {
            var output = inputObj.IsNull() ? defaultStr : inputObj.ToString();
            return output;
        }

        /// <summary>
        /// 字符串转时间
        /// </summary>
        /// <param name="inputStr">输入</param>
        /// <param name="defaultValue">默认值</param>
        /// <returns></returns>
        public static DateTime TryToDateTime(this string inputStr, DateTime defaultValue = default)
        {
            if (inputStr.IsNullOrEmpty())
                return defaultValue;

            return DateTime.TryParse(inputStr, out var outPutDateTime) ? outPutDateTime : defaultValue;
        }

        /// <summary>
        /// 字符串转时间
        /// </summary>
        /// <param name="inputStr">输入</param>
        /// <param name="formater"></param>
        /// <param name="defaultValue">默认值</param>
        /// <returns></returns>
        public static DateTime TryToDateTime(this string inputStr, string formater, DateTime defaultValue = default)
        {
            if (inputStr.IsNullOrEmpty())
                return defaultValue;

            return DateTime.TryParseExact(inputStr, formater, CultureInfo.InvariantCulture, DateTimeStyles.None, out var outPutDateTime) ? outPutDateTime : defaultValue;
        }

        /// <summary>
        /// 时间戳转时间
        /// </summary>
        /// <param name="timestamp"></param>
        /// <returns></returns>
        public static DateTime TryToDateTime(this string timestamp)
        {
            var ticks = 621355968000000000 + long.Parse(timestamp) * 10000;
            return new DateTime(ticks);
        }

        /// <summary>
        /// 时间格式转换为字符串
        /// </summary>
        /// <param name="date"></param>
        /// <param name="format"></param>
        /// <param name="cultureInfo"></param>
        /// <returns></returns>
        public static string TryToDateTime(this DateTime date, string formater = "MMMM dd, yyyy HH:mm:ss", string cultureInfo = "en-us")
        {
            return date.ToString(formater, new CultureInfo(cultureInfo));
        }

        /// <summary>
        /// 字符串去空格
        /// </summary>
        /// <param name="inputStr">输入</param>
        /// <returns></returns>
        public static string TryToTrim(this string inputStr)
        {
            var output = inputStr.IsNullOrEmpty() ? inputStr : inputStr.Trim();
            return output;
        }

        /// <summary>
        /// 字符串转枚举
        /// </summary>
        /// <typeparam name="T">输入</typeparam>
        /// <param name="str"></param>
        /// <param name="t"></param>
        /// <returns></returns>
        public static T TryToEnum<T>(this string str, T t = default) where T : struct
        {
            return Enum.TryParse<T>(str, out var result) ? result : t;
        }
    }
}