BTL Chuyên đề công nghệ Nhật Bản

Folder chung: https://drive.google.com/drive/folders/1eFCqNc6BbyzE--7RiW93PYH5SiDpbTuP?usp=sharing

Challenge pool: https://docs.google.com/document/d/1jFAsEbj4D2bk6bhdXevV4XiiSo6g09LnB7Wews7X7_g/edit?usp=sharing
API backend: https://nnv7xc0r7d.execute-api.ap-southeast-1.amazonaws.com/prod/api
Tính năng cơ bản của sản phẩm

a) Thử thách hàng ngày

• Chọn thử thách: Người dùng có thể chọn 1 trong 3 thử thách hàng ngày được đề xuất một cách cá nhân hóa bởi hệ thống. Ngoài ra, ở một số “level” nhất định, người dùng có thể nhận thêm thử thách được sáng tạo bởi cộng đồng

• Phần thưởng: Người dùng sẽ nhận được một số điểm nhất định nếu hoàn thành thử thách. Tùy vào loại thử thách mà người dùng sẽ được yêu cầu cung cấp các minh chứng khác nhau như ảnh, định vị, video time-lapse,...

• Chế độ nhiều người chơi: Người dùng có thể lựa chọn tham gia thử thách một mình hoặc cùng bạn bè. Nếu nhiều người cùng nhau hoàn thiện một thử thách, số điểm mỗi người nhận được cũng sẽ lớn hơn

• Lĩnh vực: Các thử thách bao quát 6 lĩnh vực khác nhau của lối sống bền vững gồm Năng lượng và tài nguyên, Giao thông, Tiêu dùng, Xử lý chất thải, Phủ xanh, Nhận thức và đổi mới.

• Độ khó: Gồm 3 độ khó từ đơn giản, trung bình đến nâng cao. Các mức độ sẽ khác nhau ở quy mô, thời gian thực hiện, kinh nghiệm yêu cầu và chi phí bỏ ra.

b) Mạng xã hội

• Đăng tải: Người dùng có thể chia sẻ những khoảnh khắc mình thực hiện thử thách bền vững lên trên nền tảng. Khi đó, hệ thống AI sẽ quét và xác nhận mức độ hoàn thành thử thách

• Tương tác: Người dùng có thể bình luận, thả cảm xúc đối với những khoảnh khắc sống xanh của bạn bè, qua đó có được những kiến thức hữu ích, sáng tạo về việc sống xanh

• Bảng xếp hạng: Thông qua việc hoàn thành thử thách, người chơi sẽ nhận được một số điểm nhất định dựa trên độ khó và quy mô. Kết thúc mỗi tuần, sẽ có bảng xếp hạng để người chơi tự so sánh bản than với bản bè, qua đó có động lực cố gắng duy trì và cải thiện.

enum: ["Easy", "Intermediate", "Hard"],
point [50, 100, 150, 200]
1.Thử thách: Lắp vòi hoa sen tiết kiệm nước (Dựa trên ảnh)
Tác động: Thúc đẩy việc bảo tồn nước bằng cách khuyến khích sử dụng các thiết bị tiết kiệm nước trong nhà.
Cách thực hiện:

- Tìm mua vòi hoa sen tiết kiệm nước từ các cửa hàng đồ gia dụng hoặc trực tuyến.
- Chụp ảnh vòi hoa sen đã lắp đặt xong.
- Chia sẻ ảnh với bạn bè để khuyến khích họ tham gia.
  Caption:
- Mỗi giọt nước bạn tiết kiệm đều quan trọng. Bắt đầu từ vòi hoa sen của bạn!
  Category: Energy and Resources
  level: Easy
  point: 50
  question: [
  "Is there a water-saving shower head in your photo?",
  "Is someone with a water-saving shower head in your photo?"
  ]

  2.Thử thách: Lắp đặt tấm pin năng lượng mặt trời cho ngôi nhà của bạn (Dựa trên ảnh)
  Tác động: Khuyến khích sử dụng các nguồn năng lượng tái tạo bằng cách thúc đẩy các lựa chọn chiếu sáng bằng năng lượng mặt trời
  Cách thực hiện:

- Tìm hiểu về các loại tấm pin năng lượng mặt trời và chọn lựa loại phù hợp cho ngôi nhà của bạn.
- Chụp ảnh pin mặt trời sau khi lắp đặt.
- Chia sẻ trải nghiệm và ảnh lên mạng xã hội.
  Caption:
- Mặt trời chiếu sáng cho tôi mỗi ngày, còn bạn thì sao?
  Category: Energy and Resources
  level: Intermediate
  point: 100
  question: [
  "Is there a solar panel in your photo?",
  "Is someone with a solar panel in your photo?"
  ]

  3.Thử thách: Giặt khô trên dây (Dựa trên ảnh)
  Tác động: Giảm tiêu hao năng lượng bằng cách sấy quần áo bằng không khí thay vì dùng máy sấy điện
  Cách thực hiện:

- Treo dây giặt ở ban công hoặc sân vườn của bạn.
- Chụp ảnh quần áo đang phơi trên dây.
- Chia sẻ ảnh với mọi người và khuyến khích họ thử thách này.
  Caption:
- Không cần máy sấy khi ta có gió và mặt trời!
  Category: Energy and Resources
  level: Easy
  point: 50
  question: [
  "Are clothes visible hanging on a line outdoors?"
  "Does the photo show a natural environment for air-drying clothes?"
  ]

  4.Thử thách: Đạp xe đi làm (Dựa trên ảnh)
  Tác động: Thúc đẩy việc đi xe đạp như một phương thức vận chuyển bền vững, giảm lượng khí thải carbon và ô nhiễm không khí do sử dụng phương tiện giao thông.
  Cách thực hiện:

