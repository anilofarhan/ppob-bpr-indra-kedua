import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String dateFotmat({String? pattern}) {
    var dateFormat = DateFormat(pattern ?? "yyyy-MM-dd HH:mm:ss").format(this);
    return dateFormat;
  }
}

extension NumericExt on double {
  String currencyFormat() {
    var numFormat = NumberFormat("#,###,###", "in_ID").format(this);
    return "Rp$numFormat";
  }

  String currencyFormat2() {
    var numFormat = NumberFormat("#,###,###", "in_ID").format(this);
    return "Rp.$numFormat";
  }

  String noDotFormat() {
    var numFormat = NumberFormat("#######", "in_ID").format(this);
    return numFormat;
  }
}

extension StringExt on String {
  String currencyFormat() {
    var numFormat = NumberFormat("#,###,###", "in_ID").format(double.parse(replaceAll("\$", "").replaceAll("'", "")));
    return numFormat;
  }

  DateTime toDateTime() {
    String d = substring(0, 2);
    String m = substring(2, 4);
    String y = substring(4, 6);
    String j = substring(6, 8);
    String n = substring(8, 10);
    String s = substring(10, 12);
    String res = "$y-$m-$d $j:$n:$s";
    return DateFormat('yy-MM-dd HH:mm:ss').parse(res);
  }

  String formatDateTime12() {
    String d = substring(0, 2);
    String m = substring(2, 4);
    String y = substring(4, 6);
    String j = substring(6, 8);
    String n = substring(8, 10);
    String s = substring(10, 12);
    String res = "$d-$m-$y $j:$n:$s";
    DateTime date = DateFormat('yy-MM-dd HH:mm:ss').parse(res);
    final f = DateFormat('dd/MM/yyyy HH:mm:ss', 'id');
    return f.format(date);
  }

  String formatDateTime12String() {
    String d = substring(0, 2);
    String m = substring(2, 4);
    String y = substring(4, 6);
    String j = substring(6, 8);
    String n = substring(8, 10);
    String s = substring(10, 12);
    String res = "$d-$m-$y $j:$n:$s";
    return res;
  }

  String formatDateTime12String2() {
    String d = substring(0, 2);
    String m = substring(2, 4);
    String y = substring(4, 6);
    String j = substring(6, 8);
    String n = substring(8, 10);
    String s = substring(10, 12);
    String res = "$d-$m-$y $j:$n:$s";
    return res;
  }

  String get replaceToRp => replaceAll("_", "\n").replaceAll("\$", "Rp ").replaceAll("'", "Rp");

  String formatDouble() {
    String value = this;
    int val = int.parse(value.replaceAll("\$", "").replaceAll("'", ""));
    var numFormat = NumberFormat.currency(locale: "id_ID", symbol: "", decimalDigits: 0).format(val);
    return numFormat;
  }
}

extension IntExt on int {
  String currencyFormat() {
    var numFormat = NumberFormat("#,###,###", "in_ID").format(this);
    return numFormat;
  }
}
