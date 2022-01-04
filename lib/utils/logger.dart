import 'package:simple_logger/simple_logger.dart';

final SimpleLogger logger = SimpleLogger()
  ..setLevel(
    Level.ALL,
    includeCallerInfo: true,
  );
  // ..onLogged = (log, info) {
  //   if (info.level >= Level.WARNING) {
  //     // Crashlyticsにエラーを送る。
  //     FirebaseCrashlytics.instance.log(log);
  //   }
  // };
