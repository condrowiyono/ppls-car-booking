var express = require('express');
var router = express.Router();
var moment = require('moment');
const bookCarController = require("../controller/book-car");

router.post('/', function(req, res) {
	bookCarController.create(req,res)
});

router.post('/pay/:id', function(req, res) {
	bookCarController.pay(req,res)
});


module.exports = router;