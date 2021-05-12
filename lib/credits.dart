import 'package:flutter/material.dart';
import 'package:nixaer/bloc/nixaerBloc.dart';


class Credits extends StatelessWidget {
  // This widget is the root of your application.
  final _bloc= NixaerBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.output,
        builder: (context, snapshot) {
          return Scaffold(
              body: Center(
                  child: Text("${snapshot.data}")
              )
          );
        }
    );
  }
}