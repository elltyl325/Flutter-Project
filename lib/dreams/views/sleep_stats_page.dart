import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../utils/dreams_data_management.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/dreams_utils.dart';

class StatsPage extends StatefulWidget{

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {

  List<SleepData> getSleepData(){
    var tempList = getListDataSorted();
    var tempData = new List.from(tempList.reversed);
    List<SleepData> sleepStats = [];

    for(var i=0; i<tempData.length; i++){
      String temp = tempData[i]["M"].toString() + '/' + tempData[i]["D"].toString() + '/' + tempData[i]["Y"].toString();
      sleepStats.add(SleepData(temp, tempData[i]["timedouble"]+0.0));
    }

    return sleepStats;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText('Hours Slept Per Night',
            style: TextStyle(fontSize: 30.0,),
            colors: [colorStyle("gradient1"), colorStyle("gradient2"),
                     colorStyle("gradient3"), colorStyle("gradient2"),
                     colorStyle("gradient1")]
        ),
        centerTitle: true,
        backgroundColor: colorStyle("appHeader"),
      ),
      backgroundColor: colorStyle("appBackground"),
        body: Center(
            child: Container(
                child: SfCartesianChart(
                    legend: Legend(isVisible: false),
                    primaryYAxis: CategoryAxis(
                      labelStyle: TextStyle(
                                   color: colorStyle("main"),
                                   fontWeight: FontWeight.bold,
                                  ),
                        minimum: 0,
                        maximum: 13
                    ),
                    primaryXAxis: CategoryAxis(
                        labelStyle: TextStyle(
                                      color: colorStyle("main"),
                                      fontWeight: FontWeight.bold,
                                    ),
                        labelRotation: 45),
                    series: <ChartSeries>[
                      LineSeries<SleepData, String>(
                        color: colorStyle("accent"),
                        dataSource: getSleepData(),
                        xValueMapper: (SleepData sales, _) => sales.day,
                        yValueMapper: (SleepData sales, _) => sales.hour,
                      )
                    ]
                )
            )
        ),
    );
  }
}

class SleepData {
  SleepData(this.day, this.hour);
  final String day;
  final double hour;
}