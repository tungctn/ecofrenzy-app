const serverlessApp = require("@vendia/serverless-express");
const app = require("./app");

exports.handler = serverlessApp({ app });
