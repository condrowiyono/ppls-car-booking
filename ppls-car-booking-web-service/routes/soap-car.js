/*jslint node: true */
"use strict";

var express = require('express');
var fs = require('fs');
var path = require("path");
var router = express.Router();
var moment = require('moment');
var axios = require('axios');
var serviceBase = "http://localhost:3000/api/v1/";

var camundaBase = "http://localhost:8080/engine-rest/process-definition/key/Car_Availabillity/start";


function car_availability(args,callback) {
  var request = {
    pickLocation  : args.pickLocation,
    pickDateTime  : args.pickDateTime,
    dropLocation  : args.dropLocation,
    dropDateTime  : args.dropDateTime,
    typeCode      : args.typeCode,
    sortMethod    : args.sortMethod,
    priceFrom     : args.priceFrom,
    priceTo       : args.priceTo,
  }

  var pickDate = moment(request.pickDateTime).format('YYYY-MM-DD HH:mm:ss');
  var dropDate = moment(request.dropDateTime).format('YYYY-MM-DD HH:mm:ss');
  var uri = serviceBase + "cars?pick=" + request.pickLocation + "&date=" + pickDate + "&drop=" + dropDate;
  console.log(uri);
  var daydiff = moment.duration(moment(dropDate).diff(moment(pickDate))).asDays(); 


  axios.get(uri)
    .then(function (response) {
      console.log(response.data.response);
      
      var hasil = [];
      var responses = response.data.response;
      for (var i = 0; i < responses.length; i++) {
          hasil.push({
            frequency : daydiff,
            rate: daydiff * responses[i].fare,
            Car: {
              carID: {
                partner: 1,
                id: responses[i].id
              },
              model: responses[i].model,
              type: responses[i].type,
              seats: responses[i].seat,
              rate: responses[i].fare,
              gear: responses[i].gear,
              have_ac: responses[i].have_ac
            }
          })
      };

      return callback({
        searchSummary : request,
        arrayCarAvailable : hasil,
      });
    })
    .catch(function (error) {
      console.log(error);
    });

    axios({
      method: 'POST',
      url: camundaBase,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      data: { "variables":
        {
        "FormDate": {
          "value": request.pickDateTime
        },
        "FormPick": {
          "value": request.pickLocation
        }
      }
      }
    });


}

var serviceObject = {
  CarAvailabilityService: {
        CarAvailabilitySOAPPort: {
            getAvailability: car_availability
        }
    }
};


// load the WSDL file
// var xml = fs.readFileSync('service.wsdl', 'utf8');
var xml = fs.readFileSync(path.resolve(__dirname, "../wsdl/car-availability.wsdl"), 'utf8');
// create express app

// root handler
router.get('/', function (req, res) {
  res.send('Node Soap Example!<br /><a href="https://github.com/macogala/node-soap-example#readme">Git README</a>');
})


var carSoapProp = {
  serviceObject : serviceObject,
  xml : xml,
  router: router,
  wsdlPath : "/car/wsdl"
}


module.exports = carSoapProp;