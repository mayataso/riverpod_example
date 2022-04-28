import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// RiverpodではグローバルにProvider宣言できる
final changeNotifierProvider = ChangeNotifierProvider(
  (ref) => ChangeNotifierCounter(),
);

class ChangeNotifierCounter extends ChangeNotifier {
  var _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}
