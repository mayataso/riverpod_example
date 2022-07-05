import 'package:hooks_riverpod/hooks_riverpod.dart';

final futureProvider = FutureProvider<String>((ref) {
  return Future.delayed(const Duration(seconds: 5), () => 'done');
});
