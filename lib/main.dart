import 'dart:async';

import 'package:flutter/material.dart';
import 'package:units/dreams/utils/dreams_utils.dart';

import 'dreams/views/dreams_component.dart';
import 'dreams/presenter/dreams_presenter.dart';
import 'dreams/utils/dreams_data_management.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Uncomment the following line to reset the list of stored IDs on start.
  //setList(userIDs);
  runApp(MyApp());
  userIDs = (await getList())!;
  getAllUserData(userIDs);
  //print(tempUserData);
  int color = (await getThemeKey())!;
  setTheme(color);
  await AndroidAlarmManager.initialize();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
    );
  }
}
      // home: Builder(
      //   builder: (context) => Scaffold(
      //     appBar: AppBar(
      //       title: Text("Sweet Dreams"),
      //     ),
      //     body: Center(
      //       child: Column(
      //         children: <Widget>[
      //           Padding(
      //             padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      //             child: Text("Sweet Dreams!",style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white), textScaleFactor: 3,)
      //             ),
      //           ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //                 primary: Colors.blueAccent
      //             ),
      //             child: Text('Begin'),
      //             onPressed: () {
      //               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      //                 return SplashScreen();
      //               }));
      //             },
      //           )
      //         ],
      //       )
      //     ),
      //   )
      // )
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorStyle("appBackground"),
        body: Center(
          child: Image.asset('assets/images/blackcloud.png'),
        ),
    );
  }

}
