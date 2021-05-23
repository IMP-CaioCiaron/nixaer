import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';

/*dynamic receiveData(lat, long) async {
  String baseURL = 'https://api.tomorrow.io/';
  var location = '$lat,$long';
  var key = '5qA53G8Pik4xxibfLbFriQ2Ztb05rTjx';
  var fields = [
    "temperature",
  ];
  const units = 'metric';
  const timesteps = ['current'];

  var params = {
    'apikey': key,
    'location': location,
    'fields': fields,
    'units': units,
    'timesteps': timesteps,
  };

  var uri = Uri.https('api.tomorrow.io', 'v4/timelines', params);
  var requestURL = '$baseURL?$uri';
  var resp = await http.get(uri);
  var ret = jsonDecode(resp.body);
  return ret;
}*/

// depois eu arrumo isso aq

class Service{

  static Future<Map> get(params) async {
    Uri uri = Uri.https('api.tomorrow.io', 'v4/timelines', params);
    http.Response resp = await http.get(uri);
    return jsonDecode(resp.body);
  }

}

