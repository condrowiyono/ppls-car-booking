



//sadsad

/*jslint node: true */
"use strict";

var express = require('express');
var fs = require('fs');
var path = require("path");
var router = express.Router();
const db = require('../db');

function book_car(args,callback) {
  var req = {
    pickLocation  : args.pickLocation,
    pickDateTime  : args.pickDateTime,
    dropLocation  : args.dropLocation,
    dropDateTime  : args.dropDateTime,
    buyerName     : args.buyerName,
    buyerEmail    : args.buyerEmail,
    carID         : args.carID,
    pessengerID         : args.pessengerID,
    pessengerName       : args.pessengerName,
    pessengerEmail      : args.pessengerEmail,
    pessengerPhone      : args.pessengerPhone,
    pessengerAge        : args.pessengerAge,
    pessengerAddress    : args.pessengerAddress
  }
  var dropTime = new Date(req.dropDateTime);
  var pickTime = new Date(req.pickDateTime);
  var one_day = 1000*60*60*24;
  var diff = Math.round((dropTime - pickTime)/one_day);
  var price = 1000000 * diff;

  var data = {
    partnerId: 1,
    carInfo: req.carID,
    status: 0,
    buyerName: req.buyerName,
    buyerEmail: req.buyerEmail,
    invoiceId: new Date().getUTCMilliseconds(),
    totalAmount: price,
    expiredTime: Date.now() + (3*3600*1000),
    issuedAt: Date.now(),
    createdAt: Date.now(),
    bookings: {
      dropLocation: req.dropLocation,
      pickLocation: req.pickLocation,
      dropTime: new Date(req.dropDateTime),
      pickTime: new Date(req.pickDateTime),
      fare: 0,
      additionalFee: 0,
      discount: 0,
      totalAmount: price,
      createdAt: Date.now(),
      pessengers: {
        "identityId": req.pessengerID,
                "name": req.pessengerName,
                "email": req.pessengerEmail,
                "phone": req.pessengerPhone,
                "age": req.pessengerAge,
                "address": req.pessengerAddress
      }
    }
  }

  db.transactions.create(data,{include: [{model: db.bookings, include : [{model : db.pessengers}] }]}).then(transaction => {
    console.log(transaction.id);
    return callback({
      invoiceID : transaction.invoiceId,
      totalAmount : transaction.totalAmount,
      bookingCode : transaction.bookings[0].code,
      status : transaction.status
    })
  })
  
}

var serviceObject = {
  BookService: {
        BookSOAPPort: {
            bookCar: book_car
        }
    }
};


// load the WSDL file
// var xml = fs.readFileSync('service.wsdl', 'utf8');
var xml = fs.readFileSync(path.resolve(__dirname, "../wsdl/car-book.wsdl"), 'utf8');
// create express app

// root handler
router.get('/', function (req, res) {
  res.send('Node Soap Example!<br /><a href="https://github.com/macogala/node-soap-example#readme">Git README</a>');
})


var bookSoapProp = {
  serviceObject : serviceObject,
  xml : xml,
  router: router,
  wsdlPath : "/book/wsdl"
}


module.exports = bookSoapProp;

