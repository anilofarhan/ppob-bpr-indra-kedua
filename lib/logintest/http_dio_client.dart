import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import 'dio_module.dart';
import 'login_user_entity.dart';

String _baseUrlDev = "http://online.bprindra.com:19012/";

class HttpClientDio {
  Dio get dioClient => _dio();
  Dio _dio() {
    final options = BaseOptions(
      baseUrl: _baseUrlDev,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    options.headers["content-type"] = "application/json";
    var dio = Dio(options);
    dio.interceptors.add(ApiInterceptors());
    return dio;
  }
}

class ApiInterceptors extends InterceptorsWrapper {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //logd("API_URI: ${options.uri.toString()}\nAPI_DATA: ${options.data.toString()}\nAPI_HEADER: ${options.headers.toString()}");
    return handler.next(options);
  }

  @override
  Future<dynamic> onError(DioError err, ErrorInterceptorHandler handler) async {
    //loge("API_Error:\n${err.toString()}\nERROR_DATA:\n${err.response?.data.toString()}");
    return handler.next(err);
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (response.data["status"] == "07") {
      //get_x.Get.offAllNamed(AppPagesName.LOGIN, predicate: (route) => false);
      // get_x.Get.offNamedUntil(AppPagesName.LOGIN, (route) => false);
    }
    return handler.next(response);
  }
}

class BPRHeaderSession {
  Future<Options?> sessionHeader() async {
    Box? box = await Hive.openBox(ConstantKeyHive.LOGIN_USER_BOX);
    LoginUserEntity? loginUserEntity =
        await box.get("", defaultValue: LoginUserEntity());
    return Options(headers: {"SessionID": loginUserEntity?.sessionId ?? ""});
  }
}
