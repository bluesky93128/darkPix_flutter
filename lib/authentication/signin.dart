import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool bShowPassword = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/img/loginbg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            // Image.asset(
            //   'lib/assets/img/loginbg.png',
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   fit: BoxFit.fill,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 160),
                  child: Image.asset(
                    'lib/assets/img/logo.png',
                    scale: 0.7,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'User ID',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    autofocus: false,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    obscureText: !bShowPassword,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        icon: bShowPassword
                            ? Icon(
                                Icons.remove_red_eye,
                                color: Colors.white,
                              )
                            : Icon(
                                OMIcons.removeRedEye,
                                color: Colors.white,
                              ),
                        onPressed: () {
                          setState(() {
                            bShowPassword = !bShowPassword;
                          });
                        },
                      ),
                    ),
                    autofocus: false,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
