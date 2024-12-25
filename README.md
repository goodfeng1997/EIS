# EIS是一套基于.net8的企业信息化解决方案（SaaS）

**系统设计采用前后端分离设计，前端基于Avalonia实现跨平台应用，后端基于.net web进行微服务设计，业务数据库采用多租户设计模式**

## 技术栈：Avalonia+.net web api+Dapper+FreeSql+Identity Server4+Swagger+Serilog+Redis+PostgreSQL+RabbitMQ+Docker+Ocelot+Polly+Nacos+Apollo+Exceptionless+ElasticSearch+SkyWalking

### 解决方案客户端分为：管理端、租户配置端、用户端
### 解决方案服务端分为：网关服务、身份验证与授权服务、编码服务、业务服务

#### 开发模块
* 网关服务：已完成（包含限流与熔断）
* 鉴权中心：黑名单管理(redis)未集成
* 合并Swagger并添加token：已完成
* 租户管理(多数据库的管理)：已完成
* 统一异常处理、统一结果返回：已完成
* 分布式日志：已完成
* 分布式配置中心：已完成
* 服务注册与发现：已完成
* Redis操作功能：已完成
* RabbitMQ集成：已完成
* 定时服务集成：待完成
* 分布式链路追踪：待完成
* 分布式事务：待完成
* 分布式锁：待完成
* 限流：已完成
* 防止重复提交：待完成
