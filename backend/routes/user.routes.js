const UserController = require("../controllers/user.controller");
const userRouter = require("express").Router();
const verifyUser = require("../middleware/authMiddleware");

userRouter.get("/:userId/getTodayChallenge",verifyUser.verifyToken, UserController.getTodayChallenge);
userRouter.get("/:userId",verifyUser.verifyToken, UserController.getUser);
userRouter.patch("/:userId",verifyUser.verifyToken, UserController.updateUser);
userRouter.get("/:userId/friend-list",verifyUser.verifyToken, UserController.getFriendList);
userRouter.get("/:userId/friend-suggest",verifyUser.verifyToken, UserController.getSuggestFriend);
userRouter.patch(
  "/:userId/challenge/:challengeId/pick",
  verifyUser.verifyToken,
  UserController.pickChallenge
);
userRouter.patch(
  "/:userId/challenge/:challengeId/done",
  verifyUser.verifyToken,
  UserController.doneChallenge
);

module.exports = userRouter;
