import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/constant/method.dart';
import 'package:ppob/core/model/request_trx.dart';
import 'package:ppob/core/utilities/crypto_auth_hash.dart';
import 'package:ppob/core/utils.dart';

import 'login_datasource.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield LoginLoadingState();
    if (event is LoginUserRequestEvent) {
      yield* loginRequest(event);
    }
  }

  Stream<LoginState> loginRequest(LoginUserRequestEvent event) async* {
    try {
      final passwordMd5 = md5
          .convert(utf8.encode(event.pass ?? ""))
          .toString(); // convert password to md5
      Encrypted? encrypted = CryptoAuthHash().encryptRSA(passwordMd5);
      final pinBlock = encrypted?.base64 ?? "";

      print("encryp = $pinBlock");

      var map = {
        "cid": "002",
        "username": event.user ?? "",
        "method": RequestMethod.LOGIN,
        "pin": pinBlock,
        "serialNo": "6f0398d1387b7377",
        "traceNo": "5346"
      };

      String data = payloadEncrypt(
          dataToEncrypt: jsonEncode(map),
          method: RequestMethod.LOGIN,
          secretkey: "a8eeea6c3c839d8b96a8a1a43a13e5c3");

      RequestTrx requestTrx =
          RequestTrx(method: RequestMethod.LOGIN, data: data);
      var results = await GetIt.I<LoginImpl>().login(jsonEncode(requestTrx));
      if (results.status == "00") {
        yield LoginSuccessState(baseResponse: results);
      } else {
        yield LoginFailedState(message: results.description);
      }
    } catch (e) {
      yield LoginFailedState(message: e.toString());
    }
  }
}
