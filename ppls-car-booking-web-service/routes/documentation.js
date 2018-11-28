var express = require('express');
var router = express.Router();
var fs = require('fs');
var path = require("path");


var dokumentasi = "<h2>Our WSDL</h2><ul><li><a href='/car/wsdl?wsdl'>WSDL CAR AVAILABILITY</a></li><li><a href='/book/wsdl?wsdl'>WSDL CAR BOOKING</a></li><li><a href='/cancel-book/wsdl?wsdl'>WSDL CAR CANCEL BOOKING</a></li></ul><h2>Our Endpoint API (REST)</h2><a href='https://documenter.getpostman.com/view/5725595/RzfcLqnV'>API Doc</a>";
router.get('/', function(req, res) {
	res.send(dokumentasi);
});



module.exports = router;