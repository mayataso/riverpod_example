import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// autoDisposeを使うと、Widgetからの購読が無くなったタイミングでdisposeしてくれる。
// その場合、Test時に注意が必要。下記参照
// https://zenn.dev/omtians9425/articles/4a74f982788bdb
final stateNotifierProvider = StateNotifierProvider.autoDispose(
  (ref) => StateNotifierCounter(),
);

class StateNotifierCounter extends StateNotifier<int> {
  StateNotifierCounter() : super(0);

  void increment() {
    state = state + 1;
  }
}
