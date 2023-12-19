const app = require("express")();
app.use(require("express").json());
app.use(require("cors")());

app.use("/api", require("./route"));

module.exports = app;
// app.listen(3000, () => {
//   console.log("Server listening on port 3000");
// });
