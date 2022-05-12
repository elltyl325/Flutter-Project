import 'package:flutter/material.dart';
import 'package:units/dreams/utils/dreams_constant.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import "package:units/api.dart";
import 'dart:convert';
import '../views/log_sleep_page.dart';

//Map of all active user data
Map<String, dynamic> tempUserData = {};

//List of IDs for texting
List<String> testIDs = ["618314756b8f9b3354df8998", "6180413d6859896358470345",
  "61889e083ee1b828b41968aa", "6180413d6859896358470345", "618044dc6859896358470346",
  "61804e79ca0a6f2ed496fcd8", "618314756b8f9b3354df8998", "61889c143ee1b828b41968a9",
  "61889e083ee1b828b41968aa", "6188a0543ee1b828b41968ab", "6188bc5a3ee1b828b41968ac"];

//list of active IDs
List<String> userIDs = [];

//Returns user data in a list sorted by date from newest to oldest
List<Map<String, dynamic>> getListDataSorted(){
  List<Map<String, dynamic>> dataList = [];

  tempUserData.entries.map((e) => dataList.add(e.value)).toList();
  dataList.sort((a, b) => b["date"].compareTo(a["date"]));

  //print(dataList);

  return dataList;
}

//Returns user data in a map sorted by date from newest to oldest
Map<String, dynamic> getMapDataSorted(){
  List<Map<String, dynamic>> temp = getListDataSorted();
  Map<String, dynamic> dataMap = {};

  temp.forEach((element) =>
  dataMap[element["_id"]] = element
  );

  //print(dataMap);

  return dataMap;
}

//Cass' Key: 'idList'
//April's Key: 'aprilList'

//Sets the list of IDs saved by SharedPreferences
void setList(List<String> list) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setStringList('aprilList', list);
}

//Returns the list of IDs saved by SharedPreferences (called on start)
Future<List<String>?> getList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList('aprilList');
  return list;
}

//Returns current map of user data
Map<String, dynamic> getTempUserData(){
  return tempUserData;
}

//returns current list of IDs
List<String> getIDs(){
  return userIDs;
}

// pass in a list of IDs to add all the corresponding documents to tempUserData
void getAllUserData(List<String> ids) async {
  for(int i = 0; i < ids.length; i++){
    String temp = await getById(ids[i]);
    addTempData(temp);
  }

  //print(tempUserData);
}

//pass in an ID and get back a string for the JSON doc with that ID
Future<String> getById(String id) async {
  final dio = Dio();	// Http client
  final client = RestClient(dio);	// Creating Http client to handle API requests

  Map<String, dynamic> key =
  {
    "name": "userData",
    "id": id
  };

  var response = await client.getDocument(key);

  response = response.replaceAll("[","");
  response = response.replaceAll("]","");
  print(response);
  return response;
}

//Pass in a string formatted as a JSON doc and have it added to tempUserData with it's ID as the key
void addTempData(String doc){
  Map data = json.decode(doc);
  tempUserData[data["_id"]] = data;
}

//Inserts all user data on the data entry page to the database and stores the ID in SharedPreferences
Future<int> storeSleepData(String hourString, String minuteString, String sleepHourString, String sleepMinuteString, String timeCalc, String tempTimeTypeCalc, String tempTimeTypeUser, UnitType uniType, int day, int month, int year, int rating) async {
  final dio = Dio();	// Http client
  final client = RestClient(dio);	// Creating Http client to handle API requests

  String startTime = "";
  String endTime = "";
  String timeSleeping = sleepHourString + " hours and " + sleepMinuteString + " minutes.";

  if(uniType == UnitType.BED){
    startTime = hourString + ":" + minuteString + " " + tempTimeTypeUser;
    endTime = timeCalc + " " + tempTimeTypeCalc;
  }

  if(uniType == UnitType.WAKE){
    endTime = hourString + ":" + minuteString + " " + tempTimeTypeUser;
    startTime = timeCalc + " " + tempTimeTypeCalc;
  }

  var timeDouble = 0.0;

  try {
    timeDouble = double.parse(sleepHourString);
  } catch (e){

  }

  try {
    timeDouble += (double.parse(sleepMinuteString))/60;
  } catch (e){

  }

  String tempMonth = month.toString();
  String tempDay = day.toString();

  if (tempMonth.length == 1) tempMonth = '0' + tempMonth;
  if (tempDay.length == 1) tempDay = '0' + tempDay;

  String tempDate = year.toString() + tempMonth + tempDay;
  var date = 0;

  try {
    date = int.parse(tempDate);
  } catch (e){

  }

  Map<String, dynamic> timeData =
  {
    "name": "userData",
    "_id": "null",
    "date" : date,
    "day": day,
    "month": month,
    "year": year,
    "start": startTime,
    "end" : endTime,
    "time" : timeSleeping,
    "timedouble" : timeDouble,
    "rating": rating
  };

  removeDuplicateDate(timeData);

  //print(timeData); //prints original string

  var response = await client.insertData(timeData);

  addTempData(response);
  Map temp = json.decode(response);
  userIDs.add(temp["_id"]);
  setList(userIDs);

  print(response); //prints what's returned
  //print(tempUserData);

  return 1;
}

//Removes any data with a matching date to the data you pass (should only be used in storeSleepData)
void removeDuplicateDate(Map<String, dynamic> data){
  var temp;
  List<String> keys = tempUserData.keys.toList();

  for(int i = 0; i<keys.length; i++) {
    temp = tempUserData[keys.elementAt(i)];

    if (temp["date"] == data["date"]){
      tempUserData.remove(keys.elementAt(i));

      for(int j = 0; j<userIDs.length; j++){
        if(userIDs.elementAt(j) == keys.elementAt(i)){
          userIDs.removeAt(j);
        }
      }
      //print(userIDs);
      //print(tempUserData);
      setList(userIDs);
    }
  }
}