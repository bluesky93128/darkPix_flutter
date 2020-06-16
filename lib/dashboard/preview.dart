import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImagePreviewScreen extends StatefulWidget {
  final String imgPath;
  final String userInfo;
  final int likes;
  final bool likedByUser;
  final String description;

  ImagePreviewScreen(
      {this.imgPath,
      this.userInfo,
      this.likes,
      this.likedByUser,
      this.description});

  @override
  _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  var userData;

  void fetchUserData(url) async {
    final response = await http
        .get(url + '?client_id=zu8gZp8_xoBcEwA2Mxg-s6Ky4ghDtrYeBUpyNm_KXC0');

    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData(widget.userInfo);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.share),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.cloud_download),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.more_vert),
          ),
        ],
        elevation: 10,
        title: Text(
          'Back',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(widget.imgPath),
        ),
      ),
      bottomSheet: SolidBottomSheet(
        maxHeight: 150,
        headerBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.black87,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white30),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
                child: userData != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      userData['profile_image']['small']),
                                ),
                              ),
                              Text(
                                userData['name'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  widget.likes.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    : null,
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.black87,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.description,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
