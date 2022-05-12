import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/dreams_utils.dart';

class SoundsPage extends StatefulWidget {
  @override
  _SoundsPageState createState() => _SoundsPageState();
}

class _SoundsPageState extends State<SoundsPage> {
  int pictureNumber = 8;
  bool isPlaying = false;
  static AudioPlayer audioPlayer = new AudioPlayer();
  static AudioCache audioCache = new AudioCache(fixedPlayer: audioPlayer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorStyle("appBackground"),
      appBar: AppBar(
        title: GradientText('Sleep Sounds',
            style: TextStyle(fontSize: 30.0),
            colors: [colorStyle("gradient1"), colorStyle("gradient2"),
              colorStyle("gradient3"), colorStyle("gradient2"),
              colorStyle("gradient1")]),
        centerTitle: true,
        backgroundColor: colorStyle("appHeader"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(80.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  child: Container(
                      width: 200,
                      child: Image.asset('assets/images/$pictureNumber.png')),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  'Turn Off',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                color: Colors.red,
                onPressed: () {
                  stopSound();
                  changePicture(8);
                }),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: buildKey(
                      text: 'Birds',
                      color: colorStyle("accent"),
                      soundNumber: 1,
                      buttonPicture: 1),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: buildKey(
                      text: 'Fan',
                      color: colorStyle("accent"),
                      soundNumber: 2,
                      buttonPicture: 2),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: buildKey(
                      text: 'Guitar',
                      color: colorStyle("accent"),
                      soundNumber: 3,
                      buttonPicture: 3),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: buildKey(
                      text: 'Storm',
                      color: colorStyle("accent"),
                      soundNumber: 4,
                      buttonPicture: 4),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: buildKey(
                      text: 'Waterfall',
                      color: colorStyle("accent"),
                      soundNumber: 5,
                      buttonPicture: 5),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: buildKey(
                      text: 'Waves',
                      color: colorStyle("accent"),
                      soundNumber: 6,
                      buttonPicture: 6),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: buildKey(
                      text: 'Whales',
                      color: colorStyle("accent"),
                      soundNumber: 7,
                      buttonPicture: 7),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void changePicture(buttonPicture) {
    setState(() {
      pictureNumber = buttonPicture;
    });
  }

  void playSound(soundNumber) {
    audioCache.loop('sounds/$soundNumber.mp3');
    isPlaying = true;
  }

  void stopSound() {
    if (isPlaying = true) {
      audioPlayer.stop();
      isPlaying = false;
    }
  }

  FlatButton buildKey(
      {Color? color, int? soundNumber, String? text, int? buttonPicture}) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        '$text',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      color: color,
      onPressed: () {
        playSound(soundNumber);
        changePicture(buttonPicture);
        stopSound();
      },
    );
  }
}
