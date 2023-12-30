const User = require("../models/user.model");

module.exports.getUser = async (userId) => {
  return await User.findById(userId);
};

module.exports.updateUser = async (userId, body) => {
  return await User.findByIdAndUpdate({ _id: userId }, body, { new: true });
};

module.exports.createUser = async (body = {}) => {
  console.log(body);
  return await User.create(body);
};
