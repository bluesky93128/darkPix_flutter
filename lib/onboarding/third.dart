import 'package:flutter/material.dart';

class ThirdOnboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 59),
          child: Image.asset('lib/assets/img/third-onboarding.png'),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            'Upload Your Own',
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
            'Don’t feel like going out? No problem, we’ll deliver your order. In bed! :)',
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
