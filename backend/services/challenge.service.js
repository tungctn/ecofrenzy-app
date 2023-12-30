const Challenge = require("../models/challenge.model");

module.exports.createChallenge = async (challenge) => {
  return await Challenge.create(challenge);
};

module.exports.getAllChallenges = async () => {
  return await Challenge.find();
};

module.exports.getRandomChallenge = async () => {
  return await Challenge.aggregate([{ $sample: { size: 3 } }]);
};
