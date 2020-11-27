const mongoose = require('mongoose');

const ToimipisteSchema = mongoose.Schema({
  nimi: { type: String },
  lahiosoite: { type: String },
  postitoimipaikka: { type: String },
  postinro: { type: String },
  email: { type: String },
  puhelinnro: { type: String }
});

module.exports = mongoose.model("Toimipiste", ToimipisteSchema);
