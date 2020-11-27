const express = require('express');
const router = express.Router();
const Toimipiste = require('../models/Toimipiste');

router.get("/", (req, res) => {
  Toimipiste.find({})
  .then((resp) => res.status(200).json(resp))
  .catch((err) => res.status(400).json("Request failed"));
});

router.post("/", async(req,res) => {
  try {
    const {nimi, lahiosoite, postinro, postitoimipaikka, email, puhelinnro} = req.body;

    const newToimipiste = new Toimipiste({
      nimi: nimi,
      lahiosoite: lahiosoite,
      postinro: postinro,
      postitoimipaikka: postitoimipaikka,
      email: email,
      puhelinnro: puhelinnro
    });

    const savedToimipiste = await newToimipiste.save();
    res.status(200).json(savedToimipiste)

  } catch (err) {
    res.status(500).json({ error: err.message })
  }
});
module.exports = router;
