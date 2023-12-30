const challengeRouter = require("express").Router();
const ChallengeController = require("../controllers/challenge.controller");
const verifyUser = require("../middleware/authMiddleware");

// @get random challenge
challengeRouter.get(
  "/random/:id",
  verifyUser.verifyToken,
  ChallengeController.getRandomChallenge
);
challengeRouter.get("/reset", ChallengeController.resetTodayChallenge);

module.exports = challengeRouter;
