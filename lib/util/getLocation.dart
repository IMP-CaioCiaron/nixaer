import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class FetchCurrentLocation{
  Position currentposition;
  String address;
  double latitude;
  double longitude;

  void fetchPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    currentposition = position;
    latitude = position.latitude;
    longitude = position.longitude;
  }
}







