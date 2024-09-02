const express = require("express");
const authRouter = express.Router();
const bcryptjs = require("bcryptjs");
const User = require("../models/user");
const jwttoken = require("jsonwebtoken");
const auth = require("../middleware/auth");


//sign up
authRouter.post("/api/signup", async (req, res)=> {
    try {
        const {username, password} = req.body;

        const existigUsers = await User.findOne({username});
        if (existigUsers) {
            return res.status(400).json({msg: "User with same name already exists"}) 
        }

        const hashedpassword = await bcryptjs.hash(password, 8);

       let user = User({
        username, password:hashedpassword,
       });
       user = await user.save();
       res.json(user);
    } catch (e) {
        res.status(500).json({error: e.message})
    }
});


//signin
authRouter.post("/api/signin", async(req, res)=> {
    try {
        const {username, password} = req.body;

        const user = await User.findOne({username});
        if (!user) {
            return res.status(400).json({msg: "User with this username not exist!"});
        }

        const ismatch = await bcryptjs.compare(password, user.password);
        if (!ismatch) {
            return res.status(400).json({msg:"Incorrect password"});
        }

        const token = jwttoken.sign({id: user._id}, "passwordkey");
        res.json({token, ...user._doc});
    } catch (e) {
        res.status(500).json({error: e.message});
    }
})

authRouter.post("/tokenIsValid", async (req, res)=> {
    try {
        const token = req.header("x-auth-token");
       console.log('token')
        if (!token) return res.json(false);

        const verified = jwttoken.verify(token, "passwordkey");
       if (!verified) return res.json(false);
        
       const user = await User.findById(verified.id);
       if (!user) return res.json(false);

        res.json(true);
    } catch (error) {
        res.status(500).json({error: error.message});
    }
})

//get user data
authRouter.get("/", auth, async (req, res)=> {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
})

module.exports = authRouter;