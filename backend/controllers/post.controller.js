const Post = require("../models/post.model");
const User = require("../models/user.model");

module.exports.createPost = async (req, res) => {
  try {
    const currentUserId = req.user.id;
    const { image, challengeId } = req.body;
    const post = await Post.create({
      challenge: challengeId,
      image: image,
      user: currentUserId,
    });
    return res.status(200).json({
      success: true,
      message: "post created successfully",
      post: post,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.getPostsOfUserAndFriend = async (req, res) => {
  try {
    const currentUserId = req.user.id;
    const currentUser = await User.findById(currentUserId);
    const posts = await Post.find({
      $or: [{user: currentUserId}, {user: { $in: currentUser.friends}}]
    })
      .populate({
        path: "challenge",
      })
      .populate({
        path: "user",
        select: "name image"
      })
      .populate({
        path: "comments",
        populate: {
          path: "user",
          select: "name image"
        }
     })
      .populate("reacts")
      .sort({ createdAt: -1 });
    return res.status(200).json({
      success: true,
      message: "posts fetched successfully",
      posts: posts,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};
