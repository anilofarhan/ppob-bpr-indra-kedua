import 'package:dio/dio.dart';
import 'package:ppob/core/base/build_config.dart';

extension HttpClient on Dio {
  Dio initClient(PPOBBuildConfig buildConfig) {
    options.headers = {
      "content-type": "application/json",
      "SessionID": buildConfig.sessionId,
    };
    options.baseUrl = buildConfig.baseUrl;
    interceptors.add(LogInterceptor(
        requestHeader: buildConfig.debug,
        responseHeader: buildConfig.debug,
        requestBody: buildConfig.debug,
        responseBody: buildConfig.debug));
    return this;
  }
}
