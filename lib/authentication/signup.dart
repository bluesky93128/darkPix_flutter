import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:darkPix/authentication/signin.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignupScreen> {
  bool bShowPassword = false;
  bool bConfirmPassword = false;
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
          _textInput('Name'),
          _textInput('Email ID'),
          _password('Password', () {
            setState(() {
              bShowPassword = !bShowPassword;
            });
          }, bShowPassword),
          _password('Confirm Password', () {
            setState(() {
              bConfirmPassword = !bConfirmPassword;
            });
          }, bConfirmPassword),
          _signinButton(),
          _socialLoginButtons(),
          _toSignupPage()
        ],
      ),
    );
  }

  _logo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ],
    );
  }

  _textInput(String text) {
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
              labelText: text,
              labelStyle: TextStyle(color: Colors.white),
            ),
            autofocus: false,
          )),
    );
  }

  _password(String text, Function func, bool bShow) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
          style: TextStyle(color: Colors.white),
          obscureText: bShow,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            labelText: text,
            labelStyle: TextStyle(color: Colors.white),
            suffixIcon: IconButton(
              icon: bShow
                  ? Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    )
                  : Icon(
                      OMIcons.removeRedEye,
                      color: Colors.white,
                    ),
              onPressed: () {
                func();
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
            'Sign Up',
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
                'Sign up using',
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
                'Don\'t have an account?  ',
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
