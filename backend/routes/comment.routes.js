const CommentController = require("../controllers/comment.controller");
const commentRouter = require("express").Router();
const verifyUser = require("../middleware/authMiddleware");

commentRouter.post("/",verifyUser.verifyToken, CommentController.createComment);
commentRouter.put("/:id",verifyUser.verifyToken, CommentController.updateComment);
commentRouter.delete("/:id",verifyUser.verifyToken, CommentController.deleteComment);

module.exports = commentRouter;
