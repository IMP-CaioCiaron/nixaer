import 'package:flutter/material.dart';


class Credits extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
                children: [
                  Icon(Icons.account_circle_rounded, size: 50),
                  Text("Caio Henrique",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
                children: [
                  Icon(Icons.account_circle_rounded, size: 50),
                  Text("Lucas Leli",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}