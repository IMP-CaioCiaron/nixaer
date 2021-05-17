import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:nixaer/credits.dart';
import 'package:nixaer/home.dart';

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
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  App({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  num _activity = 0;
  final List<Widget> _activities = [
    Home(),
    Credits(),
  ];

  void _push(activity){
    setState(() =>{
      _activity = activity
    });
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.indigo[900],
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.white,
        currentIndex: _activity,
        onTap: _push,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início'
        ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Créditos'
          )
        ],
      ),
    body: _activities[_activity]);
  }
}
