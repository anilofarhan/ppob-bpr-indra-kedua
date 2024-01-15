import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ppob/core/constant/method.dart';
import 'package:ppob/core/utilities/crypto_hash.dart';
import 'package:ppob/logintest/dio_module.dart';

import 'handler_response.dart';
import 'login_user_response.dart';

abstract class LoginDataSource {
  FutureOr<BaseLoginUserResponse> login(String data);
}

String _secretKey = "a8eeea6c3c839d8b96a8a1a43a13e5c3";

class LoginImpl extends LoginDataSource {
  @override
  FutureOr<BaseLoginUserResponse> login(String data) {
    return handleResponse(
        request: () async => await dio.post("edx/cs/general", data: data),
        onSuccess: (results) {
          print("results.data: " + results.data["description"]);
          if (results.data["data"] == null) {
            throw ErrorDescription(results.data["description"]);
          }
          String? decrypt = CryptoHash.parseData(
              results.data["data"], RequestMethod.LOGIN, _secretKey);
          print("results.data: " + decrypt!);
          return BaseLoginUserResponse.fromJson(jsonDecode(decrypt));
        });
  }
}
