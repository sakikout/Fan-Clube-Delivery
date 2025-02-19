import 'package:flutter/material.dart';
import 'package:flutter_application_1/themes/light_mode.dart';
import 'package:flutter_application_1/themes/dark_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = darkMode;
  bool _isDarkMode = false;

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;
  
   ThemeProvider() {
    _loadTheme();
  }

  set themeData (ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (_themeData == lightMode){
      themeData = darkMode;

    } else {
      themeData = lightMode;
    }

    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }
}