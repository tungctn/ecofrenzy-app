const Challenge = require("../models/challenge.model");
const logger = require("../utils/logger");
const User = require("../models/user.model");

module.exports.getRandomChallenge = async (req, res) => {
  try {
    const challenges = await Challenge.aggregate([{ $sample: { size: 3 } }]);
    logger.info("Challenges retrieved successfully");
    logger.info({ challenges: challenges });
    const user = await User.findByIdAndUpdate(
      req.params.id,
      { todayChallenge: challenges },
      { new: true }
    );
    return res.status(200).json({
      success: true,
      message: "challenges retrieved successfully",
      user: user,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.resetTodayChallenge = async (req, res) => {
  const allUsers = await User.find();
  for (let index = 0; index < allUsers.length; index++) {
    const randomChallenges = await Challenge.aggregate([{ $sample: { size: 3 } }]);
    const user = allUsers[index];
    user.todayChallenge = randomChallenges;
    user.save();
  }
  return res.status(200).json({
    success: true,
    message: "Reset today challenge successfully",
  });
}
// const challenges = [
//   {
//     name: "Lắp vòi hoa sen tiết kiệm nước",
//     description:
//       "Thúc đẩy việc bảo tồn nước bằng cách khuyến khích sử dụng các thiết bị tiết kiệm nước trong nhà.",
//     implementation: [
//       "Tìm mua vòi hoa sen tiết kiệm nước từ các cửa hàng đồ gia dụng hoặc trực tuyến.",
//       "Chụp ảnh vòi hoa sen đã lắp đặt xong.",
//       "Chia sẻ ảnh với bạn bè để khuyến khích họ tham gia.",
//     ],
//     caption:
//       "Mỗi giọt nước bạn tiết kiệm đều quan trọng. Bắt đầu từ vòi hoa sen của bạn!",
//     category: "Energy and Resources",
//     level: "Easy",
//     point: 50,
//   },
//   {
//     name: "Lắp đặt tấm pin năng lượng mặt trời cho ngôi nhà của bạn",
//     description:
//       "Khuyến khích sử dụng các nguồn năng lượng tái tạo bằng cách thúc đẩy các lựa chọn chiếu sáng bằng năng lượng mặt trời.",
//     implementation: [
//       "Tìm hiểu về các loại tấm pin năng lượng mặt trời và chọn lựa loại phù hợp cho ngôi nhà của bạn.",
//       "Chụp ảnh pin mặt trời sau khi lắp đặt.",
//       "Chia sẻ trải nghiệm và ảnh lên mạng xã hội.",
//     ],
//     caption: "Mặt trời chiếu sáng cho tôi mỗi ngày, còn bạn thì sao?",
//     category: "Energy and Resources",
//     level: "Intermediate",
//     point: 100,
//   },
//   {
//     name: "Giặt khô trên dây",
//     description:
//       "Giảm tiêu hao năng lượng bằng cách sấy quần áo bằng không khí thay vì dùng máy sấy điện.",
//     implementation: [
//       "Treo dây giặt ở ban công hoặc sân vườn của bạn.",
//       "Chụp ảnh quần áo đang phơi trên dây.",
//       "Chia sẻ ảnh với mọi người và khuyến khích họ thử thách này.",
//     ],
//     caption: "Không cần máy sấy khi ta có gió và mặt trời!",
//     category: "Energy and Resources",
//     level: "Easy",
//     point: 50,
//   },
//   {
//     name: "Đạp xe đi làm",
//     description:
//       "Thúc đẩy việc đi xe đạp như một phương thức vận chuyển bền vững, giảm lượng khí thải carbon và ô nhiễm không khí do sử dụng phương tiện giao thông.",
//     implementation: [
//       "Sử dụng xe đạp của riêng bạn hoặc mượn từ bạn bè.",
//       "Nếu không có xe, hãy mua hoặc thuê.",
//       "Chụp ảnh bạn đang đạp xe đến nơi làm việc và chia sẻ nó với bạn bè của bạn.",
//     ],
//     caption: "Thay đổi phương tiện giao thông ngày hôm nay!",
//     category: "Transportation",
//     level: "Easy",
//     point: 50,
//   },
//   {
//     name: "Sử dụng phương tiện giao thông công cộng",
//     description:
//       "Khuyến khích người dùng sử dụng phương tiện công cộng, giảm số lượng phương tiện chở một người trên đường và giảm lượng khí thải carbon.",
//     implementation: [
//       "Lên kế hoạch và chọn lựa phương tiện công cộng phù hợp.",
//       "Chụp ảnh bạn đang sử dụng phương tiện công cộng và chia sẻ trải nghiệm của mình.",
//     ],
//     caption: "Đi chung, sống xanh, và giảm tải cho Trái Đất!",
//     category: "Transportation",
//     level: "Easy",
//     point: 50,
//   },
//   {
//     name: "Đi xe cùng người khác",
//     description:
//       "Giảm lượng khí thải carbon của từng cá nhân bằng cách đi chung xe với những người khác, dẫn đến có ít phương tiện lưu thông trên đường hơn và mức tiêu thụ nhiên liệu thấp hơn.",
//     implementation: [
//       "Hỏi bạn bè hoặc đồng nghiệp xem ai có lịch trình tương tự và muốn đi chung.",
//       "Chụp ảnh nhóm bạn trên xe và chia sẻ lên mạng xã hội.",
//     ],
//     caption: "Đi chung không chỉ vui vẻ mà còn thân thiện với môi trường!",
//     category: "Transportation",
//     level: "Easy",
//     point: 50,
//   },
//   {
//     name: "Thứ Hai không thịt",
//     description:
//       "Khuyến khích người dùng tiêu thụ bữa ăn chay trong ngày, giảm nhu cầu về thịt, loại thịt có lượng khí thải carbon cao hơn so với thực phẩm có nguồn gốc thực vật.",
//     implementation: [
//       "Lên kế hoạch cho bữa ăn chay vào thứ Hai.",
//       "Chụp ảnh bữa ăn của bạn và chia sẻ với mọi người.",
//     ],
//     caption: "Một ngày không thịt, một bước tiến lớn cho Trái Đất!",
//     category: "Consumption",
//     level: "Easy",
//     point: 50,
//   },
//   {
//     name: "Mang theo túi riêng của bạn",
//     description:
//       "Người dùng mang túi mua sắm có thể tái sử dụng của riêng mình đến cửa hàng, giảm thiểu rác thải và ô nhiễm túi nhựa dùng một lần.",
//     implementation: [
//       "Đem theo túi tái sử dụng mỗi khi đi mua sắm.",
//       "Chụp ảnh bạn và túi của bạn tại cửa hàng và chia sẻ trải nghiệm.",
//     ],
//     caption: "Từ chối túi nhựa và chọn lựa sự bền vững!",
//     category: "Consumption",
//     level: "Easy",
//     point: 50,
//   },
//   {
//     name: "Trồng cây tại khu vực địa phương",
//     description:
//       "Trồng cây góp phần cô lập carbon, cải thiện chất lượng không khí và hỗ trợ đa dạng sinh học địa phương.",
//     implementation: [
//       "Mua cây hoặc hạt giống tại các cửa hàng cây cảnh hoặc trung tâm nông nghiệp.",
//       "Chụp ảnh cây trồng và chia sẻ với cộng đồng.",
//     ],
//     caption:
//       "Mỗi cây bạn trồng là một bước tiến cho hành tinh xanh của chúng ta!",
//     category: "Forestry",
//     level: "Easy",
//     point: 50,
//   },
//   {
//     name: "Bắt đầu một Vườn Thảo mộc và Vườn Rau",
//     description:
//       "Trồng thảo mộc tại nhà giúp giảm nhu cầu về các loại thảo mộc mua ở cửa hàng, cắt giảm bao bì nhựa và khí thải vận chuyển.",
//     implementation: [
//       "Chọn lựa và mua các loại thảo mộc và cây rau phù hợp với điều kiện thổ nhưỡng và khí hậu của bạn.",
//       "Chụp ảnh vườn thảo mộc và rau của bạn và chia sẻ tiến trình trồng trọt.",
//     ],
//     caption: "Tự trồng thực phẩm của mình và đón nhận sự tươi xanh mỗi ngày!",
//     category: "Forestry",
//     level: "Easy",
//     point: 50,
//   },
// ];
// Challenge.insertMany(challenges)
//   .then(() => {
//     logger.info("Challenges inserted successfully");
//   })
//   .catch((err) => {
//     logger.error(err.message);
//   });
