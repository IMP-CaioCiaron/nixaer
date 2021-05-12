import 'package:dio/dio.dart';

class NixaerService {
  final dio = Dio();

  testGet() async {
    Response response = await dio.get("https://jsonplaceholder.typicode.com/todos/1");
    return response.data;
  }
}