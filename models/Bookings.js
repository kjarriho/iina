const mongoose = require('mongoose');

const BookingSchema = mongoose.Schema({
  varattu_pvm: { type: String },
  vahvistus_pvm: { type: String },
  varattu_alkupvm: { type: String },
  owner: { type: String },
  toimipiste_id: { type: Number }
});

module.exports = mongoose.model("Booking", BookingSchema);
