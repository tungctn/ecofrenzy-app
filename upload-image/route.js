const route = require("express").Router();
const multer = require("multer");
const multerS3 = require("multer-s3");
const { S3Client } = require("@aws-sdk/client-s3");

const s3Client = new S3Client();

const upload = multer({
  storage: multerS3({
    s3: s3Client,
    bucket: "social-media-image",
    contentType: multerS3.AUTO_CONTENT_TYPE,
    key: function (req, file, cb) {
      cb(null, Date.now().toString());
    },
  }),
});

route.post("/upload", upload.single("image"), (req, res) => {
  res.json({
    status: "OK",
    key: "req.file.key",
    url: `https://d2n33bp2yovvw9.cloudfront.net/${req.file.key}`,
  });
});

module.exports = route;
