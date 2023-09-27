import 'package:ppob/core/bloc/bloc_event.dart';

class PbbProductsBlocEvent extends BlocEvent {
  String? product;

  PbbProductsBlocEvent({required this.product});
}

class InquiryPbbEvent extends BlocEvent {
  String? noPelanggan;
  String? pbbCode;

  InquiryPbbEvent({required this.noPelanggan, required this.pbbCode});
}

class PaymentPbbEvent extends BlocEvent {
  String? noPelanggan;
  String? pbbCode;
  String? pin;

  PaymentPbbEvent(
      {required this.noPelanggan, required this.pbbCode, required this.pin});
}
