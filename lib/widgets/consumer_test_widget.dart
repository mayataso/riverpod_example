import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sample/models/counter_changenotifier.dart';

final _provider = ChangeNotifierProvider(
  (ref) => ChangeNotifierCounter(),
);

class ConsumerTestWidget extends ConsumerWidget {
  const ConsumerTestWidget({Key? key}) : super(key: key);

  @override
  // extends ConsumerWidget のbuildはWidgetRefを引数に持つ
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ConsumerWidget Counter'),
            Text('${ref.watch(_provider).count}'),
          ],
        ),
        Consumer(builder: (context, ref, child) {
          return FloatingActionButton(
            onPressed: () {
              ref.watch(_provider).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }),
      ],
    );
  }
}
