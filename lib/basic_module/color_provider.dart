import 'package:flutter/material.dart';

List colorList = [
  Colors.pink,
  Colors.lime,
  Colors.purple,
  Colors.blue,
  Colors.greenAccent,
  Colors.red,
  Colors.amber,
  Colors.lightGreen,
  Colors.deepPurple,
  Colors.tealAccent,
];

class ColorProvider extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void setIndex(int value) {
    _index = value;
    notifyListeners();
  }
}
