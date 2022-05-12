import '../views/dreams_view.dart';
import '../viewmodel/dreams_viewmodel.dart';
import '../utils/dreams_constant.dart';
import '../utils/dreams_utils.dart';
import '../utils/dreams_data_management.dart';

class UNITSPresenter {
  Future<int> onCalculateClicked(String hourString, String minuteString, String sleepMinuteString, String sleepHourString, String day, String month, String year, String r) async{
    return 1;
  }
  void onOptionChanged(int value, {required String sleepMinuteString, required String sleepHourString}) {

  }
  void onTimeOptionChanged(int value) {

  }
  set unitsView(UNITSView value){}

  void onHourSubmitted(String hour){}
  void onMinuteSubmitted(String minute){}
  void onSleepHourSubmitted(String sleepHour){}
  void onSleepMinuteSubmitted(String sleepMinute){}
}

class BasicPresenter implements UNITSPresenter{
  UNITSViewModel _viewModel = UNITSViewModel();
  UNITSView _view = UNITSView();

  BasicPresenter() {
    this._viewModel = _viewModel;
    _loadUnit();
  }

  void _loadUnit() async{
    _viewModel.value = await loadValue();
    _viewModel.valueTime = await loadValue();
    _view.updateUnit(_viewModel.value);
    _view.updateTimeUnit(_viewModel.valueTime);
  }

  @override
  set unitsView(UNITSView value) {
    _view = value;
    _view.updateUnit(_viewModel.value);
    _view.updateTimeUnit(_viewModel.valueTime);
  }

  @override
  Future<int> onCalculateClicked(String hourString, String minuteString, String sleepMinuteString, String sleepHourString, String day, String month, String year, String r) async {
    var hour = 0.0;
    var minute = 0.0;
    var sleepHour = 0.0;
    var sleepMinute = 0.0;
    var D = 0;
    var M = 0;
    var Y = 0;
    var rating = 0;

    try {
      hour = double.parse(hourString);
    } catch (e){

    }
    try {
      minute = double.parse(minuteString);
    } catch (e){

    }
    try {
      sleepHour = double.parse(sleepHourString);
    } catch (e){

    }
    try {
      sleepMinute = double.parse(sleepMinuteString);
    } catch (e) {

    }

    try {
      D = int.parse(day);
    } catch (e) {

    }
    try {
      M = int.parse(month);
    } catch (e) {

    }
    try {
      Y = int.parse(year);
    } catch (e) {

    }
    try {
      rating = int.parse(r);
    } catch (e) {

    }

    List temp = new List.filled(3, null, growable: false);
    _viewModel.hour = hour;
    _viewModel.minute = minute;
    _viewModel.sleepHour = sleepHour;
    _viewModel.sleepMinute = sleepMinute;
    temp = calculator(hour,minute,sleepHour, sleepMinute, _viewModel.unitType, _viewModel.unitTypeTime);
    //  temp returns a List of the time, AM or PM, and WAKE or BED.
    //  The time that is returned is in the format of a double ex) 12.30 is 12:30.

    _viewModel.units = temp[0];
    UnitType tempTime = temp[1];
    UnitType tempMessage = temp[2];

    // creating all the strings to be stored in the mongo database
    String tempTimeTypeUser = "";
    String tempTimeTypeCalc = "";
    String timeCalc = _viewModel.units.toStringAsFixed(2);
    timeCalc = timeCalc.replaceFirst('.', ':');

    // making sure the entered strings are in the same format every time
    int tempHour = hour.toInt();
    int tempMinute = minute.toInt();
    int tempSleepHour = sleepHour.toInt();
    int tempSleepMinute = sleepMinute.toInt();
    String hourFormatted = tempHour.toString();
    String minuteFormatted = tempMinute.toString();
    String sleepHourFormatted = tempSleepHour.toString();
    String sleepMinuteFormatted = tempSleepMinute.toString();

    for (int i = 0; i <= 9; i++){
      if (minute == i){
        minuteFormatted = '0' + minuteFormatted;
      }
    }

    if(tempTime == UnitType.AM) {
      _viewModel.timeType = "AM";
      tempTimeTypeCalc = "AM";
    } else if (tempTime == UnitType.PM) {
      _viewModel.timeType = "PM";
      tempTimeTypeCalc = "PM";
    }

    if(_viewModel.unitTypeTime == UnitType.AM) {
      tempTimeTypeUser = "AM";
    } else if (_viewModel.unitTypeTime == UnitType.PM) {
      tempTimeTypeUser = "PM";
    }

    //Calling the function that stores the time data in the mongo database on click
    await storeSleepData(hourFormatted, minuteFormatted, sleepHourFormatted, sleepMinuteFormatted, timeCalc, tempTimeTypeCalc, tempTimeTypeUser, _viewModel.unitType, D, M, Y, rating);

    if(tempMessage == UnitType.BED) {
      _viewModel.message = "You should wake up at";
    } else if (tempMessage == UnitType.WAKE) {
      _viewModel.message = "You should go to bed at";
    }
    _view.updateMessage(_viewModel.message);
    _view.updateTimeString(_viewModel.timeType);
    _view.updateResultValue(_viewModel.resultInString);

    return 1;
  }

  @override
  void onOptionChanged(int value, {required String sleepMinuteString, required String sleepHourString})  {

    if (value != _viewModel.value) {
      _viewModel.value = value;
      saveValue(_viewModel.value);
      var curOdom = 0.0;
      var fuelUsed = 0.0;
      if (!isEmptyString(sleepHourString)) {
        try {
          curOdom = double.parse(sleepHourString);
        } catch (e) {
        }
      }
      if (!isEmptyString(sleepMinuteString)) {
        try {
          fuelUsed = double.parse(sleepMinuteString);
        } catch (e) {

        }
      }
      _view.updateUnit(_viewModel.value);
      _view.updateSleepHour(sleepHour: _viewModel.sleepHourInString);
      _view.updateSleepMinute(sleepMinute: _viewModel.sleepMinuteInString);
    }
  }

  @override
  void onTimeOptionChanged(int value)  {

    if (value != _viewModel.valueTime) {
      _viewModel.valueTime = value;
      saveValue(_viewModel.valueTime);

      _view.updateTimeUnit(_viewModel.valueTime);
    }
  }

  @override
  void onHourSubmitted(String hour) {
    try{
      _viewModel.hour = double.parse(hour);
    }catch(e){

    }
  }

  @override
  void onMinuteSubmitted(String minute) {
    try{
      _viewModel.minute = double.parse(minute);
    }catch(e){

    }
  }

  @override
  void onSleepHourSubmitted(String sleepHour) {
    try {
      _viewModel.sleepHour = double.parse(sleepHour);
    } catch (e){

    }
  }

  @override
  void onSleepMinuteSubmitted(String sleepMinute) {
    try {
      _viewModel.sleepMinute = double.parse(sleepMinute);
    } catch (e){

    }
  }
}