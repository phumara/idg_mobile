import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ThemeProvider extends ChangeNotifier {
  bool _dark = false;
  bool get dark => _dark;

  void toggleDark(){
    _dark = !_dark;
    notifyListeners();
  }
}

// class ThemeProvider extends ChangeNotifier {
//   bool _darkMode = false;
//   bool get isDarkMode => _darkMode;
  
//   set isDarkMode(bool value) {
//     _darkMode = value;
//     notifyListeners();
//   }
  
//   ThemeData get theme => _darkMode ? ThemeData.dark() : ThemeData.light();
// } 

