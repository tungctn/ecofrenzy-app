const User = require("../models/user.model");
const userService = require("../services/user.service");

function compareUserPoints(a, b) {
  return a.point - b.point ;
}

module.exports.getTopThreeUserWithHighestPointInFriendsList = async (req, res) => {
  try {
    const currentUser = await User.findById(req.user.id).populate({
      path: "friends"
    });
    const friendList = currentUser.friends;
    friendList.push(currentUser);
    const friendsListSortedByPoint = friendList.sort(compareUserPoints);
    if (friendsListSortedByPoint.length >= 3) {
      result = friendsListSortedByPoint.slice(0, 3);
    } else {
      result = friendsListSortedByPoint;
    }
    return res.status(200).json({
      success: true,
      message: "get top three user with highest point in friends list successfully",
      topThreeUser: result,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.getTopThreeUserWithHighestPointInAllUsers = async (req, res) => {
  try {
    const allUser = await User.find();
    console.log(allUser);
    allUsersSortedByPoint = allUser.sort(compareUserPoints);
    if (allUsersSortedByPoint.length >= 3) {
      result = allUsersSortedByPoint.slice(0, 3);
    } else {
      result = allUsersSortedByPoint;
    }
    return res.status(200).json({
      success: true,
      message: "get top three user with highest point in all users successfully",
      topThreeUser: result,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};
