import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:nixaer/credits.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: Colors.black,
        accentColor: Colors.blue[800],
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.white, fontSize: 24)
        ),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Credits(),
    );
  }
}

class Splash extends StatefulWidget {
  Splash({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {

  @override
  Widget build(BuildContext context){

  }
}
