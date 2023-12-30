const mongoose = require("mongoose");

const todayChallengeSchema = new mongoose.Schema(
  {
    status: {
      type: String,
      enum: ["Start", "UnPicked", "Picked", "Pending", "Done"],
      default: "Start",
    },
    url: {
      type: String,
      default: "",
    },
    isDone: {
      type: Boolean,
      default: false,
    },
  },
  { strict: false }
);

const userSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      default: "Anonymous",
    },
    email: {
      type: String,
      required: [true, "Please enter your username"],
      trim: true,
      unique: true,
    },
    password: {
      type: String,
      required: [true, "Please enter your password"],
      trim: true,
    },
    age: {
      type: Number,
      default: 18,
    },
    gender: {
      type: String,
      enum: ["Male", "Female", "Other"],
      default: "Male",
    },
    image: {
      type: String,
      default: "https://d2n33bp2yovvw9.cloudfront.net/avatar.png",
    },
    totalPoint: {
      type: Number,
      default: 0,
    },
    todayChallenge: [todayChallengeSchema],
    friends: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "User",
      }
    ],
  },
  { timestamps: true },
  { strict: false }
);

const User = mongoose.model("User", userSchema);
module.exports = User;
