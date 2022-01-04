import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// hooks_riverpodでは、flutter_riverpod + Hooksが利用できる
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_sample/models/counter_changenotifier.dart';

final _provider = ChangeNotifierProvider(
  (ref) => ChangeNotifierCounter(),
);

class ConsumerTestWidget extends HookConsumerWidget {
  ConsumerTestWidget({Key? key}) : super(key: key);

  @override
  // extends ConsumerWidget のbuildはWidgetRefを引数に持つ
  Widget build(BuildContext context, WidgetRef ref) {
    // hooks_riverpodでは、flutter_hooksを併用することができる
    // ただRiverpod使ってるならHooksでState管理するケースはあまりない気がする
    final hooksCount = useState(0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ConsumerWidget Counter'),
            Text('Provider count: ${ref.watch(_provider).count}'),
            Text('Flutter hooks count: ${hooksCount.value}'),
          ],
        ),
        Consumer(builder: (context, ref, child) {
          return FloatingActionButton(
            onPressed: () {
              // Providerを用いたState変更
              ref.watch(_provider).increment();
              // Hooksを用いたState変更
              hooksCount.value++;
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }),
      ],
    );
  }
}
