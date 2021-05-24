import 'package:nixaer/connection/service.dart';

class RequestController {
  String _key = '5qA53G8Pik4xxibfLbFriQ2Ztb05rTjx';
  String _lat;
  String _long;
  Map<String, Object> _params;

  RequestController(double latitude, double longitude, {
    List fields = const ['temperature', 'weatherCode'],
    List timesteps = const ['current'],
    String timezone = 'UTC',
  }) {
    if (!fields.contains('weatherCode')){fields.add('weatherCode');}
    this._lat = latitude.toString();
    this._long = longitude.toString();
    this._params = {
      'apikey': this._key,
      'location': '${this._lat},${this._long}',
      'fields': fields,
      'units': 'metric',
      'timesteps': timesteps,
      'timezone': timezone,
    };
  }

  request() async {
    Map data = await Service.get(_params);
    return data['data']['timelines'][0]['intervals'];
  }

  static int getTimeHours(List data, int index){
    return int.parse(data[index]['startTime']
        .substring(data[index]['startTime'].indexOf('T')+1, 13));
  }

  static String getTimeFull(List data, int index){
    return (data[index]['startTime']
        .substring(data[index]['startTime'].indexOf('T')+1, 16));
  }

  static int getWCode(List data, int index){
    return data[index]['values']['weatherCode'];
  }

  static int getTemperature(List data, int index){
    return data[index]['values']['temperature'].round();
  }

  static int getTemperatureApparent(List data, int index){
    return data[index]['values']['temperatureApparent'].round();
  }

  static int getHumidity(List data, int index){
    return data[index]['values']['humidity'].round();
  }

  static double getWindSpeed(List data, int index){
    return data[index]['values']['windSpeed'];
  }

  static getWindDirection(List data, int index){
    return (data[index]['values']['windDirection'] == null) ? 'N/A' : data[index]['values']['windDirection'];
  }

  static getPressureSurface(List data, int index){
    return data[index]['values']['pressureSurfaceLevel'];
  }

  static getprecipitationChance(List data, int index){
    return data[index]['values']['precipitationProbability'];
  }
}