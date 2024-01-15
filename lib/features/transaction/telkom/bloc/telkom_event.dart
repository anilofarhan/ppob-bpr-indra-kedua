part of 'telkom_bloc.dart';

abstract class TelkomEvent extends BlocEvent {}

class InquiryTelkomEvent extends TelkomEvent {
  final String? billCode;
  final String? produk;

  InquiryTelkomEvent({required this.billCode, required this.produk});
}

class PaymentTelkomEvent extends TelkomEvent {
  final String? billCode;
  final String? produk;
  final String? pin;

  PaymentTelkomEvent({required this.billCode, required this.produk, required this.pin});
}
