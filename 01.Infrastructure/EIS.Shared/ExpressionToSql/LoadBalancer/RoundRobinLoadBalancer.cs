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

using System.Collections.Concurrent;

namespace EIS.Shared.ExpressionToSql.LoadBalancer
{
    /// <summary>
    /// 轮询方式
    /// </summary>
    public class RoundRobinLoadBalancer : ILoadBalancer
    {
        private static readonly object _lock = new();

        private static readonly ConcurrentDictionary<string, int> _serviceIndexs = new();

        /// <summary>
        /// 获取数据集合中的一条数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="key">唯一标识，用于多数据库情况下的负载均衡</param>
        /// <param name="data">数据集合</param>
        /// <param name="weights">权重集合，当前轮询方式，权重无效</param>
        /// <returns></returns>
        public T Get<T>(string key, IEnumerable<T> data, int[] weights = null)
        {
            var count = data.Count();
            key = $"{key}_{count}";

            var index = _serviceIndexs.GetOrAdd(key, 0);
            var retval = data.ElementAt(index);

            lock (_lock)
            {
                index++;
                if (index >= count)
                    index = 0;

                _serviceIndexs[key] = index;
            }

            return retval;
        }
    }
}
