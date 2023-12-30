const Comment = require("../models/comment.model");
const Post = require("../models/post.model");
const User = require("../models/user.model");

module.exports.createComment = async (req, res) => {
  try {
    const { content, postId } = req.body;
    const comment = await Comment.create({
      content: content,
      post: postId,
      user: req.user.id,
    });

    const post = await Post.findById(postId);
    post.comments.push(comment.id);
    post.save();
    return res.status(200).json({
      success: true,
      message: "comment created successfully",
      comment: comment,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
}

module.exports.updateComment = async (req, res) => {
  try {
    const { content } = req.body;
    const commentId = req.params.id;
    const comment = await Comment.findById(commentId);
    if (req.user.id == comment.user) {
      comment.content = content;
      comment.save();
    } else {
      return res.status(400).json({
        success: false,
        message: "You don't have permission",
      });
    }

    return res.status(200).json({
      success: true,
      message: "comment updated successfully",
      comment: comment,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
}

module.exports.deleteComment = async (req, res) => {
  try {
    const commentId = req.params.id;
    const comment = await Comment.findById(commentId);
    const post = await Post.findById(comment.post);
    if (req.user.id == comment.user) {
      await Comment.findByIdAndDelete(commentId);
      var index = post.comments.indexOf(commentId);
      if (index > -1) {
        post.comments.splice(index, 1);
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
      message: "comment delete successfully",
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
}
