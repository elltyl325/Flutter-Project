var express = require('express')
var mongojs = require('mongojs')
var app = express()
var db = require('./myDB.js')

app.use(express.json())
app.get('/', (req, res) => {console.log("HELLO");})

app.get('/getAll', (req, res) => {
  db.printAllInCollection('userData', function(docs){
    console.log("Cities: ", docs);
    res.send(docs)
  });
});

app.post('/getData', (req, res) => {
  db.printAllInCollection(req.body.name , function(docs){
    res.send(docs)
  });
});

app.post('/insertData', (req, res) => {
  db.insertToCollection(req.body.name, req.body._id, req.body.date, req.body.day, req.body.month, req.body.year, req.body.start, req.body.end, req.body.time, req.body.timedouble, req.body.rating, function(items){
    res.send(items)
  });
});

app.post('/getDocument', (req, res) => {
  db.getDocument(req.body.name, req.body.id, function(doc){
    res.send(doc)
  });
})

app.listen(3000, ()=>console.log("listening on port 3000"));
