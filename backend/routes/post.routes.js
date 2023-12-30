const PostController = require("../controllers/post.controller");
const postRouter = require("express").Router();
const verifyUser = require("../middleware/authMiddleware");

postRouter.get("/",verifyUser.verifyToken, PostController.getPostsOfUserAndFriend);

postRouter.post("/",verifyUser.verifyToken, PostController.createPost);

module.exports = postRouter;
