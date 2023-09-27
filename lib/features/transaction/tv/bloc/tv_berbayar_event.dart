import 'package:ppob/core/bloc/bloc_event.dart';

class InquiryTvEvent extends BlocEvent {
  String? noPelanggan;
  String? productCode;

  InquiryTvEvent({required this.productCode, required this.noPelanggan});
}

class PaymentTvEvent extends BlocEvent {
  String? noPelanggan;
  String? productCode;
  String? pin;

  PaymentTvEvent(
      {required this.noPelanggan,
      required this.productCode,
      required this.pin});
}
