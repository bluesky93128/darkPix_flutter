import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:darkPix/dashboard/preview.dart';

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

  _scrollListner() {
    if (_controller.position.atEdge) {
      if (_controller.position.pixels == 0) {
      } else {
        setState(() {
          cur_page = cur_page + 1;
          fetchAlbum(cur_page, false);
        });
      }
    }
  }

  void fetchAlbum(page, refresh) async {
    final response = await http.get(
        'https://api.unsplash.com/photos/random?client_id=zu8gZp8_xoBcEwA2Mxg-s6Ky4ghDtrYeBUpyNm_KXC0&count=30&query=' +
            widget.category +
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
    fetchAlbum(cur_page, true);
    _controller = ScrollController();
    _controller.addListener(_scrollListner);
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
