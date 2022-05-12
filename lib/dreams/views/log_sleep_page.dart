import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../views/dreams_view.dart';
import '../presenter/dreams_presenter.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/dreams_utils.dart';

class LogSleepPage extends StatefulWidget {
  final UNITSPresenter presenter;

  final Function callback;

  LogSleepPage(this.callback, this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LogSleepPageState createState() => _LogSleepPageState();
}

class _LogSleepPageState extends State<LogSleepPage> implements UNITSView {


  var _sleepHourController = TextEditingController();
  var _sleepMinuteController = TextEditingController(text: '0');
  var _hourController = TextEditingController();
  var _minuteController = TextEditingController(text: '0');
  var _dayController = TextEditingController();
  var _monthController = TextEditingController();
  var _yearController = TextEditingController();
  var _sleepRatingController = TextEditingController();
  String _hour = "0.0";
  String _minute = "0.0";
  String _sleepMinute = "0.0";
  String _sleepHour = "0.0";
  String _day = '1';
  String _month = '1';
  String _year = '2021';
  String _sleepRating = '0';
  var _resultString = '';
  var _timeString = '';
  var _message = '';
  var _value = 0;
  var _valueTime = 0;
  final FocusNode _hourFocus = FocusNode();
  final FocusNode _sleepHourFocus = FocusNode();
  final FocusNode _sleepMinuteFocus = FocusNode();
  final FocusNode _minuteFocus = FocusNode();
  final FocusNode _dayFocus = FocusNode();
  final FocusNode _monthFocus = FocusNode();
  final FocusNode _yearFocus = FocusNode();
  final FocusNode _sleepRatingFocus = FocusNode();

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this.widget.presenter.unitsView = this;
  }

  // int getDay(){
  //   return _day as int;
  // }
  //
  // int getMonth(){
  //   return _month as int;
  // }
  //
  // int getYear(){
  //   return _year as int;
  // }

  int getSleepRating(){
    return _sleepRating as int;
  }

  void handleRadioValueChanged(int? value) {
    this.widget.presenter.onOptionChanged(
        value!, sleepHourString: _sleepHour, sleepMinuteString: _sleepMinute);
  }

  void handleRadioValueChangedTime(int? value) {
    this.widget.presenter.onTimeOptionChanged(value!);
  }

