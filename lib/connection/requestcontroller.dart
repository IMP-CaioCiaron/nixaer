import 'dart:io';

import 'package:nixaer/connection/service.dart';

class RequestController {
  String _key = '5qA53G8Pik4xxibfLbFriQ2Ztb05rTjx';
  Service _service;
  String _lat;
  String _long;
  Map<String, Object> _params;

  RequestController(double latitude, double longitude, [
    List fields = const ['temperature', 'weatherCode'],
    List timesteps = const ['current'],
      ]) {
    if (!fields.contains('weatherCode')){fields.add('weatherCode');}
    this._lat = latitude.toString();
    this._long = longitude.toString();
    this._params = {
      'apikey': this._key,
      'location': '${this._lat},${this._long}',
      'fields': fields,
      'units': 'metric',
      'timesteps': timesteps,
    };
  }

  request() async {
    Map data = await Service.get(_params);
    print(data);
    return data['data']['timelines'][0]['intervals'][0]['values'];
  }

}