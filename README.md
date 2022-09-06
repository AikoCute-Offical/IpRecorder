# Multiple languages supported AikoR-IpRecord
1: Description by English [English](/README.md) 

2: Description by Chinese [Chinese](/docs/readme-cn.md)

3: Description by Vietnamese [Vietnamese](/docs/readme-vi.md)

# AikoR-IpRecord
External logger for AikoR to synchronize and record the online devices (IPs) of each node
## Configuration file description
- `Addr` Address Web, for example: `127.0.0.1:1231`
- `Token` Authentication token when communicating with AikoR
- `IpDb` Database IP Path (IP2LOCATION-LITE-DB3.BIN This file)
- `MasterId` Telegram user ID, used to push notification of historical connection Ip overload
- `BotToken` Telegram BotToken
- `HistoryIpLimit` The number of connected IPs per day is limited and the same city counts as one IP. If the limit is exceeded, the tg message notification will be pushed. 0 to disable
- `OnlineIpLimit` Limits the number of online IPs, if it is 0, it will not be enabled. This entry only limits the number of IPs that are logged. Actual limit is still based on AikoR `DeviceLimit` configuration item