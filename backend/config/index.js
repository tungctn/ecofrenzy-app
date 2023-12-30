const mongoose = require("mongoose");
const dbConfig = require("./db");

mongoose.connect(dbConfig.uri, dbConfig.options);

mongoose.connection.on("connected", () => {
  console.log("Connected to MongoDB");
});

mongoose.connection.on("error", (err) => {
  console.error(`MongoDB connection error: ${err}`);
});
