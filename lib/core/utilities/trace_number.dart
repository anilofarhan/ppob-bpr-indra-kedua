import 'dart:math';

import 'package:hive/hive.dart';

class TraceNoUtils {
  static Future<String> getTraceNo() async {
    // int no = 1;
    //
    // final value = await readDataBox(
    //     boxName: Constants.BOX_NAME,
    //     boxKey: Constants.TRACE_NO,
    //     defaultValue: 0);
    //
    // if (value != 0) {
    //   if (value != 999999) {
    //     no = value + 1;
    //   }
    // }
    //
    // bool isSaved = await saveDataBox(
    //     boxName: Constants.BOX_NAME, boxKey: Constants.TRACE_NO, data: no);
    //
    // String nom = "";
    // if (no <= 9) {
    //   nom = "00000$no";
    // } else if (no > 9 && no < 100) {
    //   nom = "0000$no";
    // } else if (no >= 100 && no < 1000) {
    //   nom = "000$no";
    // } else if (no >= 1000 && no < 10000) {
    //   nom = "00$no";
    // } else if (no >= 10000 && no < 100000) {
    //   nom = "0$no";
    // } else {
    //   nom = "$no";
    // }
    //
    // if (isSaved) {
    //   print("${Constants.TRACE_NO}: $nom [SAVED]");
    // } else {
    //   print("${Constants.TRACE_NO}: $nom [FAILED]");
    // }

    var random = Random();

// generate a random integer from 0 to 899, then add 100
    int x = random.nextInt(90000) + 10000;

    return x.toString();

    // return nom;
  }

  static Future<bool> saveDataBox(
      {required String boxName, required String boxKey, dynamic data}) async {
    final box = await Hive.openBox(boxName);
    await box.put(boxKey, data);

    dynamic dataSaved = box.get(boxKey, defaultValue: null);
    if (dataSaved == data) {
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> readDataBox(
      {required String boxName,
      required String boxKey,
      dynamic defaultValue}) async {
    final box = await Hive.openBox(boxName);
    var data = await box.get(boxKey, defaultValue: defaultValue);

    if (data != null) {
      return data;
    } else {
      return null;
    }
  }
}
