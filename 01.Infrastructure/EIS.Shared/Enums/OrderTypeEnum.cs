﻿#region License
/***
 * Copyright © 2024-2099, Kesiau.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * without warranties or conditions of any kind, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#endregion

using System.ComponentModel;

namespace EIS.Shared.Enums
{
    /// <summary>
    /// 排序方式
    /// </summary>
    public enum OrderTypeEnum
    {
        /// <summary>
        /// 升序
        /// </summary>
        [Description("Ascending")] Ascending = 0,

        /// <summary>
        /// 降序
        /// </summary>
        [Description("Descending")] Descending = 1
    }
}
