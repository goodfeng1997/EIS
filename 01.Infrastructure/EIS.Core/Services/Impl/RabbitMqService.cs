using System.Collections.Concurrent;
using System.Text;
using EIS.Shared.Extensions;
using Microsoft.Extensions.Logging;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;

namespace EIS.Core.Services.Impl;

public class RabbitMqService : IRabbitMqService
{
    private readonly IConnection _connection;
    private readonly ILogger<RabbitMqService> _logger;
    private readonly ConcurrentBag<IChannel> _channels;

    /// <summary>
    /// 构造函数
    /// </summary>
    /// <param name="logger"></param>
    /// <param name="connection"></param>
    public RabbitMqService(ILogger<RabbitMqService> logger, IConnection connection)
    {
        _logger = logger;
        _connection = connection;
        _channels = new ConcurrentBag<IChannel>();
    }

    /// <summary>
    /// 获取消息队列通道
    /// </summary>
    /// <returns></returns>
    private async Task<IChannel> GetChannel()
    {
        if (!_channels.TryTake(out var channel))
        {
            channel = await _connection.CreateChannelAsync();
        }

        return channel;
    }

    /// <summary>
    /// 释放消息队列通道
    /// </summary>
    /// <param name="channel"></param>
    private void ReleaseChannel(IChannel channel)
    {
        if (channel.IsOpen)
        {
            _channels.Add(channel);
        }
    }

    /// <summary>
    /// 简单模式发布消息
    /// </summary>
    /// <param name="queueName"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PushMessageBySimpleAsync<T>(string queueName, T message)
    {
        var channel = await GetChannel();
        await channel.QueueDeclareAsync(queue: queueName, durable: false, exclusive: false, autoDelete: false, arguments: null);
        await channel.BasicPublishAsync(exchange: "", routingKey: queueName, body: Encoding.UTF8.GetBytes(message.ToJson()));
        
        ReleaseChannel(channel);
    }

    /// <summary>
    /// 简单模式消费消息
    /// </summary>
    /// <param name="queueName"></param>
    /// <param name="action"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PullMessageBySimpleAsync<T>(string queueName, Action<T> action)
    {
        var channel = await GetChannel();
        await channel.QueueDeclareAsync(queue: queueName, durable: false, exclusive: false, autoDelete: false, arguments: null);

        var consumer = new EventingBasicConsumer(channel);
        
        
        consumer.Received += (model, e) =>
        {
            var body = e.Body.ToArray();
            var message = Encoding.UTF8.GetString(body);
            action.Invoke(message.FromJson<T>());
        };
        
        await channel.BasicConsumeAsync(queue: queueName, autoAck: true, consumer: consumer);
    }

    /// <summary>
    /// 工作模式发布消息
    /// </summary>
    /// <param name="queueName"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PushMessageByWorkAsync<T>(string queueName, T message)
    {        
        var channel = await GetChannel();
        await channel.QueueDeclareAsync(queue: queueName, durable: true, exclusive: false, autoDelete: false, arguments: null);
        await channel.BasicPublishAsync(exchange: "", routingKey: queueName, body: Encoding.UTF8.GetBytes(message.ToJson()));
        
        ReleaseChannel(channel);
    }

    /// <summary>
    /// 工作模式消费消息
    /// </summary>
    /// <param name="queueName"></param>
    /// <param name="action"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PullMessageByWorkAsync<T>(string queueName, Action<T> action)
    {
        var channel = await GetChannel();
        await channel.QueueDeclareAsync(queue: queueName, durable: true, exclusive: false, autoDelete: false, arguments: null);
        await channel.BasicQosAsync(0, 1, false);
        
        var consumer = new EventingBasicConsumer(channel);
        
        consumer.Received += async (model, e) =>
        {
            var body = e.Body.ToArray();
            var message = Encoding.UTF8.GetString(body);
  
            action.Invoke(message.FromJson<T>());

            await channel.BasicAckAsync(deliveryTag: e.DeliveryTag, multiple: false);
        };

        await channel.BasicConsumeAsync(queue: queueName, autoAck: false, consumer: consumer);
    }

