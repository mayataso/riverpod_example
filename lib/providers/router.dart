import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_sample/pages/counters.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const CountersPage(),
      ),
    ],
    redirect: (state) {
      // logger.info('router: redirect, error = ${state.error}');
      return null;
      // リダイレクト処理 (未ログイン時、強制的にログイン画面に遷移等)
    },
    // 監視するProvider
    // refreshListenable: ref.watch(loginProvider),
    // エラー時に遷移するページについて定義
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
  ),
);
