import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 5),
        child: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            fillColor: Colors.white24,
            filled: true,
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white,),
            suffixIcon: Icon(Icons.dns, color: Colors.white),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white70)
          ),
          autofocus: false,
        ),
      ),
    );
  }
}
