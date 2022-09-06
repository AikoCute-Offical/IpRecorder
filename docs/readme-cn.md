# Multiple languages supported AikoR-IpRecord
1: Description by English [English](/README.md) 

2: Description by Chinese [Chinese](/docs/readme-cn.md)

3: Description by Vietnamese [Vietnamese](/docs/readme-vi.md)

# AikoR-IpRecord
AikoR 的外部记录器，用于同步和记录每个节点的在线设备（IP）

## 配置文件说明
- `Addr` 地址 Web，例如：`127.0.0.1:1231`
- `Token` 与 AikoR 通信时的身份验证令牌
- `IpDb` 数据库 IP 路径（IP2LOCATION-LITE-DB3.BIN 此文件）
- `MasterId` Telegram 用户 ID，用于推送历史连接 Ip 过载通知
- `BotToken` 电报 BotToken
- `HistoryIpLimit`每天连接的IP数量是有限的，同一个城市算一个IP。如果超出限制，将推送 tg 消息通知。 0 禁用
- `OnlineIpLimit` 限制在线IP数量，如果为0则不启用。此条目仅限制记录的 IP 数量。实际限制还是以 AikoR `DeviceLimit` 配置项为准