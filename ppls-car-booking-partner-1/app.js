require('dotenv').config();

var express = require('express');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var carsRouter = require('./routes/cars');


var app = express();

var mysql = require("mysql");
//Database connection
app.use(function(req, res, next){
	res.locals.connection = mysql.createConnection({
		host     : process.env.DB_HOST,
		port     : process.env.DB_PORT,
		user     : process.env.DB_USER,
		password : process.env.DB_PASS,
		database : process.env.DB_NAME
	});
	res.locals.connection.connect();
	next();
});

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());


app.use('/api/v1/cars', carsRouter);

module.exports = app;
