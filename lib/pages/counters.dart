import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_sample/pages/counter_changenotifier.dart';
import 'package:riverpod_sample/pages/counter_statenotifier.dart';
import 'package:riverpod_sample/widgets/consumer_test_widget.dart';

final _futureProvider = FutureProvider<String>((ref) {
  return Future.delayed(const Duration(seconds: 5), () => 'done');
});
final _streamProvider = StreamProvider.autoDispose<int>((ref) async* {
  var count = 0;
  for (int i = 0; i < 100; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield count++;
  }
});

class CountersPage extends StatelessWidget {
  const CountersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Counters'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildChangeProviderTestArea(),
            const Gap(24),
            _buildStateProviderTestArea(),
            const Gap(24),
            _buildConsumerWidgetTestArea(),
            const Gap(24),
            _buildFutureProviderTestArea(),
            const Gap(24),
            _buildStreamProviderTestArea(),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  // Change Notifier
  _buildChangeProviderTestArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ChangeNotifierProvider Counter'),
            Consumer(builder: (context, ref, child) {
              // 従来のProvider watchと同様の動作
              return Text('${ref.watch(changeNotifierProvider).count}');
            }),
          ],
        ),
        Consumer(builder: (context, ref, child) {
          return FloatingActionButton(
            onPressed: () {
              // 従来のProvider readと同様の動作
              ref.read(changeNotifierProvider).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }),
      ],
    );
  }

  // State notifier
  _buildStateProviderTestArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('StateNotifierProvider Counter'),
            Consumer(builder: (context, ref, child) {
              // この方法だと1StateNotifierにつき1つのプロパティがバインドされる
              // freezedを使うと複数プロパティの管理もできる
              return Text('${ref.watch(stateNotifierProvider)}');
            }),
          ],
        ),
        Consumer(builder: (context, ref, child) {
          return FloatingActionButton(
            onPressed: () {
              // NotifierProvider.notifierをreadすることでメソッドにアクセスできる
              ref.read(stateNotifierProvider.notifier).increment();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          );
        }),
      ],
    );
  }

  // ConsumerWidgetをextendsした場合のProviderアクセス
  // 実装はシンプルになるが再レンダリング範囲が広範囲に及ぶため、パフォーマンス重視なら
  // Consumer Widgetを小さいスコープで定義していったほうが良さそう?
  _buildConsumerWidgetTestArea() {
    return ConsumerTestWidget();
  }

  // Future Provider
  // 非同期で値を得る場合に、状態を切り分けられて便利
  // FutureBuilder的なもの？
  _buildFutureProviderTestArea() {
    return Column(
      children: [
        const Text('FutureProvider Counter'),
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(_futureProvider).when(
                data: (data) => Text('get data -> $data.'),
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => const Text('Error!'));
          },
        ),
      ],
    );
  }

  // Stream Provider
  // Future Providerと大体同じ
  // 継続的な値の変化に対応できる。ポーリング処理にも使えそう？
  _buildStreamProviderTestArea() {
    return Column(
      children: [
        const Text('StreamProvider Counter'),
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(_streamProvider).when(
                data: (data) => Text('count = $data'),
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => const Text('Error!'));
          },
        ),
      ],
    );
  }
}
