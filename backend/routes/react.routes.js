const ReactController = require("../controllers/react.controller");
const reactRouter = require("express").Router();
const verifyUser = require("../middleware/authMiddleware");

reactRouter.post("/",verifyUser.verifyToken, ReactController.createReact);
reactRouter.delete("/:id",verifyUser.verifyToken, ReactController.deleteReact);

module.exports = reactRouter;
