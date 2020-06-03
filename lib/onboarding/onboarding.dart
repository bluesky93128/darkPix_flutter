import 'package:flutter/material.dart';
import 'package:darkPix/onboarding/first.dart';
import 'package:darkPix/onboarding/second.dart';
import 'package:darkPix/onboarding/third.dart';
import 'package:darkPix/authentication/splash.dart';

class FirstOnboardingScreen extends StatefulWidget {
  @override
  _FirstOnboardingScreenState createState() => _FirstOnboardingScreenState();
}

class _FirstOnboardingScreenState extends State<FirstOnboardingScreen> {
  int currentPageValue = 0;

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.white10,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  final _controller = PageController(initialPage: 0);

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SplashPage(),
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'lib/assets/img/loginbg.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: Image.asset('lib/assets/img/logo.png'),
                  ),
                ],
              ),
              Flexible(
                child: PageView(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  onPageChanged: (int page) {
                    getChangedPageAndMoveBar(page);
                  },
                  children: <Widget>[
                    FirstOnboarding(),
                    SecondOnboarding(),
                    ThirdOnboarding(),
                  ],
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 35),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < 3; i++)
                          if (i == currentPageValue) ...[circleBar(true)] else
                            circleBar(false),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: RaisedButton(
                  child: currentPageValue < 2 ? Text('Next') : Text('Start'),
                  onPressed: () {
                    if (currentPageValue < 2) {
                      getChangedPageAndMoveBar(currentPageValue + 1);
                      _controller.animateToPage(currentPageValue,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    } else {
                      Navigator.of(context).push(_createRoute());
                    }
                  },
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline),
                ),
                color: Colors.transparent,
              )
            ],
          )
        ],
      ),
    );
  }
}
