import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> fetchAlbum(page, category) async {
  final response = await http.get('https://api.unsplash.com/photos/random?client_id=zu8gZp8_xoBcEwA2Mxg-s6Ky4ghDtrYeBUpyNm_KXC0&count=30&query='+category+'&page='+page.toString());

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load album');
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List> albumData;
  int cur_page = 1;
  String cur_category = 'popular';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    albumData = fetchAlbum(cur_page, cur_category);
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
            Expanded(child: _addAlbum(),)
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

  _addAlbum() {
    return FutureBuilder<List>(
      future: albumData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return new Padding(
            padding: const EdgeInsets.all(4.0),
            //this is what you actually need
            child: new StaggeredGridView.count(
              crossAxisCount: 4, // I only need two card horizontally
              padding: const EdgeInsets.all(2.0),
              children: snapshot.data.map<Widget>((item) {
                //Do you need to go somewhere when you tap on this card, wrap using InkWell and add your route
                return Card(
                  semanticContainer: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: Image.network(item['urls']['small']),
                );
              }).toList(),

              //Here is the place that we are getting flexible/ dynamic card for various images
              staggeredTiles: snapshot.data
                  .map<StaggeredTile>((_) => StaggeredTile.fit(2))
                  .toList(),
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 4.0, // add some space
            ),
          );
        } else {
          return Center(
              child:
                  new CircularProgressIndicator()); // If there are no data show this
        }
      },
    );
  }
}
