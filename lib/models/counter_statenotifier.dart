import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateNotifierCounter extends StateNotifier<int> {
  StateNotifierCounter() : super(0);

  void increment() {
    state = state + 1;
  }
}
