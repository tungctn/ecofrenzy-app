require("dotenv").config();
require("./config");
const swaggerUi = require("swagger-ui-express");

const app = require("express")();
app.use(require("express").json());
app.use(require("cors")());
app.use("/api", require("./routes"));
app.use(
  "/api-docs",
  swaggerUi.serve,
  swaggerUi.setup(require("./utils/api-docs"))
);

module.exports = app;
