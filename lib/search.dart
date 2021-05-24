import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nixaer/connection/requestcontroller.dart';
import 'package:nixaer/util/weatherCodes.dart';
import 'package:nixaer/util/formatOutput.dart';


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

  Map<String, String> _checks = {
    'temperature': 'Temperatura',
    'temperatureApparent': 'Sensação térmica',
    'humidity': 'Humidade',
    'windSpeed': 'Velocidade do vento',
    'windDirection': 'Direção do vento',
    'pressureSurfaceLevel': 'Pressão na superfície',
    'precipitationProbability': 'Chance de precipitação'
  };

  Map<String, bool> _metrics ={
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
    _metrics.forEach((key, value) {
      if(value){
        temp.add(key);
      }
    });
    return temp;
  }

  void requestTime() async {
    String placeMark = _textEditingController.text;
    List<Location> position = await locationFromAddress(placeMark);
    String timezone;

    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      print('Could not get the local timezone');
    }

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
        _controller = new RequestController(_latitude, _longitude, timezone: timezone);
      });

    } else if (_params.isNotEmpty){
      setState(() {
        _controller = new RequestController(_latitude, _longitude, fields:_params, timezone: timezone);
      });

      temp.clear();
    }
    var resp = await _controller.request();
    setState(() {
      _data = resp;
      _address = address;
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
                  children:_metrics.keys.map((String key){
                    return CheckboxListTile(
                      title: Text('${_checks[key]}'),
                      value: _metrics[key],
                      activeColor: Colors.indigo,
                      checkColor: Colors.blue,
                      onChanged: (bool value){
                        setState(() {
                          _metrics[key] = value;
                        }
                        );
                      },
                    );
                  }).toList(),
                )
              ],
            )
          ),
          (_data != null) ? Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Row(
                children: [
                  Text('Clima: '),
                  SvgPicture.asset(
                    _iconBase + '${WeatherCodes
                        .getWeatherImgName(RequestController.getWCode(_data, 0), RequestController.getTimeHours(_data, 0))}',
                    semanticsLabel: 'Icon',
                    width: 30,
                    height: 30,
                  )
                ],
              )
          ) : Text(''),
          AnimationLimiter(
              child: Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: (_params != null) ? _params.length-1 : 0,
                    itemBuilder: (BuildContext context, num index){return AnimationConfiguration.staggeredList(
                        position: index,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: (_data != null) ?
                            Column(children: [
                              Row(
                                children: [
                                  formatOutput(_checks[_params[index]], _data, 0)
                                ],
                              )
                            ]
                            ) : Text('Aguardando')
                          ),
                        )
                    );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                  )
              )
          )
        ],
      )
    );
  }
}