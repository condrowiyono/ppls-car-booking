/*jslint node: true */
"use strict";

var express = require('express');
var fs = require('fs');
var path = require("path");
var router = express.Router();
const db = require('../db');

var axios = require('axios');

var camundaBase = process.env.CAMUNDA_URL + "/engine-rest/process-definition/key/Car_Availabillity/start";


function cancel_book_car(args,callback) {
  var req = {
    idTransaksi  : args.idTransaksi,
  }

  //////////
  axios({
    method: 'POST',
    url: camundaBase,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
    data: { "variables":
        {
        "FormKodeBooking": {
          "value": req.idTransaksi
        },
        
      }
    }
  });

  ////////
  /*
  db.transactions.update({
    id: req.idTransaksi,
    status: 2,
    cancelAt:Date.now(),
    updatedAt:Date.now(),
  }, {where:{id: req.idTransaksi}})

  .then(affectedRow => {
    return db.transactions.findOne({where: {id:req.idTransaksi}})
  })

  .then(transaction => {
    return callback({
      idTransaksi : transaction.id,
      buyerName : transaction.buyerName,
      buyerEmail : transaction.buyerEmail,
      totalAmount : transaction.totalAmount,
      status : transaction.status
    })
  });
  */
  db.transactions.findOne({where: {id:req.idTransaksi}})
  .then(transaction => {
    return callback({
      idTransaksi : transaction.id,
      buyerName : transaction.buyerName,
      buyerEmail : transaction.buyerEmail,
      totalAmount : transaction.totalAmount,
      status : transaction.status
    })
  });
}

var serviceObject = {
  CancelBookService: {
        CancelBookSOAPPort: {
            cancelBookCar: cancel_book_car
        }
    }
};


// load the WSDL file
// var xml = fs.readFileSync('service.wsdl', 'utf8');
var xml = fs.readFileSync(path.resolve(__dirname, "../wsdl/cancel-car-book.wsdl"), 'utf8');
// create express app

// root handler
router.get('/', function (req, res) {
  res.send('Node Soap Example!<br /><a href="https://github.com/macogala/node-soap-example#readme">Git README</a>');
})


var cancelBookSoapProp = {
  serviceObject : serviceObject,
  xml : xml,
  router: router,
  wsdlPath : "/cancel-book/wsdl"
}


module.exports = cancelBookSoapProp;