  Future<int> _calculator() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await this.widget.presenter.onCalculateClicked(
          _hour, _minute, _sleepMinute, _sleepHour, _day, _month, _year, _sleepRating);
    }
    return 1;
  }

  @override
  void updateResultValue(String resultValue) {
    setState(() {
      _resultString = resultValue;
    });
  }

  @override
  void updateTimeString(String timeString) {
    setState(() {
      _timeString = timeString;
    });
  }

  @override
  void updateMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  @override
  void updateSleepMinute({required String sleepMinute}) {
    setState(() {
      // ignore: unnecessary_null_comparison
      _sleepMinuteController.text = sleepMinute != null ? sleepMinute : '';
    });
  }

  @override
  void updateSleepHour({required String sleepHour}) {
    setState(() {
      // ignore: unnecessary_null_comparison
      _sleepHourController.text = sleepHour != null ? sleepHour : '';
    });
  }

  @override
  void updateHour({required String hour}) {
    setState(() {
      _hourController.text = hour != null ? hour : '';
    });
  }

  @override
  void updateMinute({required String minute}) {
    setState(() {
      _minuteController.text = minute != null ? minute : '';
    });
  }

  @override
  void updateDay({required String day}) {
    setState(() {
      _dayController.text = day != null ? day : '';
    });
  }

  @override
  void updateMonth({required String month}) {
    setState(() {
      _monthController.text = month != null ? month : '';
    });
  }

  @override
  void updateYear({required String year}) {
    setState(() {
      _yearController.text = year != null ? year : '';
    });
  }

  @override
  void updateSleepRating({required String sleepRating}) {
    setState(() {
      _sleepRatingController.text = sleepRating != null ? sleepRating : '';
    });
  }

  @override
  void updateUnit(int value) {
    setState(() {
      _value = value;
    });
  }

  @override
  void updateTimeUnit(int value) {
    setState(() {
      _valueTime = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currDate = DateTime.now();
    _dayController.text = DateFormat('d').format(currDate);
    _monthController.text = DateFormat('M').format(currDate);
    _yearController.text = DateFormat('y').format(currDate);
    var _unitView = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: colorStyle("accent"),
          value: 0, groupValue: _value, onChanged: handleRadioValueChanged,
        ),
        Text(
          'Wake up at',
          style: TextStyle(color: colorStyle("accent")),
        ),
        Radio<int>(
          activeColor: colorStyle("accent"),
          value: 1, groupValue: _value, onChanged: handleRadioValueChanged,
        ),
        Text(
          'Go to bed at',
          style: TextStyle(color: colorStyle("accent")),
        ),
      ],
    );


    var _unitViewTime = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Radio<int>(
          activeColor: colorStyle("accent"),
          value: 0,
          groupValue: _valueTime,
          onChanged: handleRadioValueChangedTime,
        ),
        Text(
          'AM',
          style: TextStyle(color: colorStyle("accent")),
        ),
        Radio<int>(
          activeColor: colorStyle("accent"),
          value: 1,
          groupValue: _valueTime,
          onChanged: handleRadioValueChangedTime,
        ),
        Text(
          'PM',
          style: TextStyle(color: colorStyle("accent")),
        ),
      ],
    );


    var _mainPartView = Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: colorStyle("widgets"),
        borderRadius: BorderRadius.all (
          Radius.circular(20)
        ),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Enter the date",
                  style: TextStyle(
                    color: colorStyle("main"),
                    fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5,)
                ,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: dayFormField(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                  Expanded(
                    child: monthFormField(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8),
                  ),
                  Expanded(
                    child: yearFormField(context),
                  ),
                ]
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("I want to:",
                  style: TextStyle(
                    color: colorStyle("main"),
                    fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5,)
                ,),
              _unitView,
              Row(
                children: <Widget>[
                  Expanded(
                    child: hourFormField(context),
                  ),
                  Expanded(
                    child: minFormField(context),
                  )
                ],
              ),
              _unitViewTime,
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("I want to sleep for:",
                  style: TextStyle(
                    color: colorStyle("main"),
                    fontWeight: FontWeight.bold),
                  textScaleFactor: 1.5,)
                ,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: sleepHourFormField(context),
                  ),
                  Expanded(
                    child: sleepMinuteFormField(),
                  ),
                ],
              ),
              //hoursSleep(context),
              rateSleep(context),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: calculateButton()
                ,),
            ],
          ),
        ),
      ),
    );

    var _resultView = Column(
      children: <Widget>[
        Center(
          child: Text(
            '$_message $_resultString $_timeString',
            style: TextStyle(
                color: Colors.blueAccent.shade700,
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic
            ),
          ),
        ),
      ],
    );


    return Scaffold(
      appBar: AppBar(
        title: GradientText('Sleep Calculator',
            style: TextStyle(fontSize: 30.0,),
            colors: [colorStyle("gradient1"), colorStyle("gradient2"),
                     colorStyle("gradient3"), colorStyle("gradient2"),
                     colorStyle("gradient1")]
        ),
        centerTitle: true,
        backgroundColor: colorStyle("appHeader"),
      ),
      backgroundColor: colorStyle("appBackground"),
      body: ListView(
        children: <Widget>[
          // Padding(padding: EdgeInsets.all(5.0)),
          // _dateView,
          Padding(padding: EdgeInsets.all(5.0)),
          _mainPartView,
          Padding(padding: EdgeInsets.all(5.0)),
          _resultView,
        ],
      ),
    );
  }


  RaisedButton calculateButton() {
    return RaisedButton(
      onPressed: () async {
        await _calculator();
        this.widget.callback();
      },
      color: colorStyle("appHeader"),
      child: Text(
        'Save',
        style: TextStyle(fontSize: 16.9),
      ),
      textColor: colorStyle("accent"),
    );
  }

  TextFormField sleepMinuteFormField() {
    return TextFormField(
      controller: _sleepMinuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      style: TextStyle(
          color: colorStyle("main"),
      ),
      focusNode: _sleepMinuteFocus,
      onFieldSubmitted: (value) {
        _sleepMinuteFocus.unfocus();
      },
      validator: (value) {
        if (value!.length == 0 ||
            (double.parse(value) < 0 || double.parse(value) > 59)) {
          return ('Minute between 0 - 59');
        }
      },
      onSaved: (value) {
        _sleepMinute = value!;
      },
      decoration: InputDecoration(
          hintText: 'e.g.) 40',
          labelText: 'Minute',
          hintStyle: TextStyle(color: colorStyle("main")),
          labelStyle: TextStyle(color: colorStyle("main")),
          icon: Icon(Icons.assessment),
          fillColor: colorStyle("main")
      ),
    );
  }

  TextFormField sleepHourFormField(BuildContext context) {
    return TextFormField(
      controller: _sleepHourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: colorStyle("main")),
      focusNode: _sleepHourFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _sleepHourFocus, _sleepMinuteFocus);
      },
      validator: (value) {
        if (value!.length == 0 ||
            (double.parse(value) < 1 || double.parse(value) > 12)) {
          return ('Hour between 1 - 12');
        }
      },
      onSaved: (value) {
        _sleepHour = value!;
      },
      decoration: InputDecoration(
        hintText: "e.g.) 7",
        labelText: "Hour",
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        icon: Icon(Icons.assessment),
        fillColor: colorStyle("main"),
      ),
    );
  }

  TextFormField dayFormField(BuildContext context) {
    return TextFormField(
      controller: _dayController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _dayFocus,
      style: TextStyle(color: colorStyle("main")),
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _dayFocus, _monthFocus);
      },
      validator: (value){
        if( value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 31)){
          return ('1-31');
        }
      },
      onSaved: (value) {
        _day = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 23',
        labelText: 'Day',
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        //icon: Icon(Icons.assessment),
        fillColor: colorStyle("main"),
      ),
    );
  }

  TextFormField monthFormField(BuildContext context) {
    return TextFormField(
      controller: _monthController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: colorStyle("main")),
      focusNode: _monthFocus,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _monthFocus, _yearFocus);
      },
      validator: (value){
        if( value!.length == 0 || (double.parse(value) < 1 || double.parse(value) > 12)){
          return ('1-12');
        }
      },
      onSaved: (value) {
        _month = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 3',
        labelText: 'Month',
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        //icon: Icon(Icons.assessment),
        fillColor: colorStyle("main"),
      ),
    );
  }

  TextFormField yearFormField(BuildContext context) {
    return TextFormField(
      controller: _yearController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _yearFocus,
      style: TextStyle(color: colorStyle("main")),
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _yearFocus, _hourFocus);
      },
      validator: (value){
        if( value!.length == 0 || double.parse(value) < 2020){
          return ('Greater than 2020');
        }
      },
      onSaved: (value) {
        _year = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 2021',
        labelText: 'Year',
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        //icon: Icon(Icons.assessment),
        fillColor: colorStyle("main"),
      ),
    );
  }

  TextFormField hourFormField(BuildContext context) {
    return TextFormField(
      controller: _hourController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _hourFocus,
      style: TextStyle(color: colorStyle("main")),
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _hourFocus, _minuteFocus);
      },
      validator: (value) {
        if (value!.length == 0 ||
            (double.parse(value) < 1 || double.parse(value) > 12)) {
          return ('Hour between 1 - 12');
        }
      },
      onSaved: (value) {
        _hour = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 6',
        labelText: 'Hour',
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        icon: Icon(Icons.assessment),
        fillColor: colorStyle("main"),
      ),
    );
  }

  TextFormField minFormField(BuildContext context) {
    return TextFormField(
      controller: _minuteController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      focusNode: _minuteFocus,
      style: TextStyle(color: colorStyle("main")),
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _minuteFocus, _sleepHourFocus);
      },
      validator: (value) {
        if (value!.length == 0 ||
            (double.parse(value) < 0 || double.parse(value) > 59)) {
          return ('Minute between 0 - 59');
        }
      },
      onSaved: (value) {
        _minute = value!;
      },
      decoration: InputDecoration(
        hintText: 'e.g.) 30',
        labelText: 'Minute',
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        icon: Icon(Icons.assessment),
        fillColor: colorStyle("main"),
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }


  //Additional Widgets being added

  TextFormField rateSleep(BuildContext context) {
    return TextFormField (
      controller: _sleepRatingController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: colorStyle("main")),
      focusNode: _sleepRatingFocus,
      // onFieldSubmitted: (term) {
      //   _fieldFocusChange(context, _sleepRatingFocus, null);
      // },
      validator: (value) {
        if (value!.length == 0 ||
            (double.parse(value) < 0 || double.parse(value) > 5)) {
          return ('Rating between 0 - 5');
        }
      },
      onSaved: (value) {
        _sleepRating = value!;
      },
      decoration: InputDecoration(
        icon: Icon(Icons.person),
        hintStyle: TextStyle(color: colorStyle("main")),
        labelStyle: TextStyle(color: colorStyle("main")),
        hintText: 'Between 0-5',
        labelText: "Rate your sleep:",
      ),
    );
  }

  // TextFormField hoursSleep(BuildContext context) {
  //   return TextFormField (
  //     decoration:
  //     const InputDecoration(
  //       icon: Icon(Icons.person),
  //       hintText: 'If neither leave empty',
  //       labelText: 'Comment on any dream/nightmares:',
  //     ),
  //     //  onSaved:
  //     //   (int? value) {
  //     // This optional block of code can be used to run
  //     // code when the user saves the form.
  //     // };
  //     validator:
  //         (value) {
  //       if (value!.length == 0 ||
  //           (double.parse(value) < 0 || double.parse(value) > 24)) {
  //         return ('Minute between 0 - 24');
  //       }
  //     },
  //   );
  // }

}
