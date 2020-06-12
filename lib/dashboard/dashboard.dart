import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _categoryItem('popular'),
                  _categoryItem('natural'),
                  _categoryItem('fashion'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _categoryItem(String asset) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Stack(
        children: <Widget>[
          Container(
            width: 150,
            decoration: BoxDecoration(
              // color: const Color(0xff7c94b6),
              image: new DecorationImage(
                fit: BoxFit.cover,
                image: new AssetImage('lib/assets/img/cart-' + asset + '.png'),
              ),
            ),
            // child: Image.asset(asset),
          ),
          Container(
            width: 150,
            decoration: BoxDecoration(
              // color: const Color(0xff7c94b6),
              image: new DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
                image: new AssetImage(
                  'lib/assets/img/cart-overlay.png',
                ),
              ),
            ),
          ),
          Container(
            width: 150,
            child: Center(
              child: Text(
                asset[0].toUpperCase() + asset.substring(1),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
