const Request = require("../models/request.model");
const User = require("../models/user.model");

module.exports.createRequest = async (req, res) => {
  try {
    const {recipientId} = req.body;
    const currentUserId = req.user.id;
    let request = await Request.findOne({$and: [{requester: currentUserId}, {recipient: recipientId}, {status: 1}]})
    if(request) {
      return res.status(403).json({
        success: false,
        message: "Request has been created",
      });
    }

    request = await Request.create({
      requester: currentUserId,
      recipient: recipientId,
      status: 1,
    });

    return res.status(200).json({
      success: true,
      message: "request created successfully",
      request: request,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.updateRequest = async (req, res) => {
  try {
    const currentUserId = req.user.id;
    const requestId = req.params.id;
    const request = await Request.findById(requestId);
    const newStatus = req.body.status;
    console.log(currentUserId);
    console.log(request.recipient);
    if ( newStatus == 2 && request.status == 1 && currentUserId == request.recipient) {
      request.status = newStatus;
      const requester = await User.findById(request.requester);
      const recipient = await User.findById(request.recipient);
      console.log(requester, recipient);
      recipient.friends.push(request.requester);
      requester.friends.push(request.recipient);
      recipient.save();
      requester.save();
      request.save();
    } else if (newStatus == 3 && request.status == 1 && (currentUserId == request.recipient || currentUserId == request.requester)) {
      request.status = newStatus;
      request.save();
    } else {
      return res.status(403).json({
        success: false,
        message: "Can't update request",
      });
    }

    return res.status(200).json({
      success: true,
      message: "request updated successfully",
      request: request,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.getAllRequestExceptReject = async (req, res) => {
  try {
    const currentUserId = req.user.id;

    const listRequests = await Request.find({
      $and: [
          { $or: [{requester: currentUserId}, {recipient: currentUserId}] },
          { $or: [{status: 1}, {status: 2}] }
      ]
  })
  .populate("requester")
  .populate("recipient");

    return res.status(200).json({
      success: true,
      message: "get request successfully",
      listRequests: listRequests,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports.getRequestPendingByUser = async (req, res) => {
  try {
    const currentUserId = req.user.id;

    const listRequests = await Request.find({
      $and: [
        {recipient: currentUserId},
        {status: 1}
      ]
  })
  .populate("requester")
  .populate("recipient");

    return res.status(200).json({
      success: true,
      message: "get request successfully",
      listRequests: listRequests,
    });
  } catch (error) {
    return res.status(400).json({
      success: false,
      message: error.message,
    });
  }
};
