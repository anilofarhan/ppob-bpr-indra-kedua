import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'http_dio_client.dart';
import 'login_datasource.dart';

late Dio dio;

class DioModule {
  static void init() async {
    GetIt.I.registerLazySingleton(() => HttpClientDio());
    GetIt.I.registerLazySingleton(() => LoginImpl());
    dio = await GetIt.I<HttpClientDio>().dioClient;
  }
}

class ConstantKeyHive {
  ///for Hive
  static const String KODE_AKSES_BOX = "KODE_AKSES_BOX";
  static const String KODE_AKES = "KODE_AKSES";

  static const String BUKA_REKENING_BOX = "BUKA_REKENING_BOX";
  static const String BUKA_REKENING = "BUKA_REKENING";
  // static const String JENIS_TABUNGAN = "JENIS_TABUNGAN";
  // static const String TUJUAN_PEMBUKAAN_REKENING = "TUJUAN_PEMBUKAAN_REKENING";
  // static const String PROFIL_NAMA_LENGKAP = "PROFIL_NAMA_LENGKAP";

  static const String LOGIN_USER_BOX = "LOGIN_USER_BOX";
  static const String LOGIN_USER = "LOGIN_USER_FIELD";

  static const String NOTIFICATION_BOX = "NOTIFICATION_BOX";
  static const String NOTIFICATION_ITEM = "NOTIFICATION_ITEM";

  static const String DATA_BOX = "DATA_BOX";
  static const String DATA_PROFILE_IMAGE = "DATA_PROFILE_IMAGE";
  static const String DATA_TERMINAL_ID = "DATA_TERMINAL_ID";
  static const String DATA_TRACE_NO = "DATA_TRACE_NO";
}
