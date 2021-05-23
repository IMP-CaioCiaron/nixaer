import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nixaer/util/getPermissions.dart';
import 'package:nixaer/connection/requestcontroller.dart';


class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search>{
  TextEditingController _textEditingController = TextEditingController();
  Map<String, bool> _checks ={
    'temperature': false,
    'temperatureApparent': false,
    'humidity': false,
    'windSpeed': false,
    'windDirection': false,
    'pressureSurfaceLevel': false,
    'precipitationProbability': false,
    'sunriseTime': false,
    'sunsetTime': false,
  };

  List temp = [];

  void requestTime(){

  }


  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25),
              child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Digite a localização'),
                      style: TextStyle(
                          fontSize: 14),
                      controller: _textEditingController,
                      onSubmitted: (String text){},
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(top: 26),
                    icon: Icon(Icons.search),
                    onPressed: (){},
                  )],
              )),
        ],
      )
    );
  }
}