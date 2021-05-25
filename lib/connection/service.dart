import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';


class Service{

  static Future<Map> get(params) async {
    Uri uri = Uri.https('api.tomorrow.io', 'v4/timelines', params);
    http.Response resp = await http.get(uri);
    return jsonDecode(resp.body);
  }

}

