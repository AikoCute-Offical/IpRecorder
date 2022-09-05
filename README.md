# AikoR-IpRecord
Bộ ghi bên ngoài cho AikoR để đồng bộ hóa và ghi lại các thiết bị trực tuyến (IP) của mỗi nút

Tái bút: Tôi viết ra các bán thành phẩm để sử dụng một cách ngẫu nhiên, và tôi không đảm bảo bất kỳ khả năng sử dụng nào, nếu có khả năng, tôi đề nghị bạn tham khảo mã nguồn để tự thực hiện.
## Mô tả tệp cấu hình
- `Addr` Address Web, ví dụ:`127.0.0.1:1231`
- `Token` Mã thông báo xác thực khi giao tiếp với AikoR ( API key )
- `IpDb` Đường dẫn tệp cơ sở dữ liệu IP
- `MasterId` ID người dùng Telegram, được sử dụng để đẩy thông báo quá tải Ip kết nối lịch sử
- `BotToken` Telegram BotToken
- `HistoryIpLimit` Số lượng IP kết nối mỗi ngày có giới hạn và cùng một thành phố được tính là một IP. Nếu vượt quá giới hạn, thông báo tin nhắn tg sẽ được đẩy lên. 0 để vô hiệu hóa
- `OnlineIpLimit` Giới hạn số lượng IP trực tuyến, nếu là 0, nó sẽ không được bật. Mục này chỉ giới hạn số lượng IP được ghi lại. Giới hạn thực tế vẫn dựa trên AikoR `DeviceLimit` mục cấu hình
