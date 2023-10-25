"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express = require('express');
/* const {engine} = require('express-handlebars');
const myconnection = require('express-myconnection');
const mysql = require('mysql');
const session = require('express-session');
const bodyParser = require('body-parser'); */
const app = express();
app.set('port', 3000);
app.listen(app.get('port'), () => {
    console.log('Server on port', app.get('port'));
});
