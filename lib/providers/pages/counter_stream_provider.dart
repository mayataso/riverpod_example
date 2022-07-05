import 'package:hooks_riverpod/hooks_riverpod.dart';

final streamProvider = StreamProvider.autoDispose<int>((ref) async* {
  var count = 0;
  for (int i = 0; i < 100; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield count++;
  }
});
