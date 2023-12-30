const Post = require("../models/post.model");

module.exports.createPost = async (post) => {
  return await Post.create(post);
};
