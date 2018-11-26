var express = require('express');
var router = express.Router();
var moment = require('moment');
const transactionsController = require("../controller/transactions");

router.get('/', function(req, res) {
	transactionsController.getAll(req,res)
});

router.post('/', function(req, res) {
	console.log(req.body);
	transactionsController.create(req,res)
});

router.post('/change-status', function(req, res) {
	transactionsController.changeStatus(req,res)
});

router.post('/add-payment/:id', function(req, res) {
	transactionsController.addPayment(req,res)
});

//by invoice
router.get('/status', function(req, res) {
	transactionsController.checkStatus(req,res)
});

router.get('/:id', function(req, res) {
	transactionsController.find(req,res)
});

router.put('/successBooking', function(req, res) {
	transactionsController.successBooking(req,res)
});

router.delete('/:id', function(req, res) {
	transactionsController.delete(req,res)
});

router.put('/cancelbooking/', function(req, res) {
	transactionsController.cancelBooking(req,res)
});


router.put('/expireBooking/', function(req, res) {
	transactionsController.expireBooking(req,res)
});

module.exports = router;
