import 'package:darkPix/dashboard/search_setting.dart';
import 'package:flutter/material.dart';
import 'package:random_words/random_words.dart';
import 'package:darkPix/dashboard/category_view.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List tags = generateNoun(maxSyllables: 4).take(15).toList();
  bool isTagsExpanded = false;
  String searchText = '';

  var category = [
    'animal',
    'architecture',
    'backgrounds',
    'beauty',
    'emotions',
    'food',
    'love',
    'natural'
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(tags);
    var width = MediaQuery.of(context).size.width;
    return Column(children: <Widget>[
      _searchBox(),
      _trendingTags(context),
      _category(width, context),
    ]);
  }

  _searchBox() {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: false,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              fillColor: Colors.white24,
              filled: true,
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.filter_list, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SearchSettingsPage()),
                  );
                },
              ),
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          suggestionsCallback: (pattern) async {
            return await _getSuggestions(pattern);
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion['word']),
            );
          },
          onSuggestionSelected: (suggestion) {
            onPressCategory(context, suggestion['word']);
          },
        ));
  }

  _trendingTags(context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Trending Tags',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.left,
              ),
              Spacer(),
            ],
          ),
          Wrap(
            children: tags.asMap().entries.map((e) {
              int idx = e.key;
              String val = e.value.toString();
              if (isTagsExpanded) {
                return ButtonTheme(
                  minWidth: 10,
                  buttonColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(left: 3, right: 3),
                    child: RaisedButton(
                      onPressed: () {
                        onPressCategory(context, val);
                      },
                      child: Text(
                        val,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                );
              } else {
                if (idx < 5) {
                  return ButtonTheme(
                    minWidth: 10,
                    buttonColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(left: 3, right: 3),
                      child: RaisedButton(
                        onPressed: () {
                          onPressCategory(context, val);
                        },
                        child: Text(
                          val,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  );
                } else if (idx == 5) {
                  return ButtonTheme(
                    minWidth: 10,
                    buttonColor: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 3, right: 3),
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            isTagsExpanded = true;
                          });
                        },
                        child: Text(
                          '10+',
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }
            }).toList(),
          ),
        ],
      ),
    );
  }

  _category(width, context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Category',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.left,
              ),
              Spacer(),
            ],
          ),
          Center(
            child: Wrap(
              children: category.map<Widget>((e) {
                return _categoryItem(e.toString(), width, context);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  _categoryItem(String asset, width, context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          onPressCategory(context, asset);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: width * 0.45,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        new AssetImage('lib/assets/img/cart-' + asset + '.png'),
                  ),
                ),
                // child: Image.asset(asset),
              ),
              Container(
                width: width * 0.45,
                height: 50,
                decoration: BoxDecoration(
                  // color: const Color(0xff7c94b6),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                width: width * 0.45,
                height: 50,
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
      ),
    );
  }

  _getSuggestions(pattern) async {
    final response =
        await http.get('https://api.datamuse.com/sug?s=' + pattern + '&max=3');

    if (response.statusCode == 200) {
      print('---------------------------------');
      print(pattern);
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }

  void onPressCategory(context, String asset) {
    Navigator.of(context).push(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              CategoryViewPage(
                category: asset,
              )),
    );
  }
}
