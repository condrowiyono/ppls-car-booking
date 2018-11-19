var express = require('express');
var router = express.Router();
var moment = require('moment');
var axios = require('axios');
var qs = require('qs');
var serviceBase = "http://localhost:3000/api/v1/";

router.get('/', function(req, res, next) {
	//get data from partner
	var pick = req.query.pick;
	var date = moment(req.query.date).format('YYYY-MM-DD HH:mm:ss');
	var uri = serviceBase + "cars?pick=" + pick + "&date=" + date;
	axios.get(uri)
		.then(function (response) {
			res.send(response.data);
		})
		.catch(function (error) {
			console.log(error);
		});
});

router.get('/getCarInfo/', function(req, res, next) {
	var id = req.query.id;
	var uri = serviceBase + "cars/getCarInfo?id=" + id;
	axios.get(uri)
		.then(function (response) {
			res.send(response.data);
		})
		.catch(function (error) {
			console.log(error);
		});
});

router.put('/bookingCar', function(req, res, next) {
	//edit status car
	var uri = serviceBase+ 'cars';
	axios({
		method: 'PUT',
		url: uri,
		data: qs.stringify({
			id: req.body.id,
		})
	})
	.then(function (response) {
		res.send(response.data);
	})
	.catch(function (error) {
		console.log(error);
	});
});

module.exports = router;
