import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:darkPix/dashboard/preview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryViewPage extends StatefulWidget {
  final category;

  CategoryViewPage({this.category});

  @override
  _CategoryViewPageState createState() => _CategoryViewPageState();
}

class _CategoryViewPageState extends State<CategoryViewPage> {
  List albumData = new List();
  int cur_page = 1;
  ScrollController _controller;
  String orientation;
  String color;
  String quality;

  _scrollListner() {
    if (_controller.position.atEdge) {
      if (_controller.position.pixels == 0) {
      } else {
        setState(() {
          cur_page = cur_page + 1;
          fetchAlbum(cur_page, false, orientation, color);
        });
      }
    }
  }

  void fetchAlbum(page, refresh, orientation, color) async {
    final response = await http.get(
        'https://api.unsplash.com/search/photos?client_id=zu8gZp8_xoBcEwA2Mxg-s6Ky4ghDtrYeBUpyNm_KXC0&per_page=30&query=' +
            widget.category +
            '&page=' +
            page.toString() +
            '&orientation=' +
            orientation +
            '&color=' +
            color);

    if (response.statusCode == 200) {
      setState(() {
        var temp = json.decode(response.body);
        if (!refresh) {
          albumData.addAll(temp['results']);
        } else {
          albumData = temp['results'];
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
    _getSearchSettings();
    _controller = ScrollController();
    _controller.addListener(_scrollListner);
  }

  _getSearchSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    orientation = prefs.getString('orientation');
    color = prefs.getString('color');
    quality = prefs.getString('quality');
    fetchAlbum(cur_page, true, orientation, color);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Back',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Text(
                  widget.category[0].toUpperCase() +
                      widget.category.substring(1),
                  style: TextStyle(color: Colors.white, fontSize: 40),
                  textAlign: TextAlign.left,
                ),
                Spacer(),
              ],
            ),
          ),
          Expanded(
            child: _addAlbum(),
          )
        ],
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
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ImagePreviewScreen(
                      imgPath: item['urls']['regular'],
                      userInfo: item['user']['links']['self'],
                      likes: item['likes'],
                      likedByUser: item['liked_by_user'],
                      description: item['description'] != null
                          ? item['description']
                          : item['alt_description'],
                    ),
                  ),
                );
              },
              child: Image.network(item['urls']['thumb']),
            ),
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
