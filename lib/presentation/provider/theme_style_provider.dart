import 'package:flutter/material.dart';

class ThemeStyleProvider extends ChangeNotifier {
  bool _isDark = true;

  bool get isDark => _isDark;

  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }
}
