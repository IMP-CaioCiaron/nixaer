import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  final String iconBase = 'assets/colorIcons/';

  @override
  Widget build(BuildContext context){
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        iconBase + 'ice_pellets.svg',
                        semanticsLabel: 'Icon',
                        width: 45,
                        height: 45,
                      ),
                      Text('Placeholder'),
                    ],
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





