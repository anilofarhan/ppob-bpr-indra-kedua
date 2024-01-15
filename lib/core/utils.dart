import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/core/utilities/crypto_auth_hash.dart';
import 'package:ppob/core/utilities/crypto_hash.dart';

import 'base/build_config.dart';

class Utils {}

height_5() {
  return SizedBox(
    height: 5.h,
  );
}

height_16() {
  return SizedBox(
    height: 16.h,
  );
}

height_7() {
  return SizedBox(
    height: 7.h,
  );
}

height_8() {
  return SizedBox(
    height: 8.h,
  );
}

height_10() {
  return SizedBox(
    height: 10.h,
  );
}

height_15() {
  return SizedBox(
    height: 15.h,
  );
}

height_20() {
  return SizedBox(
    height: 20.h,
  );
}

height_30() {
  return SizedBox(
    height: 30.h,
  );
}

height_40() {
  return SizedBox(
    height: 40.h,
  );
}

height_50() {
  return SizedBox(
    height: 50.h,
  );
}

width_10() {
  return SizedBox(
    width: 10.w,
  );
}

width_20() {
  return SizedBox(
    width: 20.w,
  );
}

width_30() {
  return SizedBox(
    width: 30.w,
  );
}

width_25() {
  return SizedBox(
    width: 25.w,
  );
}

width_15() {
  return SizedBox(
    width: 15.w,
  );
}

width_5() {
  return SizedBox(
    width: 5.w,
  );
}

String providerPulsaImg(String prefix) {
  switch (prefix) {
    case Constants.IM3:
      return Assets.im3;
    case Constants.MENTARI:
      return Assets.mentari;
    case Constants.SIMPATI:
      return Assets.simpati;
    case Constants.TRI:
      return Assets.tri;
    case Constants.AXIS:
      return Assets.axis;
    case Constants.XL:
      return Assets.xl;
    case Constants.AS:
      return Assets.kartu_as;
    case Constants.SMART:
      return Assets.smartfren;
  }

  return "";
}

String providerImg(String prefix) {
  switch (prefix) {
    case Constants.PLN:
      return Assets.ic_token_pln;
    case Constants.TELKOM:
      return Assets.ic_telkom;
    case Constants.BPJSKS:
      return Assets.ic_bpjs_kesehatan;
    case Constants.INTERNET:
      return Assets.ic_internet;
  }

  return "";
}

String md5rsaEncryption(String? data) {
  final passwordMd5 = md5.convert(utf8.encode(data ?? "")).toString(); // convert password to md5
  Encrypted? encrypted = CryptoAuthHash().encryptRSA(passwordMd5);
  final result = encrypted?.base64 ?? "";
  return result;
}

String rsaEncryption(String? dataMd5) {
Encrypted? encrypted = CryptoAuthHash().encryptRSA(dataMd5??"");
final result = encrypted?.base64 ?? "";
return result;
}

payloadEncrypt({required String method, required String dataToEncrypt, String? secretkey}) =>
    CryptoHash.hashData(dataToEncrypt, method, secretkey ?? GetIt.I<PPOBBuildConfig>().secretKey);
