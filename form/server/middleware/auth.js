const jwt = require('jsonwebtoken');

const auth = async (req, res, next) => {

    try {
        const token = req.header("x-auth-token");
        if (!token) 
            return res.status(401).json({msg: "No auth token, access denide"});
           
        const verified = jwt.verify(token, "passwordkey");
            if (!verified) 
                return res.status(401).json({msg:"Token verification faild, authorization denide"});
            req.user = verified.id;
            console.log(`this is req.user : ${req.user}`)
            req.token = token;
            next();
    } catch (error) {
        res.status(500).json({error: error.message});
    }
}

module.exports = auth;