const express = require('express');
const router = express.Router();
const Users = require('../models/Users');

router.get("/", (req, res) => {
  Users.find()
  .then((resp) => res.status(200).json(resp))
  .catch((err) => res.status(400).json("Request failed"));
});

module.exports = router;
