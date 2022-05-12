const mongojs = require('mongojs'); //imports 'mongojs'
const assert = require('assert'); //Assertion for queries

// Connection URL
const url = "mongodb://localhost:33333/"; 
//URL with database included for local mongo db

// Database Name
const collections=["userData"]; //list of collections that you will be accessing. 
mongodb = mongojs(url, collections);

module.exports = {
        
    printAllInCollection : function(collectionName, callback){
        var cursor = mongodb.collection(collectionName).find({}).limit(10, function(err, docs){
            if(err || !docs) {
                console.log("Cannot print database or database is empty\n");
            }
            else {
                callback(docs);
            }
        });

    },

    insertToCollection : function(collectionName, id, dateVal, dayVal, monthVal, yearVal, startVal, endVal, timeVal, timeDVal, ratingVal, callback){
        var insertElements = {date : dateVal, D: dayVal, M: monthVal, Y:yearVal, start: startVal, end: endVal, time: timeVal, timedouble: timeDVal, rating: ratingVal};
        
        // if(id == "null"){
        //     insertElements = {"_id" : mongojs.ObjectId(id), D: dayVal, M: monthVal, Y:yearVal, start: startVal, end: endVal, time: timeVal, rating: ratingVal};
        // }else{
        //     insertElements = {D: dayVal, M: monthVal, Y:yearVal, start: startVal, end: endVal, time: timeVal, rating: ratingVal};
        // }

        var cursor = mongodb.collection(collectionName).save(insertElements, function(err, res){

            if(err) {
                console.log('Error occurred while inserting');
            } else {
               console.log('inserted record');
               callback(insertElements);
            }
        });

    },

    getDocument : function(collectionName, id, callback){
        var doc = { "_id" : mongojs.ObjectId(id) };
        var cursor = mongodb.collection(collectionName).find(doc, function(err, res){

            if(err) {
                console.log('Error occurred');
            } else {
               callback(res);
            }
        });

    }
    
}

