const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const challengeService = require("../services/challenge.service");
const User = require("../models/user.model");


module.exports.login = async (req, res) => {
  try {
    if (!req.body.email || !req.body.password) {
      return res.status(400).json({
        message: "Khong du thong tin dang nhap",
      });
    }

    const user = await User.findOne({ email: req.body.email });
    if (!user) {
      return res.status(400).json({
        message: "Email khong ton tai",
      });
    }
    const isMatch = await bcrypt.compare(req.body.password, user.password);

    if (!isMatch) {
      return res.status(400).json({
        message: "Sai mat khau",
      });
    }

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, {
      expiresIn: "365d"
    });
    delete user.password;

    res.status(200).json({
      message: "Dang nhap thanh cong",
      success: true,
      token: token,
      user: user,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports.register = async (req, res) => {
  const hashPassword = await bcrypt.hash(req.body.password, 10);
  const randomchallenges = await challengeService.getRandomChallenge();
  console.log(randomchallenges);
  const user = await User.create({
    email: req.body.email,
    password: hashPassword,
    name: req.body.name,
    todayChallenge: randomchallenges,
  });
  return res.status(200).json({
    message: "Dang ky thanh cong",
    user: user,
  });
};
