const RequestController = require("../controllers/request.controller");
const requestRouter = require("express").Router();
const verifyUser = require("../middleware/authMiddleware");

requestRouter.post("/",verifyUser.verifyToken, RequestController.createRequest);
requestRouter.put("/:id",verifyUser.verifyToken, RequestController.updateRequest);
requestRouter.get("/getAllRequestExceptReject",verifyUser.verifyToken, RequestController.getAllRequestExceptReject);
requestRouter.get("/getRequestPendingByUser",verifyUser.verifyToken, RequestController.getRequestPendingByUser);

module.exports = requestRouter;
