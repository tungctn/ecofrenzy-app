const userService = require("../services/user.service");
const challengeService = require("../services/challenge.service");
// const storageService = require("../services/storage.service");
const logger = require("../utils/logger");
const AWS = require("aws-sdk");
const Activity = require("../models/activity.model");
const User = require("../models/user.model");
require("dotenv").config();

AWS.config.update({ region: "ap-southeast-1" });

module.exports.pickChallenge = async (req, res) => {
  try {
    const { userId, challengeId } = req.params;
    const user = await userService.getUser(userId);
    for (let i = 0; i < user.todayChallenge.length; i++) {
      const challenge = user.todayChallenge[i];
      if (challenge._id == challengeId) {
        switch (challenge.status) {
          case "Start":
            challenge.status = "Picked";
            break;
          // case "Picked":
          //   challenge.status = "Pending";
          //   break;
          // case "Pending":
          //   challenge.status = "Done";
          //   challenge.isDone = true;
          //   break;
        }
      } else {
        challenge.status = "UnPicked";
      }
      await user.save();
    }
    logger.info("challenge updated successfully");
    logger.info(user);
    return res.status(200).json({
      success: true,
      message: "challenge updated successfully",
      user,
      challenges: user.todayChallenge,
    });
  } catch (error) {
    logger.error(error.message);
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.doneChallenge = async (req, res) => {
  try {
    const { userId, challengeId } = req.params;
    const { url } = req.body;
    const user = await userService.getUser(userId);
    for (let i = 0; i < user.todayChallenge.length; i++) {
      const challenge = user.todayChallenge[i];
      if (challenge._id == challengeId) {
        challenge.status = "Done";
        challenge.isDone = true;
        challenge.url = url;
      }
      user.totalPoint += challenge.point
      await user.save();
    }
    logger.info("challenge updated successfully");
    logger.info(user);
    const activity = await Activity.findOne({ user: userId });
    if (activity) {
      activity = await Activity.findOneAndUpdate(
        { user: userId },
        {
          $push: {
            challenge: user.todayChallenge.find(
              (challenge) => challenge.isDone
            ),
          },
        },
        { new: true }
      );
    } else {
      activity = await Activity.create({
        user: userId,
        challenge: user.todayChallenge.find((challenge) => challenge.isDone),
      });
    }
    return res.status(200).json({
      success: true,
      message: "challenge updated successfully",
      user,
      challenges: user.todayChallenge,
    });
  } catch (error) {
    logger.error(error.message);
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.getTodayChallenge = async (req, res) => {
  try {
    const { userId } = req.params;
    const user = await userService.getUser(userId);
    return res.status(200).json({
      success: true,
      message: "challenge retrieved successfully",
      challenges: user.todayChallenge,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.getUser = async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await userService.getUser(userId);
    return res.status(200).json({
      success: true,
      message: "User retrieved successfully",
      user: user,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.updateUser = async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await userService.updateUser(userId, req.body);
    return res.status(200).json({
      success: true,
      message: "User updated successfully",
      user: user,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

// module.exports.addFriend = async (req, res) => {
//   try {
//     const { userId, friendId } = req.body;
//     // Kiểm tra xem user đã gửi lời mời kết bạn cho friendId chưa
//     const userB = await User.findOne({ _id: friendId, "friends.user": userId });
//     // Neu da gui thi update isAdded = true
//     if (userB) {
//       await User.findOneAndUpdate(
//         { _id: userId, "friends.user": friendId },
//         { $set: { "friends.$.isAdded": true } }
//       );
//     } else {
//       await User.findByIdAndUpdate(
//         userId,
//         { $addToSet: { friends: { user: friendId, isAdded: true } } },
//         { new: true, safe: true, upsert: true }
//       );

//       await User.findByIdAndUpdate(
//         friendId,
//         { $addToSet: { friends: { user: userId, isAdded: false } } },
//         { new: true, safe: true, upsert: true }
//       );
//     }
//     return res.status(200).json({
//       success: true,
//       message: "Friend request processed successfully.",
//     });
//   } catch (error) {
//     return res.status(200).json({
//       success: false,
//       message: error.message,
//     });
//   }
// };

module.exports.getFriendList = async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findById(userId).populate({
      path: "friends.user",
      match: { "friends.isAdded": true },
    });
    const friendList = user.friends.filter((friend) => friend.isAdded);
    return res.status(200).json({
      success: true,
      message: "Friend list retrieved successfully",
      friendList: friendList,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.getSuggestFriend = async (req, res) => {
  try {
    const userId = req.params.userId;
    let users = await User.find({
      _id: { $ne: userId },
      "friends.user": { $ne: userId },
    });
    // random 5 users from users
    users = users.sort(() => Math.random() - Math.random()).slice(0, 5);
    return res.status(200).json({
      success: true,
      message: "User retrieved successfully",
      users: users,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};
