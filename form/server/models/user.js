const mongoose = require("mongoose");

const userScheema = mongoose.Schema({
    username: {
        required: true,
        type: String,
        trim: true
    },
    password: {
        required:true,
        type: String,
    }
});

const User = mongoose.model("User", userScheema);

module.exports = User;