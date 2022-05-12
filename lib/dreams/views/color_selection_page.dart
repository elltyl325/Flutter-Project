import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:units/dreams/presenter/dreams_presenter.dart';
import '../utils/dreams_utils.dart';

class ColorPage extends StatefulWidget{
  final UNITSPresenter presenter;
  final Function callback;

  ColorPage(this.callback, this.presenter, {required Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ColorPageState createState() => _ColorPageState();
}

class _ColorPageState extends State<ColorPage> {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText('Theme Selection',
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
        child: Column(
          children: getButtons()
          ),
        ),
      );
  }

  List<MaterialButton> getButtons(){
   List<MaterialButton> buttons = new List<MaterialButton>.empty(growable: true);
   buttons.add(defaultThemeButton());
   buttons.add(monochromeThemeButton());
   buttons.add(pinkThemeButton());
   buttons.add(sherbetThemeButton());
   buttons.add(thunderThemeButton());
   buttons.add(redThemeButton());
   buttons.add(transThemeButton());
   buttons.add(enbyThemeButton());
   return buttons;
  }
  MaterialButton defaultThemeButton(){
    return MaterialButton(
      minWidth: 200,
      onPressed: () {
        defaultTheme();
        this.widget.callback();
        setState((){});
        setThemeKey(1);
      },
      child: Text(
          "Default",
          style: TextStyle(
            color: Colors.cyan.shade500,
          )
      ),
      color: Colors.blueGrey.shade900,
    );
  }
  MaterialButton redThemeButton(){
    return MaterialButton(
      minWidth: 200,
      onPressed: () {
        redTheme();
        this.widget.callback();
        setState((){});
        setThemeKey(6);
      },
      child: Text(
          "Red",
          style: TextStyle(
            color: Colors.red.shade900,
          )
      ),
      color: Colors.white70,
    );
  }
  MaterialButton transThemeButton(){
    return MaterialButton(
      minWidth: 200,
      onPressed: () {
        transTheme();
        this.widget.callback();
        setState((){});
        setThemeKey(7);
      },
      child: GradientText(
          "Trans Rights",
          colors: [Colors.lightBlue, Colors.pinkAccent.shade100,Colors.white,
            Colors.pinkAccent.shade100,Colors.lightBlue],
      ),
      color: Colors.pinkAccent,
    );
  }
  MaterialButton enbyThemeButton(){
    return MaterialButton(
      minWidth: 200,
      onPressed: () {
        enbyTheme();
        this.widget.callback();
        setState((){});
        setThemeKey(8);
      },
      child: GradientText(
        "Enby Rights",
        colors: [Colors.yellow, Colors.white,Colors.purple.shade200,
          Colors.black],
      ),
      color: Colors.purple.shade800,
    );
  }
  MaterialButton monochromeThemeButton(){
    return MaterialButton(
      minWidth: 200,
      onPressed: () {
        monochromeTheme();
        this.widget.callback();
        setState((){});
        setThemeKey(2);
      },
      child: Text(
          "Monochrome",
          style: TextStyle(
            color: Colors.grey.shade500,
          )
      ),
      color: Colors.grey.shade900,
    );
  }
  MaterialButton pinkThemeButton(){
    return MaterialButton(
      minWidth: 200,
      onPressed: () {
        pinkTheme();
        this.widget.callback();
        setState((){});
        setThemeKey(3);
      },
      child: Text(
          "Pink",
          style: TextStyle(
              color: Colors.pink.shade500,
              )
          ),
      color: Colors.pink.shade900,
    );
  }
  MaterialButton sherbetThemeButton(){
    return MaterialButton(
      minWidth: 200,
      onPressed: () {
        sherbetTheme();
        this.widget.callback();
        setState((){});
        setThemeKey(4);
      },
      child: Text(
          "Sherbet",
          style: TextStyle(
            color: Colors.green.shade300,
          )
      ),
      color: Colors.pink.shade300,
    );
  }
  MaterialButton thunderThemeButton(){
    return MaterialButton(
      minWidth: 200,
      onPressed: () {
        thunderTheme();
        this.widget.callback();
        setState((){});
        setThemeKey(5);
      },
      child: Text(
          "Thunder",
          style: TextStyle(
            color: Colors.yellow,
          )
      ),
      color: Colors.grey.shade800,
    );
  }

}