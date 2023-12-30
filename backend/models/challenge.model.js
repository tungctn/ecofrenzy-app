const mongoose = require("mongoose");

const challengeSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    point: {
      type: Number,
      default: 50,
    },
    category: {
      type: String,
    },
    // impact: {
    //   type: String,
    // },
    implementation: [
      {
        type: String,
        default: "",
      },
    ],
    description: {
      type: String,
      default: "",
    },
    level: {
      type: String,
      enum: ["Easy", "Intermediate", "Hard"],
    },
    // creativity: {
    //   type: String,
    //   enum: ["Direct", "Indirect"],
    // },
    caption: {
      type: String,
      default: "",
    },
    verification: [
      {
        type: String,
        default: "",
      },
    ],
  },
  { timestamps: true },
  { discriminatorKey: "itemtype" }
);

const Challenge = mongoose.model("Challenge", challengeSchema);
module.exports = Challenge;
