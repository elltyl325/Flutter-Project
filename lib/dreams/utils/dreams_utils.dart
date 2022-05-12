import 'package:flutter/material.dart';
import 'package:units/dreams/utils/dreams_constant.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import "package:units/api.dart";

List<dynamic> calculator(double hour, double minute, double sleepHour, double sleepMinute, UnitType uniType, UnitType unitTypeTime) {

  List result = new List.filled(3, null, growable: false);
  double tempHour = 0.0;
  double tempMinute = 0.00;

  if(uniType == UnitType.BED) {
    tempHour = hour + sleepHour;
    tempMinute = minute + sleepMinute;

    if (tempMinute >= 60) {
      tempMinute -= 60;
      tempHour += 1;
    }
  }
  if (uniType == UnitType.WAKE) {
    tempHour = hour - sleepHour;
    tempMinute = minute - sleepMinute;

    if(tempMinute < 0){
      tempMinute += 60.00;
      tempHour -= 1;
    }
  }

  if(tempHour > 12 || tempHour < 0) {
    switch(unitTypeTime) {
      case UnitType.AM: { unitTypeTime = UnitType.PM; }
      break;
      case UnitType.PM: { unitTypeTime = UnitType.AM; }
      break;
      default: {}
      break;
    }

    tempHour %= 12;
  }
  if(tempHour ==0){
    tempHour = 12;
  }



  //result = tempHour + (tempMinute/100);
  result[0] = (tempHour + (tempMinute/100));
  result[1] = unitTypeTime;
  result[2] = uniType;

  return result;
}

bool isEmptyString(String string){
  return string == null || string.length == 0;
}

Future<int> loadValue() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  int? data = preferences.getInt('data');
  if( data != null ) {
    return data;
  } else {
    return 0;
  }

}

void saveValue(int value) async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setInt('data', value);
}

void setThemeKey(int color) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('theme', color);
}

Future<int?> getThemeKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final color = prefs.getInt('theme');
  return color;
}

void setTheme(int theme){
  switch(theme) {
    case 1: {  defaultTheme(); }
    break;

    case 2: {  monochromeTheme(); }
    break;

    case 3: {  pinkTheme(); }
    break;

    case 4: {  sherbetTheme(); }
    break;

    case 5: {  thunderTheme(); }
    break;

    case 6: {  redTheme(); }
    break;

    case 7: {  transTheme(); }
    break;

    case 8: { enbyTheme(); }
    break;

    default: { defaultTheme(); }
    break;
  }
}

Color mains = Colors.white60;
Color accent = Colors.cyan;
Color widgets = Colors.blueGrey.shade700;
Color gradient1 = Colors.cyan.shade900;
Color gradient2 = Colors.cyan.shade700;
Color gradient3 = Colors.cyan.shade500;
Color appHeader = Colors.blueGrey.shade900;
Color appBackground = Colors.blueGrey.shade800;

Future<int> defaultTheme() async {
  mains = Colors.white60;
  accent = Colors.cyan;
  widgets = Colors.blueGrey.shade700;
  gradient1 = Colors.cyan.shade900;
  gradient2 = Colors.cyan.shade700;
  gradient3 = Colors.cyan.shade500;
  appHeader = Colors.blueGrey.shade900;
  appBackground = Colors.blueGrey.shade800;
  return 1;
}
Future<int> monochromeTheme() async {
  mains = Colors.black;
  accent = Colors.grey.shade700;
  widgets = Colors.grey;
  gradient1 = Colors.grey.shade700;
  gradient2 = Colors.grey.shade500;
  gradient3 = Colors.grey.shade300;
  appHeader = Colors.grey.shade900;
  appBackground = Colors.grey.shade800;
  return 1;
}
Future<int> pinkTheme() async {
  mains = Colors.pink.shade500;
  accent = Colors.pink;
  widgets = Colors.pink.shade200;
  gradient1 = Colors.pinkAccent.shade700;
  gradient2 = Colors.pinkAccent.shade400;
  gradient3 = Colors.pinkAccent;
  appHeader = Colors.pink.shade900;
  appBackground = Colors.pink.shade800;
  return 1;
}
Future<int> sherbetTheme() async {
  mains = Colors.deepOrange;
  accent = Colors.green.shade300;
  widgets = Colors.yellow.shade100;
  gradient1 = Colors.purpleAccent.shade400;
  gradient2 = Colors.orangeAccent.shade100;
  gradient3 = Colors.cyanAccent;
  appHeader = Colors.pink.shade300;
  appBackground = Colors.pink.shade100;
  return 1;
}
Future<int> thunderTheme() async {
  mains = Colors.yellow;
  accent = Colors.yellowAccent;
  widgets = Colors.grey.shade700;
  gradient1 = Colors.cyan.shade500;
  gradient2 = Colors.yellow.shade700;
  gradient3 = Colors.yellow.shade200;
  appHeader = Colors.grey.shade900;
  appBackground = Colors.grey.shade800;
  return 1;
}
Future<int> redTheme() async {
  mains = Colors.red.shade900;
  accent = Colors.red.shade900;
  widgets = Colors.white70;
  gradient1 = Colors.red.shade900;
  gradient2 = Colors.red.shade700;
  gradient3 = Colors.red.shade500;
  appHeader = Colors.grey.shade500;
  appBackground = Colors.grey.shade200;
  return 1;
}
Future<int> transTheme() async {
  mains = Colors.blue;
  accent = Colors.pink;
  widgets = Colors.white70;
  gradient1 = Colors.lightBlue.shade200;
  gradient2 = Colors.pinkAccent.shade100;
  gradient3 = Colors.white;
  appHeader = Colors.blue.shade800;
  appBackground = Colors.pinkAccent.shade100;
  return 1;
}
Future<int> enbyTheme() async {
  mains = Colors.black;
  accent = Colors.yellow.shade700;
  widgets = Colors.white;
  gradient1 = Colors.black;
  gradient2 = Colors.yellow;
  gradient3 = Colors.white;
  appHeader = Colors.purple;
  appBackground = Colors.purple.shade200;
  return 1;
}

Color colorStyle(String color){
  switch(color){
    case "main":
      return mains;
    case "accent":
      return accent;
    case "widgets":
      return widgets;
    case "gradient1":
      return gradient1;
    case "gradient2":
      return gradient2;
    case "gradient3":
      return gradient3;
    case "appHeader":
      return appHeader;
    case "appBackground":
      return appBackground;
    default:
      return Colors.purpleAccent;
  }
}