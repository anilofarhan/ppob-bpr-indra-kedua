import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/httpclient/http_client.dart';

import 'core/base/build_config.dart';
import 'core/core_module.dart';
import 'features/transaction/transaction_module.dart';

late Dio dio;

class PPOBModule {
  static Future<void> init(
      {required PPOBBuildConfig Function() buildConfig}) async {
    bool b = GetIt.I.isRegistered<PPOBBuildConfig>();
    if (b) {
      GetIt.I.unregister<PPOBBuildConfig>();
    }
    GetIt.I.registerLazySingleton<PPOBBuildConfig>(() => buildConfig());
    dio = Dio().initClient(buildConfig());
    await _loadModules(b);
  }

  static Future<void> _loadModules(bool b) async {
    if (b) {
      return;
    }
    await CoreModule.init();
    TransactionModule.init();
  }
}
