# Multiple languages supported AikoR-IpRecord
1: Description by English [English](/README.md) 

2: Description by Chinese [Chinese](/docs/readme-cn.md)

3: Description by Vietnamese [Vietnamese](/docs/readme-vi.md)


# AikoR-IpRecord
Bộ ghi bên ngoài cho AikoR để đồng bộ hóa và ghi lại các thiết bị trực tuyến (IP) của mỗi nút
## Mô tả tệp cấu hình
- `Addr` Address Web, ví dụ:`127.0.0.1:1231`
- `Token` Mã thông báo xác thực khi giao tiếp với AikoR
- `IpDb` Đường dẫn Database IP (IP2LOCATION-LITE-DB3.BIN This file)
- `MasterId` ID người dùng Telegram, được sử dụng để đẩy thông báo quá tải Ip kết nối lịch sử
- `BotToken` Telegram BotToken
- `HistoryIpLimit` Số lượng IP kết nối mỗi ngày có giới hạn và cùng một thành phố được tính là một IP. Nếu vượt quá giới hạn, thông báo tin nhắn tg sẽ được đẩy lên. 0 để vô hiệu hóa
- `OnlineIpLimit` Giới hạn số lượng IP trực tuyến, nếu là 0, nó sẽ không được bật. Mục này chỉ giới hạn số lượng IP được ghi lại. Giới hạn thực tế vẫn dựa trên AikoR `DeviceLimit` mục cấu hình