const db = require('../db');

exports.create = function(req, res){
	var dropTime = new Date(req.body.dropDateTime);
	var pickTime = new Date(req.body.pickDateTime);
	var one_day = 1000*60*60*24;
	var diff = Math.round((dropTime - pickTime)/one_day);
	var price = 1000000 * diff;

	var data = {
		partnerId: 1,
		carInfo: req.body.carID,
		status: 0,
		buyerName: req.body.buyerName,
		buyerEmail: req.body.buyerEmail,
		invoiceId: new Date().getUTCMilliseconds(),
		totalAmount: price,
		expiredTime: Date.now() + (3*3600*1000),
		issuedAt: Date.now(),
		createdAt: Date.now(),
		bookings: {
			dropLocation: req.body.dropLocation,
			pickLocation: req.body.pickLocation,
			dropTime: new Date(req.body.dropDateTime),
			pickTime: new Date(req.body.dropDateTime),
			fare: 0,
			additionalFee: 0,
			discount: 0,
			totalAmount: price,
			createdAt: Date.now(),
			pessengers: {
				"identityId": req.body.pessengerID,
                "name": req.body.pessengerName,
                "email": req.body.pessengerEmail,
                "phone": req.body.pessengerPhone,
                "age": req.body.pessengerAge,
                "address": req.body.pessengerAddress
			}
		}
	}
	db.transactions.create(data,{include: [{model: db.bookings, include : [{model : db.pessengers}] }]}).then(transaction => {
		res.json({
			"status": "Success",
			"data" : transaction,
		});
	})
}


exports.pay = function(req, res){
	var a ;
	a = {
			id: req.params.id,
			status: req.body.status,
			paymentInfo : req.body.payment,
			bookedAt: Date.now(),
		}	 

	db.transactions.update(a, {where:{id: req.params.id}})

	.then(affectedRow => {
		var booking_data = db.transactions.findOne({where: {id:req.params.id}, include: [{model: db.bookings}]});
		return booking_data
	})
	.then(booking_data => {
		var id = booking_data.bookings[0].dataValues.id;
		var b = { 
			code : "BOOK" + new Date().getUTCMilliseconds(),
		}

		db.bookings.update(b,{where:{id: id}})
		.then(affectedRow => {
			var booking_data = db.transactions.findOne({where: {id:req.params.id}, include: [{model: db.bookings}]});
			return booking_data
		}).then(transactions => {
			res.json({
				"status": "Success",
				"data" : transactions,
			});
		});
	})	
}