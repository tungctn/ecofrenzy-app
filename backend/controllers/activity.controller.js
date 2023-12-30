const Activity = require("../models/activity.model");
const Challenge = require("../models/challenge.model");
const Post = require("../models/post.model");
const User = require("../models/user.model");
require("../config");

module.exports.addActivity = async (req, res) => {
  const { user, challenge } = req.body;
  try {
    const newActivity = await Activity.create({
      user,
      challenge,
    });
    res.status(201).json({
      message: "success",
      activity: newActivity,
    });
  } catch (error) {
    res.status(500).json(error);
  }
};

module.exports.getActivity = async (req, res) => {
  try {
    const activity = await Activity.findOne({ user: req.params.userId })
      .populate("user")
    res.status(200).json({
      message: "success",
      activity: activity,
    });
  } catch (error) {
    res.status(500).json(error);
  }
};

// const addActivity = async () => {
//   const posts = await Post.find()
//     // .populate("challenge")
//     // .populate("user")
//     .sort({ createdAt: -1 });
//   console.log(posts);
//   for (let i = 0; i < posts.length; i++) {
//     let activity;
//     const user = await User.findById(posts[i].user);
//     console.log(user);
//     activity = await Activity.findOne({ user: posts[i].user });
//     let challengePost = await Challenge.findById(posts[i].challenge);
//     let challenge = { ...challengePost._doc };
//     challenge.isDone = true;
//     challenge.status = "Done";
//     challenge.url = posts[i].image;
//     console.log(challenge);
//     if (activity) {
//       activity = await Activity.findOneAndUpdate(
//         { user: posts[i].user._id },
//         {
//           $push: {
//             challenge: challenge,
//           },
//         },
//         { new: true }
//       );
//     } else {
//       activity = await Activity.create({
//         user: posts[i].user,
//         challenge: [challenge],
//       });
//     }
//     console.log(activity);
//   }
// };

// addActivity();
