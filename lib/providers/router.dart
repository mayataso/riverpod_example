import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recase/recase.dart';
import 'package:riverpod_sample/pages/counters.dart';

final routerProvider = Provider((_) => _Router());

class _Router {
  final Map<String, WidgetBuilder> pushRoutes = {
    CountersPage.routeName: (_) => const CountersPage(),
  };

  Route onGenerateRoute(RouteSettings settings) {
    final pushPage = pushRoutes[settings.name]!;
    return MaterialPageRoute<void>(
      settings: settings,
      builder: pushPage,
    );
  }
}

String pascalCaseFromRouteName(String name) => name.substring(1).pascalCase;

@immutable
class PageInfo {
  PageInfo({
    required this.routeName,
    String? pageName,
    this.subTitle,
  }) : pageName = pageName ?? pascalCaseFromRouteName(routeName);

  final String routeName;
  final String pageName;
  final String? subTitle;

  static List<PageInfo> get all => [
        ...[
          CountersPage.routeName,
        ].map((rn) => PageInfo(routeName: rn)),
        PageInfo(
          routeName: CountersPage.routeName,
          pageName: 'Counters',
          subTitle: 'Update Selection',
        ),
      ];
}
