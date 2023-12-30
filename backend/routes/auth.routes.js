const authRoute = require("express").Router();
const authController = require("../controllers/auth.controller");

authRoute.post("/login", authController.login);
authRoute.post("/register", authController.register);

module.exports = authRoute;