- Sử dụng xe đạp của riêng bạn hoặc mượn từ bạn bè.
- Nếu không có xe, hãy mua hoặc thuê.
- Chụp ảnh bạn đang đạp xe đến nơi làm việc và chia sẻ nó với bạn bè của bạn.
  Caption:
- Thay đổi phương tiện giao thông ngày hôm nay!"
  Category: Transportation
  level: Easy
  point: 50
  question: [
  "Is there a bicycle in your photo?",
  "Is someone with a bicycle in your photo?"
  ]

  5.Thử thách: Sử dụng phương tiện giao thông công cộng (Dựa trên ảnh)
  Tác động: Khuyến khích người dùng sử dụng phương tiện công cộng, giảm số lượng phương tiện chở một người trên đường và giảm lượng khí thải carbon.
  Cách thực hiện:

- Lên kế hoạch và chọn lựa phương tiện công cộng phù hợp.
- Chụp ảnh bạn đang sử dụng phương tiện công cộng và chia sẻ trải nghiệm của mình.
  Caption:
- Đi chung, sống xanh, và giảm tải cho Trái Đất!
  Category: Transportation
  level: Easy
  point: 50
  question: [
  "Is there a public transport in your photo?",
  "Is someone with a public transport in your photo?"
  ]

  6.Thử thách: Đi xe cùng người khác (Dựa trên ảnh)
  Tác động: Giảm lượng khí thải carbon của từng cá nhân bằng cách đi chung xe với những người khác, dẫn đến có ít phương tiện lưu thông trên đường hơn và mức tiêu thụ nhiên liệu thấp hơn.
  Cách thực hiện:

- Hỏi bạn bè hoặc đồng nghiệp xem ai có lịch trình tương tự và muốn đi chung.
- Chụp ảnh nhóm bạn trên xe và chia sẻ lên mạng xã hội.
  Caption:
- Đi chung không chỉ vui vẻ mà còn thân thiện với môi trường!
  Category: Transportation
  level: Easy
  point: 50
  question: [
  "Does the photo show multiple people in a single car?"
  "Can you identify any carpooling signs or symbols in the image?"
  ]

  7.Thử thách: Thứ Hai không thịt (Dựa trên ảnh)
  Tác động: Khuyến khích người dùng tiêu thụ bữa ăn chay trong ngày, giảm nhu cầu về thịt, loại thịt có lượng khí thải carbon cao hơn so với thực phẩm có nguồn gốc thực vật.
  Cách thực hiện:

- Lên kế hoạch cho bữa ăn chay vào thứ Hai.
- Chụp ảnh bữa ăn của bạn và chia sẻ với mọi người.
  Caption:
- Một ngày không thịt, một bước tiến lớn cho Trái Đất!
  Category: Consumption
  level: Easy
  point: 50
  question: [
  "Does the meal in the photo appear to be vegetarian?",
  "Is there someone with a vegetarian meal in your photo?"
  ]

  8.Thử thách: Mang theo túi riêng của bạn (Dựa trên ảnh)
  Tác động: Người dùng mang túi mua sắm có thể tái sử dụng của riêng mình đến cửa hàng, giảm thiểu rác thải và ô nhiễm túi nhựa dùng một lần.
  Cách thực hiện:

- Đem theo túi tái sử dụng mỗi khi đi mua sắm.
- Chụp ảnh bạn và túi của bạn tại cửa hàng và chia sẻ trải nghiệm.
  Caption:
- Từ chối túi nhựa và chọn lựa sự bền vững!
  Category: Consumption
  level: Easy
  point: 50
  question: [
  "Is there a reusable bag in your photo?",
  "Is someone with a reusable bag in your photo?"
  ]

  9.Thách thức: Trồng cây tại khu vực địa phương (Dựa trên ảnh)
  Tác động: Trồng cây góp phần cô lập carbon, cải thiện chất lượng không khí và hỗ trợ đa dạng sinh học địa phương.
  Cách thực hiện:

- Mua cây hoặc hạt giống tại các cửa hàng cây cảnh hoặc trung tâm nông nghiệp.
- Chụp ảnh cây trồng và chia sẻ với cộng đồng.
  Caption:
- Mỗi cây bạn trồng là một bước tiến cho hành tinh xanh của chúng ta!
  Category: Forestry
  level: Easy
  point: 50
  question: [
  "Is there a plant in your photo?",
  "Is someone with a plant in your photo?"
  ]

  10.Thử thách: Bắt đầu một Vườn Thảo mộc và Vườn Rau (Dựa trên Ảnh)
  Tác động: Trồng thảo mộc tại nhà giúp giảm nhu cầu về các loại thảo mộc mua ở cửa hàng, cắt giảm bao bì nhựa và khí thải vận chuyển.
  Cách thực hiện:

- Chọn lựa và mua các loại thảo mộc và cây rau phù hợp với điều kiện thổ nhưỡng và khí hậu của bạn.
- Chụp ảnh vườn thảo mộc và rau của bạn và chia sẻ tiến trình trồng trọt.
  Caption:
- Tự trồng thực phẩm của mình và đón nhận sự tươi xanh mỗi ngày!
  Category: Forestry
  level: Easy
  point: 50
  question: [
  "Is there a herb or vegetables garden in your photo?",
  "Is someone with a herb or vegetables garden in your photo?"
  ]
