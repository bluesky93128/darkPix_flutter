import 'package:flutter/material.dart';

class FirstOnboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 59),
          child: Image.asset('lib/assets/img/first-onboarding.png'),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'HD Wallpaper',
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Archivo',
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(33, 18, 33, 0),
          child: Text(
            'Discover the best menus from over 100 cuisines and over 1000 restaurants.',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Archivo',
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
