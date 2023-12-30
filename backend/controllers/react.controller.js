const React = require("../models/react.model");
const Post = require("../models/post.model");

module.exports.createReact = async (req, res) => {
  try {
    const { postId } = req.body;
    let react = await React.findOne({
      $and: [
      {user: req.user.id},
      {post: postId}
  ]});
  console.log(react);
    if (!react) {
      react = await React.create({
        post: postId,
        user: req.user.id,
      });

      const post = await Post.findById(postId);
      post.reacts.push(react.id);
      post.save();
    } else {
      return res.status(400).json({
        success: false,
        message: "You have been react",
      });
    }

    return res.status(200).json({
      success: true,
      message: "react created successfully",
      react: react
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
}

module.exports.deleteReact = async (req, res) => {
  try {
    const reactId = req.params.id;
    const react = await React.findById(reactId);
    const post = await Post.findById(react.post);
    if (req.user.id == react.user) {
      await React.findByIdAndDelete(reactId);
      var index = post.reacts.indexOf(reactId);
      if (index > -1) {
        post.reacts.splice(index, 1);
        post.save();
      }
    } else {
      return res.status(400).json({
        success: false,
        message: "You don't have permission",
      });
    }

    return res.status(200).json({
      success: true,
      message: "react delete successfully",
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
}
