const app = require("./app");
const cron = require('node-cron');
const updateTodayChallenge = require("./updateTodayChallenge")

require("dotenv").config();
const port = process.env.PORT || 3000;

cron.schedule('0 0 * * *', () => {
  updateTodayChallenge.updateTodayChallenge();
}, {
  scheduled: true,
  timezone: "Asia/Ho_Chi_Minh"
});

app.listen(port, () => {
  console.log(`Server running ${port}`);
});
