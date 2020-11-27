const express = require('express');
const app = express();
const mongoose = require('mongoose');
const cors = require('cors');

// Routes
const userRouter = require('./routers/users');
const toimipisteRouter = require('./routers/toimipiste');
const bookingRouter = require('./routers/bookings');

// Middleware
app.use(cors());
app.use(express.static('public'));

app.use(express.json());
app.use("/users", userRouter);
app.use("/toimipiste", toimipisteRouter);
app.use("/bookings", bookingRouter);

const port = process.env.port || 5000;

mongoose
  .connect('mongodb://localhost/Iina', {
    useNewUrlParser: true,
    useUnifiedTopology: true
  })
  .then(() => console.log("connected to database"))
  .catch((err) => console.log("error: ", err));

app.get("/", (req,res) => {
  res.json("works")
})


app.listen(port, () => console.log(`running on port ${port}`));
