namespace EIS.Core.Options;

public class RabbitMqOptions
{
    /// <summary>
    /// 交换机名称
    /// </summary>
    public string ExchangeName { get; set; } = string.Empty;
    
    /// <summary>
    /// 交换机类型
    /// </summary>
    public string ExchangeType { get; set; } = string.Empty;
    
    /// <summary>
    /// 队列名称
    /// </summary>
    public string QueueName { get; set; } = string.Empty;
}