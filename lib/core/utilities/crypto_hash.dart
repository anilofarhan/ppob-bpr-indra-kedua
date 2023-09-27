import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

class CryptoHash {
  static String getTime() {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    return time.substring(0, math.min(time.length, 10));
  }

  static String hashData(String jsonData, String cid, String secret) {
    StringBuffer sb = StringBuffer(getTime());
    String strrevtime = sb.toString().split('').reversed.join();
    String hash = doubleEncrypt(strrevtime + "." + jsonData, cid, secret);
    return hash.replaceAll("\n", "");
  }

  static String doubleEncrypt(String string, String cid, String secret) {
    Uint8List result = Uint8List(string.length);
    result = encrypt(utf8.encoder.convert(string), cid);
    result = encrypt(result, secret);

    String base64 = base64Encode(result);
    String rtrm = base64.replaceAll(RegExp(r"[=]"), "");

    return rtrm.replaceAll('+', '-').replaceAll('/', '_');
  }

  static Uint8List encrypt(Uint8List str, String key) {
    int x = str.length;
    Uint8List result = Uint8List(x);

    for (int i = 0; i < x; i++) {
      var chr = str[i];
      var keychr = key[(i + key.length - 1) % key.length];
      chr = ((chr + keychr.codeUnitAt(0)) % 128);
      result[i] = chr;
    }
    return result;
  }

  static bool tsDiff(int ts) {
    if ((ts - int.parse(getTime()).abs()) <= 300) {
      return true;
    }
    return false;
  }

  static List splitMax(String string, String separator, {int max = 0}) {
    var result = [];

    if (separator.isEmpty) {
      result.add(string);
      return result;
    }

    while (true) {
      var index = string.indexOf(separator, 0);
      if (index == -1 || (max > 0 && result.length >= max)) {
        result.add(string);
        break;
      }

      result.add(string.substring(0, index));
      string = string.substring(index + separator.length);
    }

    return result;
  }

  static String? parseData(String hash, String cid, String secret) {
    String parsedString = doubleDecrypt(hash, cid, secret);
    List arr = splitMax(parsedString, ".", max: 1);

    if (arr.length == 2) {
      StringBuffer sb = StringBuffer(arr[0]);
      String strrevtime = sb.toString().split('').reversed.join();
      int _time = int.parse(strrevtime);

      if (tsDiff(_time)) {
        return arr[1];
      }
    }
    return null;
  }

  static String doubleDecrypt(String string, String cid, String secret) {
    int ceils = (string.length / 4.0).ceil() * 4;
    while (string.length < ceils) {
      string = string + "=";
    }
    string = string.replaceAll('-', '+').replaceAll('_', '/');

    Uint8List result = base64.decode(string);
    result = decrypt(result, cid);
    result = decrypt(result, secret);
    return String.fromCharCodes(result);
  }

  static Uint8List decrypt(Uint8List str, String key) {
    int x = str.length;
    Uint8List result = Uint8List(x);

    for (int i = 0; i < x; i++) {
      var chr = str[i];
      var keychr = key[(i + key.length - 1) % key.length];
      chr = ((chr - keychr.codeUnitAt(0) + 128) % 128);
      result[i] = chr;
    }
    return result;
  }
}
