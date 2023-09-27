part of 'tagihan_pln_bloc.dart';

abstract class TagihanPlnEvent extends BlocEvent {}

class InquiryTagihanPlnEvent extends TagihanPlnEvent {
  final String? billCode;

  InquiryTagihanPlnEvent({required this.billCode});
}

class PaymentTagihanPlnEvent extends TagihanPlnEvent {
  final String? billCode;
  final String? pin;

  PaymentTagihanPlnEvent({required this.billCode, required this.pin});
}

class InquiryPlnNontaglisEvent extends TagihanPlnEvent {
  final String? billCode;

  InquiryPlnNontaglisEvent({required this.billCode});
}

class PaymentPlnNontaglisEvent extends TagihanPlnEvent {
  final String? billCode;
  final String? pin;

  PaymentPlnNontaglisEvent({required this.billCode, required this.pin});
}
