const mongoose = require("mongoose");

const requestSchema = new mongoose.Schema(
  {
    requester: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
    recipient: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
    status: {
      type: Number,
      enum: [
        1, //'requested',
        2, //'accept',
        3, //'reject',
      ],
      required: true,
    },
  },
  { timestamps: true }
);


const Request = mongoose.model("Request", requestSchema);
module.exports = Request;
