import 'package:rxdart/rxdart.dart';
import 'package:nixaer/service/nixaer.service.dart';

class NixaerBloc{
  final __service = NixaerService();
  final __controller = BehaviorSubject();

  Stream get output => __controller.stream;
  Sink get input => __controller.sink;

  placeholderTodosGet() async {
    await __service.testGet().then(input.add);
  }

  void dispose(){
    __controller.close();
  }

}