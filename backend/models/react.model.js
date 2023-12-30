const mongoose = require("mongoose");

const reactSchema = new mongoose.Schema({
  post: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: "Post",
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    required: true,
    ref: "User",
  },
})

const React = mongoose.model("React", reactSchema);
module.exports = React;
