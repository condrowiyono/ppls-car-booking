var express = require('express');
var router = express.Router();
var moment = require('moment');

router.get('/', function(req, res, next) {
	var pick = req.query.pick
	var date = moment(req.query.date).format('YYYY-MM-DD HH:mm:ss');
	var query = "SELECT DISTINCT a.*, d.name\
				FROM (cars as a, transactions as b, bookings as c )\
				JOIN locations as d\
				ON a.checkpoint_id=d.id\
				WHERE ((a.status = 0) OR (b.id = c.transaction_id AND a.id = b.car_id AND c.drop_time <='" + date+ "')) " + 
				"AND d.name like '" + pick + "'";
	res.locals.connection.query(query, function (error, results, fields) {
	  	if(error){
	  		res.send(JSON.stringify({"status": 500, "error": error, "response": null})); 
	  		//If there is error, we send the error in the error section with 500 status
	  	} else {
	  		
  			res.send(JSON.stringify({"date": date ,"status": 200, "error": null, "response": results}));
  			//If there is no error, all is good and response is 200 OK.
	  	}
  	});
});

router.get('/getCarInfo', function(req, res, next) {
	var id = req.query.id;
	var query = "SELECT * FROM cars WHERE id = " + id;
	res.locals.connection.query(query, function (error, results, fields) {
	  	if(error){
	  		res.send(JSON.stringify({"status": 500, "error": error, "response": null})); 
	  		//If there is error, we send the error in the error section with 500 status
	  	} else {
  			res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
  			//If there is no error, all is good and response is 200 OK.
	  	}
  	});
});

router.put('/', function (req, res) {
	var id = req.body.id;
	var query = "UPDATE cars SET status = 1 WHERE id = " + id + " ";
	res.locals.connection.query(query, function(error, results, fields) {
		if(error){
			res.send(JSON.stringify({"status": 500, "error": error, "response": null})); 
			//If there is error, we send the error in the error section with 500 status
		} else {
			
			res.send(JSON.stringify({"status": 200, "error": null, "response": results}));
			//If there is no error, all is good and response is 200 OK.
		}
	})
})

module.exports = router;
