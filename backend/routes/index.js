const appRouter = require("express").Router();

appRouter.use("/user", require("./user.routes"));
appRouter.use("/challenge", require("./challenge.routes"));
appRouter.use("/post", require("./post.routes"));
appRouter.use("/auth", require("./auth.routes"));
appRouter.use("/activity", require("./activity.routes"));
appRouter.use("/point", require("./point.routes"));
appRouter.use("/request", require("./request.routes"));
appRouter.use("/comment", require("./comment.routes"));
appRouter.use("/react", require("./react.routes"));

module.exports = appRouter;
