part of 'bpjs_bloc.dart';

abstract class BPJSEvent extends BlocEvent {}

class InquiryBPJSEvent extends BPJSEvent {
  final String? billCode;

  InquiryBPJSEvent({required this.billCode});
}

class PaymentBPJSEvent extends BPJSEvent {
  final String? billCode;
  final String? pin;

  PaymentBPJSEvent({required this.billCode, required this.pin});
}
