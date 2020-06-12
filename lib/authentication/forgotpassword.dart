import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:darkPix/authentication/signin.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool bShowPassword = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(resizeToAvoidBottomPadding: false, body: _body());
  }

  _body() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/img/loginbg.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: <Widget>[
          _logo(),
          _userId(),
          _signinButton(),
          _toSignupPage(),
        ],
      ),
    );
  }

  _logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 90, 0, 0),
            child: Text('Forgot Password',
                style: TextStyle(fontSize: 30, color: Colors.white))),
      ],
    );
  }

  _userId() {
    return Padding(
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
              labelText: 'Email Id',
              labelStyle: TextStyle(color: Colors.white),
            ),
            autofocus: false,
          )),
    );
  }

  _password() {
    return Padding(
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
        ),
      ),
    );
  }

  _rememberAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1,
              10, MediaQuery.of(context).size.width * 0.1, 0),
          child: GestureDetector(
            child: Row(
              children: <Widget>[
                rememberMe
                    ? Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.check_box,
                        color: Colors.white,
                      ),
                Text(
                  'Remember Me',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                rememberMe = !rememberMe;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              0, 10, MediaQuery.of(context).size.width * 0.1, 0),
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }

  _signinButton() {
    return Padding(
      padding: EdgeInsets.only(top: 24),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        child: RaisedButton(
          color: Colors.white,
          onPressed: () {},
          child: Text(
            'Reset',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  _socialLoginButtons() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 1,
                  width: 50,
                  color: Colors.white,
                ),
              ),
              Text(
                'Sign in using',
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 1,
                  width: 50,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.39,
                  height: 50,
                  child: RaisedButton(
                    child: Text('Facebook'),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.39,
                  height: 50,
                  child: RaisedButton(
                    child: Text('Google'),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _toSignupPage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 48),
          child: Row(
            children: <Widget>[
              Text(
                'Back to  ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          SignInScreen(),
                    ),
                  );
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.dashed,
                      color: Colors.white,
                      fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}