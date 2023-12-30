const mongoose = require("mongoose");

const ActivitySchema = new mongoose.Schema({
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
  },
  challenge: [],
});

const Activity = mongoose.model("Activity", ActivitySchema);
module.exports = Activity;
