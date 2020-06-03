import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:async';
import 'package:splashscreen/splashscreen.dart';
import 'package:darkPix/authentication/signin.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => SignInScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return SplashScreen(
    //   backgroundColor: Colors.black,
    //   image: Image.asset('lib/assets/img/splash.png'),
    //   seconds: 5,
    //   navigateAfterSeconds: new SignInScreen(),
    // );

    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedOpacity(
        opacity: 1,
        duration: Duration(seconds: 1),
        child: Stack(
          children: <Widget>[
            Image.asset(
              'lib/assets/img/splash.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 120),
                  child: Image.asset(
                    'lib/assets/img/logo.png',
                    scale: 0.7,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