    /// <summary>
    /// 路由模式发布消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="routingKey"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PushMessageByRoutingAsync<T>(string exchangeName, string routingKey, T message)
    {
        var channel = await GetChannel();
        await channel.ExchangeDeclareAsync(exchange: exchangeName, type: ExchangeType.Direct);

        await channel.BasicPublishAsync(exchange: exchangeName, routingKey: routingKey, body: Encoding.UTF8.GetBytes(message.ToJson()));
        
        ReleaseChannel(channel);
    }

    /// <summary>
    /// 路由模式消费消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="routingKey"></param>
    /// <param name="action"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PullMessageByRoutingAsync<T>(string exchangeName, string routingKey, Action<T> action)
    {
        var channel = await GetChannel();
        await channel.ExchangeDeclareAsync(exchange: exchangeName, type: ExchangeType.Direct);
        
        var queueName = channel.CurrentQueue;
        
        await channel.QueueBindAsync(queue: queueName, exchange: exchangeName, routingKey: routingKey);
        
        var consumer = new EventingBasicConsumer(channel);
        
        consumer.Received += (model, e) =>
        {
            var body = e.Body.ToArray();
            var message = Encoding.UTF8.GetString(body);
            
            action.Invoke(message.FromJson<T>());
        };

        await channel.BasicConsumeAsync(queue: queueName, autoAck: true, consumer: consumer);
    }

    /// <summary>
    /// 主题模式发布消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="routingKey"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PushMessageByTopicAsync<T>(string exchangeName, string routingKey, T message)
    {
        var channel = await GetChannel();
        
        await channel.ExchangeDeclareAsync(exchange: exchangeName, type: ExchangeType.Topic);
        
        await channel.BasicPublishAsync(exchange: exchangeName, routingKey: routingKey, body: Encoding.UTF8.GetBytes(message.ToJson()));
        
        ReleaseChannel(channel);
    }

    /// <summary>
    /// 主题模式消费消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="routingKey"></param>
    /// <param name="action"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PullMessageByTopicAsync<T>(string exchangeName, string routingKey, Action<T> action)
    {
        var channel = await GetChannel();
        await channel.ExchangeDeclareAsync(exchange: exchangeName, type: ExchangeType.Topic);
        
        var queueName = channel.CurrentQueue;
        
        await channel.QueueBindAsync(queue: queueName, exchange: exchangeName, routingKey: routingKey);
        
        var consumer = new EventingBasicConsumer(channel);
        
        consumer.Received += (model, e) =>
        {
            var body = e.Body.ToArray();
            var message = Encoding.UTF8.GetString(body);
            
            action.Invoke(message.FromJson<T>());
        };

        await channel.BasicConsumeAsync(queue: queueName, autoAck: true, consumer: consumer);
    }

    /// <summary>
    /// 发布订阅模式发布消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="message"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PushMessageByPubSubAsync<T>(string exchangeName, T message)
    {
        var channel = await GetChannel();
        
        await channel.ExchangeDeclareAsync(exchange: exchangeName, type: ExchangeType.Fanout);
        
        var body = Encoding.UTF8.GetBytes(message.ToJson());

        await channel.BasicPublishAsync(exchange: exchangeName, routingKey: "", body: body);
        
        ReleaseChannel(channel);
    }

    /// <summary>
    /// 发布订阅模式消费消息
    /// </summary>
    /// <param name="exchangeName"></param>
    /// <param name="action"></param>
    /// <typeparam name="T"></typeparam>
    public async Task PullMessageByPubSubAsync<T>(string exchangeName, Action<T> action)
    {
        var channel = await GetChannel();
        await channel.ExchangeDeclareAsync(exchange: exchangeName, type: ExchangeType.Fanout);
        
        var queueName = channel.CurrentQueue;
        
        await channel.QueueBindAsync(queue: queueName, exchange: exchangeName, routingKey: "");
        
        var consumer = new EventingBasicConsumer(channel);
        
        consumer.Received += (model, e) =>
        {
            var body = e.Body.ToArray();
            var message = Encoding.UTF8.GetString(body);
            
            action.Invoke(message.FromJson<T>());
        };

        await channel.BasicConsumeAsync(queue: queueName, autoAck: true, consumer: consumer);
    }
}