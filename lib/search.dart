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
  RequestController _controller;
  final String _iconBase = 'assets/colorIcons/';
  Location _position;
  String _address;
  double _latitude;
  double _longitude;
  List _params;
  var _data;

  Map<String, bool> _checks ={
    'temperature': false,
    'temperatureApparent': false,
    'humidity': false,
    'windSpeed': false,
    'windDirection': false,
    'pressureSurfaceLevel': false,
    'precipitationProbability': false,
  };

  List temp = [];

  mountMetrics(){
    _checks.forEach((key, value) {
      if(value){
        temp.add(key);
      }
    });
    return temp;
  }
  void requestTime() async {
    String placeMark = _textEditingController.text;
    List<Location> position = await locationFromAddress(placeMark);

    setState(() {
      _position = position[0];
      _latitude = _position.latitude;
      _longitude = _position.longitude;
    });

    String address = await placemarkFromCoordinates(_latitude, _longitude)
        .then((value){
      return (value.first.subAdministrativeArea != '') ? value.first.subAdministrativeArea : value.first.locality;});

    _params = new List.from(mountMetrics());

    if (_params.isEmpty){
      setState(() {
        _controller = new RequestController(_latitude, _longitude);
      });

    } else if (_params.isNotEmpty){
      setState(() {
        _controller = new RequestController(_latitude, _longitude, _params);
      });

      temp.clear();
    }
    var resp = await _controller.request();
    setState(() {
      _data = resp;
      _address = address;
      print(_data);
    });

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
                      onSubmitted: (String text){
                        requestTime();
                      },
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(top: 26),
                    icon: Icon(Icons.search),
                    onPressed: (){
                      requestTime();
                      },
                  )],
              )
          ),
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(
                  title: Text('Métricas'),
                  children:_checks.keys.map((String key){
                    return CheckboxListTile(
                      title: Text(key),
                      value: _checks[key],
                      activeColor: Colors.indigo,
                      checkColor: Colors.blue,
                      onChanged: (bool value){
                        setState(() {
                          _checks[key] = value;
                        }
                        );
                      },
                    );
                  }).toList(),

                )
              ],
              /*_checks.keys.map((String key){
                return CheckboxListTile(
                  title: Text(key),
                  value: _checks[key],
                  activeColor: Colors.indigo,
                  checkColor: Colors.blue,
                  onChanged: (bool value){
                    setState(() {
                      _checks[key] = value;
                    }
                    );
                    },
                );
              }).toList(),*/
            )
          )
/*          Padding(
              padding: EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Placeholder | '),
                  SvgPicture.asset(
                    _iconBase + 'ice_pellets.svg',
                    semanticsLabel: 'Icon',
                    width: 45,
                    height: 45,
                  ),
                ],
              )
          ),*/],
      )
    );
  }
}