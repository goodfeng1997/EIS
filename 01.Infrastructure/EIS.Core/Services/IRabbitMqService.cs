namespace EIS.Core.Services;

public interface IRabbitMqService
{
    /// <summary>
    /// 简单模式发布消息
    /// </summary>
    /// <param name="queueName"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public Task PushMessageBySimpleAsync<T>(string queueName, T message);

    /// <summary>
    /// 简单模式消费消息
    /// </summary>
    /// <param name="queueName"></param>
    /// <param name="action"></param>
    /// <typeparam name="T"></typeparam>
    public Task PullMessageBySimpleAsync<T>(string queueName, Action<T> action);

    /// <summary>
    /// 工作模式发布消息
    /// </summary>
    /// <param name="queueName"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public Task PushMessageByWorkAsync<T>(string queueName, T message);

    /// <summary>
    /// 工作模式消费消息
    /// </summary>
    /// <param name="queueName"></param>
    /// <param name="action"></param>
    /// <typeparam name="T"></typeparam>
    public Task PullMessageByWorkAsync<T>(string queueName, Action<T> action);

    /// <summary>
    /// 路由模式发布消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="routingKey"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public Task PushMessageByRoutingAsync<T>(string exchangeName, string routingKey, T message);

    /// <summary>
    /// 路由模式消费消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="routingKey"></param>
    /// <param name="action"></param>
    /// <typeparam name="T"></typeparam>
    public Task PullMessageByRoutingAsync<T>(string exchangeName, string routingKey, Action<T> action);

    /// <summary>
    /// 主题模式发布消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="routingKey"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public Task PushMessageByTopicAsync<T>(string exchangeName, string routingKey, T message);

    /// <summary>
    /// 主题模式消费消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="routingKey"></param>
    /// <param name="action"></param>
    /// <typeparam name="T"></typeparam>
    public Task PullMessageByTopicAsync<T>(string exchangeName, string routingKey, Action<T> action);

    /// <summary>
    /// 发布订阅模式发布消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public Task PushMessageByPubSubAsync<T>(string exchangeName, T message);

    /// <summary>
    /// 发布订阅模式消费消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="action"></param>
    /// <typeparam name="T"></typeparam>
    public Task PullMessageByPubSubAsync<T>(string exchangeName, Action<T> action);
}