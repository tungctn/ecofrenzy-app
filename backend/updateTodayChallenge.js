const Challenge = require("./models/challenge.model");
const User = require("./models/user.model");

module.exports.updateTodayChallenge = async () => {
  const allUsers = await User.find();
  for (let index = 0; index < allUsers.length; index++) {
    const randomChallenges = await Challenge.aggregate([{ $sample: { size: 3 } }]);
    const user = allUsers[index];
    user.todayChallenge = randomChallenges;
    user.save();
  }
}
