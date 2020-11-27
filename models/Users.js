const mongoose = require('mongoose');

const UserSchema = mongoose.Schema({
  etunimi: { type: String },
  sukunimi: { type: String },
  lahiosoite: { type: String },
  postitoimipaikka: { type: String },
  postinro: { type: Number },
  email: { type: String },
  puhelinnro: { type: String },
  laskutustapa: { type: Number }
});

module.exports = mongoose.model("Users", UserSchema);
