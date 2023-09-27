import 'package:ppob/core/bloc/bloc_event.dart';

class InquiryMultifinanceEvent extends BlocEvent {
  String? noPelanggan;
  String? productCode;

  InquiryMultifinanceEvent(
      {required this.productCode, required this.noPelanggan});
}

class PaymentMultifinanceEvent extends BlocEvent {
  String? noPelanggan;
  String? productCode;
  String? pin;

  PaymentMultifinanceEvent(
      {required this.noPelanggan,
      required this.productCode,
      required this.pin});
}
