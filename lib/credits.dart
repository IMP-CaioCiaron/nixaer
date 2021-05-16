import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Credits extends StatelessWidget {
  // This widget is the root of your application.
  final String iconBase = 'assets/colorIcons/';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 5),
            child: Row(
                children: [
                  Icon(Icons.account_circle_rounded, size: 50),
                  Text("Caio Henrique",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ]),
          ),
          Divider(
              height: 25,
              thickness: 1,
              color: Colors.white,
            ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Row(
                children: [
                  Icon(Icons.account_circle_rounded, size: 50),
                  Text("Lucas Leli",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50),
            child: SvgPicture.asset(
              iconBase + 'ice_pellets.svg',
              semanticsLabel: 'Icon',
            ),
          ),
        ],
      ),
    );
  }
}