import 'package:flutter/material.dart';

class ChangeNotifierCounter extends ChangeNotifier {
  var _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
