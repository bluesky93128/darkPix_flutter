import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:darkPix/dashboard/bottom_nav_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List albumData = new List();
  int cur_page = 1;
  String cur_category = 'fashion';
  ScrollController _controller;
  var _selectedIndex = 0;

  _scrollListner() {
    if (_controller.position.atEdge) {
      if (_controller.position.pixels == 0) {
      } else {
        setState(() {
          cur_page = cur_page + 1;
          fetchAlbum(cur_page, cur_category, false);
        });
      }
    }
  }

  void fetchAlbum(page, category, refresh) async {
    final response = await http.get(
        'https://api.unsplash.com/photos/random?client_id=zu8gZp8_xoBcEwA2Mxg-s6Ky4ghDtrYeBUpyNm_KXC0&count=30&query=' +
            category +
            '&page=' +
            page.toString());

    if (response.statusCode == 200) {
      setState(() {
        if (!refresh) {
          albumData.addAll(json.decode(response.body));
        } else {
          albumData = json.decode(response.body);
        }
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAlbum(cur_page, cur_category, true);
    _controller = ScrollController();
    _controller.addListener(_scrollListner);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          child: Stack(
        children: <Widget>[
          Column(
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
              Expanded(
                child: _addAlbum(),
              )
            ],
          ),
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
                  FABBottomAppBarItem(
                      iconData: Icons.grade),
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
        child: Icon(Icons.camera_alt, color: Colors.black,),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _categoryItem(String asset) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            cur_page = 1;
            cur_category = asset;
            fetchAlbum(cur_page, cur_category, true);
          });
        },
        child: Stack(
          children: <Widget>[
            Container(
              width: 150,
              decoration: BoxDecoration(
                // color: const Color(0xff7c94b6),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      new AssetImage('lib/assets/img/cart-' + asset + '.png'),
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
      ),
    );
  }

  _addAlbum() {
    return new Padding(
      padding: const EdgeInsets.all(4.0),
      //this is what you actually need
      child: new StaggeredGridView.count(
        controller: _controller,
        crossAxisCount: 4, // I only need two card horizontally
        padding: const EdgeInsets.all(2.0),
        children: albumData.map((item) {
          //Do you need to go somewhere when you tap on this card, wrap using InkWell and add your route
          return Card(
            semanticContainer: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            child: Image.network(item['urls']['thumb']),
          );
        }).toList(),

        //Here is the place that we are getting flexible/ dynamic card for various images
        staggeredTiles: albumData.map((_) => StaggeredTile.fit(2)).toList(),
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 4.0, // add some space
      ),
    );
  }
}
