import 'package:rxdart/rxdart.dart';

class NixaerController{
  final __controller = BehaviorSubject();

  Stream get output => __controller.stream;

  Sink get input => __controller.sink;

}