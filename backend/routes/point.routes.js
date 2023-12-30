const PointController = require("../controllers/point.controller");
const pointRouter = require("express").Router();
const verifyUser = require("../middleware/authMiddleware");

pointRouter.get("/friendsList", verifyUser.verifyToken, PointController.getTopThreeUserWithHighestPointInFriendsList);

pointRouter.get("/allUsers", verifyUser.verifyToken, PointController.getTopThreeUserWithHighestPointInAllUsers);

module.exports = pointRouter;
