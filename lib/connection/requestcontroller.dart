import 'package:nixaer/connection/service.dart';

class RequestController{
  String _lat;
  String _long;
  var _data;

  RequestController(lat, long){
    this._lat = lat.toString();
    this._long = long.toString();
    _data = receiveData(this._lat, this._long);
  }

  get data => _data;

}