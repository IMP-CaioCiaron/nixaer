import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


Future<Position> requestPermissions() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  //return await Geolocator.getCurrentPosition();
}

getAddress(latitude, longitude) async {
  return await placemarkFromCoordinates(latitude, longitude);
}

























/*class Locator {
  Location _location = new Location();
  LocationData currentLocation;
  double latitude, longitude;
  String address;


  getCurrentLocation() async {
    bool _locServiceStatus = await _location.serviceEnabled();
    if (!_locServiceStatus){
      _locServiceStatus = await _location.requestService();
      if (!_locServiceStatus){
        return;
      }
    }

    PermissionStatus _hasPermission = await _location.hasPermission();
    if (_hasPermission == PermissionStatus.denied){
      _hasPermission = await _location.requestPermission();
      if (_hasPermission != PermissionStatus.granted){
        return;
      }
    }

    LocationData locationData = await _location.getLocation();
    return locationData;
  }

  Future<List<gc.Placemark>> convertCoords(double latitude, double longitude) async {
    List<gc.Placemark> _address = await gc.placemarkFromCoordinates(latitude, longitude);
    return _address;
  }

  Future<List<gc.Location>> convertAddress(String address) async {
    List<gc.Location> _coordinates = await gc.locationFromAddress(address);
    return _coordinates;
  }
}*/
