import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nixaer/util/getPermissions.dart';
import 'package:nixaer/connection/requestcontroller.dart';
import 'package:nixaer/util/weatherCodes.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{
  final String _iconBase = 'assets/colorIcons/';
  Position _position;
  String _address;
  String _weather;
  String _timezone;
  double _latitude;
  double _longitude;
  List _data;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState(){
    super.initState();
    requestPermissions()
        .then((_) => _fetchPosition())
        .onError((error, stackTrace) => print(error));
  }

  Future _fetchPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    String timezone;

    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      print('Could not get the local timezone');
    }

    setState(() {
      _position = position;
      _latitude = _position.latitude;
      _longitude = _position.longitude;
      _timezone = timezone;
    });

    String address = await placemarkFromCoordinates(_latitude, _longitude)
        .then((value){
          return (value.first.subAdministrativeArea != '') ? value.first.subAdministrativeArea : value.first.locality;});

    RequestController _controller = new RequestController(_latitude, _longitude, timezone: _timezone, timesteps: ['1h']);
    var resp = await _controller.request();
    setState(() {
      _data = resp;
      _address = address;
      _weather = WeatherCodes.getWeatherImgName(RequestController.getWCode(_data, 0), RequestController.getTimeHours(_data, 0));
    });
  }


  @override
  Widget build(BuildContext context){
    super.build(context);
    return (_data == null) ?
    SizedBox(
      child:
      Center(
          child: CircularProgressIndicator(
              color: Theme.of(context).accentColor
          )
      ),
      height: 100.0,
      width: 100.0,
    )
    :
    Container(
      child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Row(
                        children: [
                          Text('$_address | '),
                          SvgPicture.asset(
                            _iconBase + '$_weather',
                            semanticsLabel: 'Icon',
                            width: 30,
                            height: 30,
                          ),
                          Text(' ${RequestController.getTemperature(_data, 0)}º')
                        ],
                      )
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 10),
              child: Row(
                children: [Text('Previsão:')],
              ),
            ),
            Divider(),
            AnimationLimiter(
              child: Expanded(
                  child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 25,
                        itemBuilder: (BuildContext context, num index){return AnimationConfiguration.staggeredList(
                          position: index,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                  child:
                                  ((RequestController.getTimeHours(_data, index)) == 00) ?
                                  Column(
                                    children: [
                                      Divider(
                                        indent: 8,
                                        endIndent: 8,
                                        thickness: 4,
                                        color: Colors.indigo,
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Text('${RequestController.getTimeFull(_data, index)} ',
                                              style: Theme.of(context).textTheme.bodyText1),
                                          SvgPicture.asset(
                                            _iconBase + '${WeatherCodes
                                                .getWeatherImgName(RequestController.getWCode(_data, index), RequestController.getTimeHours(_data, index))}',
                                            semanticsLabel: 'Icon',
                                            width: 26,
                                            height: 26,
                                          ),
                                          Text(' ${RequestController.getTemperature(_data, index)}ºC',
                                              style: Theme.of(context).textTheme.bodyText1)
                                        ],
                                      )
                                    ],
                                  )
                                      :
                                  Row(
                                    children: [
                                      Text('${RequestController.getTimeFull(_data, index)} ',
                                          style: Theme.of(context).textTheme.bodyText1),
                                      SvgPicture.asset(
                                        _iconBase + '${WeatherCodes
                                            .getWeatherImgName(RequestController.getWCode(_data, index),
                                            RequestController.getTimeHours(_data, index))}',
                                        semanticsLabel: 'Icon',
                                        width: 26,
                                        height: 26,
                                      ),
                                      Text(' ${RequestController.getTemperature(_data, index)}ºC',
                                          style: Theme.of(context).textTheme.bodyText1)
                                    ],
                                  )
                              ),
                            )
                        );
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                      )
                  )
                  ),
            Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [IconButton(
                        tooltip: 'Atualizar localização atual',
                        icon: Icon(Icons.share_location_rounded),
                        onPressed: _fetchPosition,
                        iconSize: 45,
                      )]
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Atualizar localização',
                      style: TextStyle(
                      fontSize: 16
                    ),)
                  )
                ],
              ),
          ]
      ),
    );
  }
}