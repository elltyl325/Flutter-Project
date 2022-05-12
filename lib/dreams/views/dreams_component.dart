import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:units/dreams/utils/dreams_data_management.dart';
import '../presenter/dreams_presenter.dart';
import '../views/alarms_page.dart';
import '../views/log_sleep_page.dart';
import '../views/resources_page.dart';
import '../views/sounds_page.dart';
import '../views/color_selection_page.dart';
import '../views/sleep_stats_page.dart';
import '../utils/dreams_utils.dart';
import '../utils/dreams_data_management.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void update() {
    setState((){
    });
    //print("called back");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText('Home Page',
            style: TextStyle(fontSize: 30.0,),
            colors: [colorStyle("gradient1"), colorStyle("gradient2"),
                     colorStyle("gradient3"), colorStyle("gradient2"),
                     colorStyle("gradient1")]
        ),
        centerTitle: true,
        backgroundColor: colorStyle("appHeader"),
      ),
      backgroundColor: colorStyle("appBackground"),
      body: Align(
        alignment: Alignment.topCenter,
        child: new SingleChildScrollView(
            child: Column(
              children: getListings(),
            )
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TESTING DATA FUNCTIONS
          //getAllUserData(testIDs);
          _navigateToLogSleepPage(context, update);
          //update();
        },
        child: Icon(Icons.add, color: colorStyle("accent")),
        backgroundColor: colorStyle("appHeader"),
      ),
      drawer: Container(
        color: colorStyle("appHeader"),
        width: 250,
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
              new Image.asset("assets/images/blackcloud.png",
                height: 150,
                width: 75,
                fit: BoxFit.cover,
              ),
              ListTile(
                title: Text('Sleep Resources', style: TextStyle(
                  fontSize: 18.0,
                  color: colorStyle("accent")
                ),
                ),
                onTap: () {
                  _navigateToResourcesPage(context);
                },
              ),
              ListTile(
                title: Text('Alarms', style: TextStyle(
                  fontSize: 18.0,
                    color: colorStyle("accent")
                ),
               ),
                onTap: () {
                  _navigateToAlarmsPage(context);
                },
              ),
              ListTile(
                title: Text('Music & Sounds', style: TextStyle(
                  fontSize: 18.0,
                  color: colorStyle("accent"),
                ),
                ),
                onTap: () {
                  _navigateToSoundsPage(context);
                },
              ),
              ListTile(
                title: Text('Sleep Stats',
                  style: TextStyle(
                  fontSize: 18.0,
                  color: colorStyle("accent"),
                  ),
                ),
                onTap: () {
                  _navigateToStatsPage(context);
                },
              ),
              ListTile(
                title: Text('Theme Selection',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: colorStyle("accent"),
                  ),
                ),
                onTap: () {
                  _navigateToColorSelectionPage(context);
                },
              ),
            ],
        ),
      ),
    );
  }

  List<Widget> getListings(){
    List<Widget> listings = new List<Widget>.empty(growable: true);
    Map<String, dynamic> userInfo = getMapDataSorted();
    if(userInfo.isNotEmpty){
      Iterable<String> keys = userInfo.keys;
      var temp;
      for(int i = 0; i<keys.length;i++) {
        temp = userInfo[keys.elementAt(i)];
        listings.add(Container(
          decoration: BoxDecoration(
              color: colorStyle("widgets"),
              borderRadius: BorderRadius.all(
                Radius.circular(20)
              )
          ),
          margin: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          padding: EdgeInsets.only(top:7.0,left: 7.0),
          width: 370,
          height: 100,
          child: Row(
            children: [Column(
                       children: [Text("Date Logged: " + temp["M"].toString() + "/" + temp["D"].toString() + "/" + temp["Y"].toString() + "\n" + "\n" +
                       "Time Slept: " + temp["time"].toString() + "\n" + "\n" +
                       "Sleep Rating: " + temp["rating"].toString(),
                       style: TextStyle(color: colorStyle("main")),
                       textAlign: TextAlign.left,
                       )]
                       ),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [Text("            Start: " + temp["start"].toString() +
                            "\n\n            End: " + temp["end"].toString(),
                        style: TextStyle(color: colorStyle("main")),
                        textAlign: TextAlign.right,)
                        ]
                       )
            ],
          )
        )
        );
      }
    } else {
        listings.add(Container(
          margin: const EdgeInsets.all(1.0),
          color: Colors.transparent,
          alignment: Alignment.center,
          width: 1000,
          height: 650,
          child: Text("No entries available to display!\n",
              style: TextStyle(
                color: colorStyle("main"),
              ),
            )
          )
        );
      }
    return listings;
  }

  void _navigateToAlarmsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AlarmsPage()));
  }

  void _navigateToLogSleepPage(BuildContext context, Function update) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogSleepPage(update, new BasicPresenter(), title: 'Sweet Dreams', key: Key("UNITS"),)));
  }

  void _navigateToColorSelectionPage(BuildContext contex){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ColorPage(update, new BasicPresenter(), title: 'Sweet Dreams', key: Key("UNITS"),)));
  }

  void _navigateToResourcesPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResourcesPage()));
  }

  void _navigateToSoundsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SoundsPage()));
  }

  void _navigateToStatsPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => StatsPage()));
  }

}
