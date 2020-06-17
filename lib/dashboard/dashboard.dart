import 'package:darkPix/dashboard/dashboard_main.dart';
import 'package:darkPix/dashboard/search.dart';
import 'package:flutter/material.dart';
import 'package:darkPix/dashboard/bottom_nav_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  var _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        print('1111111111');
        break;
      case 1:
        print('2222222222');
        break;
      case 2:
        print('3333333333');
        break;
      case 3:
        print('4444444444');
        break;
    }
  }

  _render() {
    switch (_selectedIndex) {
      case 0:
        return DashboardMainPage();
      case 1:
        return SearchPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: SizedBox(
          width: 100,
          height: 20,
          child: Image.asset(
            'lib/assets/img/logo.png',
            fit: BoxFit.fill,
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          _render(),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FABBottomAppBar(
                centerItemText: 'A',
                color: Colors.grey,
                selectedColor: Colors.orange,
                notchedShape: CircularNotchedRectangle(),
                onTabSelected: _onItemTapped,
                items: [
                  FABBottomAppBarItem(iconData: Icons.offline_bolt),
                  FABBottomAppBarItem(iconData: Icons.search),
                  FABBottomAppBarItem(iconData: Icons.grade),
                  FABBottomAppBarItem(iconData: Icons.account_circle),
                ],
              ),
            ],
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(
          Icons.camera_alt,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
