import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:nixaer/util/getPermissions.dart';
import 'package:nixaer/connection/requestcontroller.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{
  bool keepAlive = false;
  StreamSubscription _update;
  final String _iconBase = 'assets/colorIcons/';
  Position _position;
  String _address;
  double _latitude;
  double _longitude;
  var data;

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
    setState(() {
      _position = position;
      _latitude = _position.latitude;
      _longitude = _position.longitude;
    });

    String address = await placemarkFromCoordinates(_latitude, _longitude)
        .then((value){
          return (value.first.subAdministrativeArea != '') ? value.first.subAdministrativeArea : value.first.locality;});

    RequestController _controller = new RequestController(_latitude, _longitude);
    var resp = await _controller.data;
    setState(() {
      data = resp;
      _address = address;
      print(data);
    });
  }

//TODO update weather button


  @override
  Widget build(BuildContext context){
    super.build(context);
    return Container(
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
                          SvgPicture.asset(
                            _iconBase + 'ice_pellets.svg',
                            semanticsLabel: 'Icon',
                            width: 45,
                            height: 45,
                          ),
                          Text('Placeholder'),
                          IconButton(
                            icon: Icon(Icons.access_alarm),
                            onPressed: (){

                            },
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
            Text('$_position, $_address'),

            /*FutureBuilder(
          future: _position,
          builder: (context, snapshot){
            if (!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
              return Text('${snapshot.data}');
            }
            var _data = snapshot.data;
            return Text('${_data.longitude}');
          },
        ),*/
          ]),
    );
  }


}





