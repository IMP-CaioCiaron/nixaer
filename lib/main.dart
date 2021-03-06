import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:nixaer/credits.dart';
import 'package:nixaer/home.dart';
import 'package:nixaer/search.dart';

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
          bodyText2: TextStyle(color: Colors.white, fontSize: 24),
          bodyText1: TextStyle(color: Colors.white, fontSize: 18)
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
  final PageController _activityController = new PageController(initialPage: 0);
  num _activity;
  List<Widget> _activities;

  @override
  void initState(){
    super.initState();
    _activity = 0;
    _activities = [
      Home(),
      Search(),
      Credits(),
    ];

  }

  @override
  void dispose(){
    _activityController.dispose();
    super.dispose();
  }

  void _push(activity){
    _activityController.animateToPage(
        activity, duration: Duration(milliseconds: 300), curve: Curves.easeOut
    );
  }

  void _mount(activity){
    if (this.mounted){
      setState(() {
        this._activity = activity;
      });
    }
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
            label: 'In??cio'
        ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisar local'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Cr??ditos'
          )
        ],
      ),
        body: PageView(
          controller: _activityController,
          onPageChanged: _mount,
          children: _activities,
        )
    );
  }
}
