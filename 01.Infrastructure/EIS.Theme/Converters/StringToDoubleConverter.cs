﻿using Avalonia.Data.Converters;
using System.Globalization;

namespace EIS.Theme.Converters
{
    public class StringToDoubleConverter : IValueConverter
    {
        public static readonly StringToDoubleConverter Instance = new();

        public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
        {
            if (value == null)
                return 0;

            return ((string)value).Length > 0 ? 1 : 0;
        }

        public object ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture)
        {
            throw new NotSupportedException();
        }
    }
}
