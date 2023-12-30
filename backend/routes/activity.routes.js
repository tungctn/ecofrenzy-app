const activityRoute = require("express").Router();
const activityController = require("../controllers/activity.controller");
const verifyUser = require("../middleware/authMiddleware");

/**
 * @swagger
 * /items:
 *   get:
 *     summary: Retrieve a list of items
 *     responses:
 *       200:
 *         description: A list of items.
 */

activityRoute.post("/", verifyUser.verifyToken, activityController.addActivity);
activityRoute.get(
  "/:userId",
  verifyUser.verifyToken,
  activityController.getActivity
);

module.exports = activityRoute;
