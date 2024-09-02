const express = require("express");
const mongoos = require("mongoose");
const dotenv = require("dotenv");
const authRouter = require("./routers/auth")

const PORT= process.env.PORT || 3000;
dotenv.config()

const app = express();

app.use(express.json());
app.use(authRouter);

const DB= process.env.DB_URL;

mongoos.connect(DB).then(()=> {
    console.log("db connected")
}).catch((e)=> {
    console.log(e);
});

app.listen(PORT, "0.0.0.0", ()=> {
    console.log(`conneted at ${PORT}`);
})
