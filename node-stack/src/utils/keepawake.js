const https = require("https");
setInterval(function() {
    https.get(`${process.env.HEROKU_URL}nv1/api/v1/healthz`);
}, 300000); // every 5 minutes (300000)
