const express = require('express');
const router = express.Router();
const Booking = require('../models/Bookings');

router.get("/", (req, res) => {
  Booking.find({})
  .then((resp) => res.status(200).json(resp))
  .catch((err) => res.status(400).json("Request failed"));
});

router.post("/new", async(req,res) => {
  try {
    const {varattu_pvm, vahvistus_pvm, varattu_alkupvm, owner, toimipiste_id} = req.body;

    const newBooking = new Booking({
      varattu_pvm: varattu_pvm,
      vahvistus_pvm: vahvistus_pvm,
      varattu_alkupvm: varattu_alkupvm,
      owner: owner,
      toimipiste_id: toimipiste_id
    });

    const savedBooking = await newBooking.save();
    res.status(200).json(savedBooking)

  } catch (err) {
    res.status(500).json({ error: err.message })
  }
});
module.exports = router;
