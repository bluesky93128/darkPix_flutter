import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchSettingsPage extends StatefulWidget {
  @override
  _SearchSettingsPageState createState() => _SearchSettingsPageState();
}

class _SearchSettingsPageState extends State<SearchSettingsPage> {
  var _orientationValue;
  var _qualityValue;
  var _availableColors = [
    'black_and_white',
    'black',
    'white',
    'yellow',
    'orange',
    'red',
    'purple',
    'magenta',
    'green',
    'teal',
    'blue'
  ];
  var _colorIcons = [
    Colors.black,
    Colors.black,
    Colors.white,
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Color.fromARGB(255, 255, 0, 255),
    Colors.green,
    Colors.teal,
    Colors.blue
  ];
  String curColor;

  @override
  void initState() {
    // TODO: implement initState
    _getSearchSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.close), onPressed: () {
          Navigator.of(context).pop();
        }),
        actions: <Widget>[
          RaisedButton(
            color: Colors.transparent,
            onPressed: () {
              _setSearchSettings();
              Navigator.of(context).pop();
            },
            child: Text(
              'Apply',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _orientationRadios(),
          _colorsRadios(),
          _qualityRadios()
        ],
      ),
    );
  }

  _setSearchSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('orientation', _orientationValue);
    await prefs.setString('color', curColor);
    await prefs.setString('quality', _qualityValue);
  }

  _getSearchSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _orientationValue = prefs.getString('orientation');
      curColor = prefs.getString('color');
      _qualityValue = prefs.getString('quality');
    });
  }

  _handleOrientationChange(String value) {
    setState(() {
      _orientationValue = value;
      
    });
  }

  _handleQualityChange(String value) {
    setState(() {
      _qualityValue = value;
    });
  }

  _orientationRadios() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Orientation',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.left,
            ),
            Spacer(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'squarish',
                  groupValue: _orientationValue,
                  onChanged: _handleOrientationChange,
                ),
                Text(
                  'Any',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'landscape',
                  groupValue: _orientationValue,
                  onChanged: _handleOrientationChange,
                ),
                Text(
                  'Landscape',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'portrait',
                  groupValue: _orientationValue,
                  onChanged: _handleOrientationChange,
                ),
                Text(
                  'Portrait',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  _colorsRadios() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Colors',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.left,
            ),
            Spacer(),
          ],
        ),
        Wrap(
          children: _availableColors.asMap().entries.map((e) {
            int idx = e.key;

            return Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: 30,
                height: 30,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      curColor = e.value;
                    });
                  },
                ),
                decoration: BoxDecoration(
                    color: _colorIcons[idx],
                    border: curColor == e.value
                        ? Border.all(width: 2, color: Colors.red)
                        : Border.all(width: 1, color: Colors.white)),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  _qualityRadios() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              'Quality',
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.left,
            ),
            Spacer(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'low',
                  groupValue: _qualityValue,
                  onChanged: _handleQualityChange,
                ),
                Text(
                  'Low',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'medium',
                  groupValue: _qualityValue,
                  onChanged: _handleQualityChange,
                ),
                Text(
                  'Medium',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'high',
                  groupValue: _qualityValue,
                  onChanged: _handleQualityChange,
                ),
                Text(
                  'High',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
