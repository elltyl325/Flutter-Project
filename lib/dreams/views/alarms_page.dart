import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/dreams_utils.dart';

class AlarmsPage extends StatefulWidget {

  @override
  _AlarmsPageState createState() => _AlarmsPageState();
}

class _AlarmsPageState extends State<AlarmsPage> {
  bool isOn = false;
  int alarmId = 1;
  var _hourRemindController = TextEditingController(text: '0');
  var _minRemindController = TextEditingController(text: '0');
  var _hourAlarmController = TextEditingController(text: '0');
  var _minAlarmController = TextEditingController(text: '0');
  int _hourRemind = 0;
  int _minRemind = 0;
  int _hourAlarm = 0;
  int _minAlarm = 0;
  var _valueRemind = 0;
  var _valueAlarm = 0;
  final FocusNode _hourRemindFocus = FocusNode();
  final FocusNode _minRemindFocus = FocusNode();
  final FocusNode _hourAlarmFocus = FocusNode();
  final FocusNode _minAlarmFocus = FocusNode();

  @override
  void initState(){
    super.initState();
    AndroidAlarmManager.initialize();
  }


  @override
  Widget build(BuildContext context) {

    var _reminderUnitView = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio<int>(
            activeColor: colorStyle("accent"),
            value: 0,
            groupValue: _valueRemind,
            onChanged: (value){
              setState((){
                _valueRemind = value as int;
              });
            },
          ),
          Text(
            'Off',
            style: TextStyle(color: colorStyle("accent")),
          ),
          Radio<int>(
            activeColor: colorStyle("accent"),
            value: 1, groupValue: _valueRemind, onChanged: (value){
            setState((){
              _valueRemind = value as int;
            });
          },
          ),
          Text(
            'Notification',
            style: TextStyle(color: colorStyle("accent")),
          ),
          Radio<int>(
            activeColor: colorStyle("accent"),
            value: 2, groupValue: _valueRemind, onChanged: (value){
            setState((){
              _valueRemind = value as int;
            });
          },
          ),
          Text(
            'Alarm',
            style: TextStyle(color: colorStyle("accent")),
          ),
        ]
    );
    var _alarmUnitView = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio<int>(
            activeColor: colorStyle("accent"),
            value: 0,
            groupValue: _valueAlarm,
            onChanged: (value){
              setState((){
                _valueAlarm = value as int;
              });
            },
          ),
          Text(
            'Off',
            style: TextStyle(color: colorStyle("accent")),
          ),
          Radio<int>(
            activeColor: colorStyle("accent"),
            value: 1,
            groupValue: _valueAlarm,
            onChanged: (value){
              setState((){
                _valueAlarm = value as int;
              });
            },
          ),
          Text(
            'On',
            style: TextStyle(color: colorStyle("accent")),
          ),
        ]
    );

    var _reminderPartView = Container(
      decoration: BoxDecoration(
        color: colorStyle("widgets"),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Form(
          //key:_formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Reminder",
                  style: TextStyle(color: colorStyle("main")),
                  textScaleFactor: 1.5,)
                ,),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: _reminderUnitView,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: hourRemindFormField(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                  Expanded(
                    child: minRemindFormField(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    var _alarmPartView = Container(
      decoration: BoxDecoration(
        color: colorStyle("widgets"),
        borderRadius: BorderRadius.only (
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
            topLeft: Radius.circular(25.0),
            bottomLeft: Radius.circular(25.0)),
      ),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Form(
          //key:_formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Alarm",
                  style: TextStyle(color: colorStyle("main")),
                  textScaleFactor: 1.5,)
                ,),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: _alarmUnitView,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: hourAlarmFormField(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                  Expanded(
                    child: minAlarmFormField(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    var now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: GradientText('Alarms',
            style: TextStyle(fontSize: 30.0,),
            colors: [colorStyle("gradient1"), colorStyle("gradient2"),
              colorStyle("gradient3"), colorStyle("gradient2"),
              colorStyle("gradient1")]
        ),
        centerTitle: true,
        backgroundColor: colorStyle("appHeader"),
      ),
      backgroundColor: colorStyle("appBackground"),
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0)),
          _reminderPartView,
          Padding(padding: EdgeInsets.all(10.0)),
          _alarmPartView,
          Padding(padding: EdgeInsets.all(50.0)),
          stopButton(),
          Padding(padding: EdgeInsets.all(10.0)),
          startButton(),
        ],
      ),
      ),
    );
  }

  TextFormField hourRemindFormField(BuildContext context) {
    return TextFormField(
      controller: _hourRemindController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: colorStyle("main")),
      focusNode: _hourRemindFocus,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _hourRemindFocus, _minRemindFocus);
      },
      validator: (value){
        if( value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 12)){
          return ('1-12');
        }
      },
      onChanged: (value) {
        _hourRemind = value as int;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 10',
        labelText: 'Hour',
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        //icon: Icon(Icons.assessment),
        fillColor: colorStyle("main"),
      ),
    );
  }

  TextFormField minRemindFormField(BuildContext context) {
    return TextFormField(
      controller: _minRemindController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: colorStyle("main")),
      focusNode: _minRemindFocus,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _minRemindFocus, _hourAlarmFocus);
      },
      validator: (value){
        if( value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)){
          return ('0-59');
        }
      },
      onChanged: (value) {
        _minRemind = value as int;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 55',
        labelText: 'Minute',
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        //icon: Icon(Icons.assessment),
        fillColor: colorStyle("main"),
      ),
    );
  }

  TextFormField hourAlarmFormField(BuildContext context) {
    return TextFormField(
      controller: _hourAlarmController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _hourAlarmFocus,
      style: TextStyle(color: colorStyle("main")),
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _hourAlarmFocus, _minAlarmFocus);
      },
      validator: (value){
        if( value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)){
          return ('1-12');
        }
      },
      onChanged: (value) {
        _hourAlarm = value as int;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 10',
        labelText: 'Hour',
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        //icon: Icon(Icons.assessment),
        fillColor: colorStyle("main"),
      ),
    );
  }

  TextFormField minAlarmFormField(BuildContext context) {
    return TextFormField(
      controller: _minAlarmController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: colorStyle("main")),
      focusNode: _minAlarmFocus,

      validator: (value){
        if( value!.length == 0 || (double.parse(value) < 0 || double.parse(value) > 59)){
          return ('0-59');
        }
      },
      onChanged: (value) {
        _minAlarm = value as int;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 55',
        labelText: 'Minute',
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        //icon: Icon(Icons.assessment),
        fillColor: colorStyle("main"),
      ),
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: colorStyle("appHeader"),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );


  ElevatedButton startButton(){
    return ElevatedButton(

      style: ElevatedButton.styleFrom(
        primary: colorStyle("appHeader"), // background
        onPrimary: colorStyle("accent"),
        //fixedSize: Size(10.0, 50.0),
        // foreground
      ),
      child: Text(
        'Start',
        style: TextStyle(fontSize: 17.0)),
      onPressed: () async {
        if(_valueRemind == 1){
          print("Reminder start at ${DateTime.now()}");
          await AndroidAlarmManager.oneShot(
            Duration(hours:  int.parse(_hourRemindController.text), minutes: int.parse(_minRemindController.text)),
              alarmId,
              fireNotification,
              exact: true,
              wakeup: true
          );
        }
        else if(_valueRemind == 2){
          print("Alarm start at ${DateTime.now()}");
          await AndroidAlarmManager.oneShot(
              Duration(hours:  int.parse(_hourRemindController.text), minutes: int.parse(_minRemindController.text)),
              alarmId,
              fireAlarm,
              exact: true,
              wakeup: true
          );
        }
        if(_valueAlarm == 1){
        print("alarm start at ${DateTime.now()}");
        print("correct minAlarm value is $_minAlarmController.text");
        await AndroidAlarmManager.oneShot(
          Duration(hours: int.parse(_hourAlarmController.text), minutes: int.parse(_minAlarmController.text)),
          alarmId,
          fireAlarm,
          exact: true,
          wakeup: true
        );
        }
      },
      );

  }

  ElevatedButton stopButton(){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: colorStyle("appHeader"), // background
        onPrimary: colorStyle("accent"),
        //fixedSize: Size(10.0, 50.0),
        // foreground
      ),
      onPressed: () async {
        await AndroidAlarmManager.oneShot(const Duration(seconds: 0), 4, stopSound,
            exact: true, wakeup: true, alarmClock: true, allowWhileIdle: true);
      },
      child:const Text(
        'Stop',
        style: TextStyle(fontSize: 17.0),
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }



}

void stopSound(){
  print('Alarm Stopped at ${DateTime.now()}');
  FlutterRingtonePlayer.stop();
}
void fireAlarm(){
  print('Alarm Fired at ${DateTime.now()}');
  FlutterRingtonePlayer.playAlarm();
}

void fireNotification(){
  print('Alarm Fired at ${DateTime.now()}');
  FlutterRingtonePlayer.playNotification();
}
