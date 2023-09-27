import 'package:ppob/core/bloc/bloc_event.dart';

class PdamProductsBlocEvent extends BlocEvent {
  String? product;

  PdamProductsBlocEvent({required this.product});
}

class InquiryPdamEvent extends BlocEvent {
  String? noPelanggan;
  String? pdamCode;

  InquiryPdamEvent({required this.noPelanggan, required this.pdamCode});
}

class PaymentPdamEvent extends BlocEvent {
  String? noPelanggan;
  String? pdamCode;
  String? pin;

  PaymentPdamEvent(
      {required this.noPelanggan, required this.pdamCode, required this.pin});
}
