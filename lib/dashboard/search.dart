import 'package:flutter/material.dart';
import 'package:random_words/random_words.dart';

class SearchPage extends StatelessWidget {
  var tags = generateNoun().take(5);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(tags);
    return Column(children: <Widget>[
      _searchBox(),
      _trendingTags(),
    ]);
  }

  _searchBox() {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: TextField(
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
          suffixIcon: Icon(Icons.dns, color: Colors.white),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        autofocus: false,
      ),
    );
  }

  _trendingTags() {
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
            children: tags.map((e) {
              return ButtonTheme(
                minWidth: 10,
                buttonColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 3, right: 3),
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      e.toString(),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
