const Challenge = require("../models/challenge.model");
const User = require("../models/user.model");
require("../config");
const logger = require("../utils/logger");

const generateChallenges = async () => {
  const challenges = await Challenge.aggregate([{ $sample: { size: 3 } }]);
  logger.info("Challenges retrieved successfully");
  console.log(challenges);
  const user = await User.findOneAndUpdate(
    { _id: "648a9ef8e34a41260a77e773" },
    { todayChallenge: challenges },
    { new: true }
  );

  logger.info("Challenges generated");
  logger.info(user.todayChallenge);
  console.log(user);
};

generateChallenges();
