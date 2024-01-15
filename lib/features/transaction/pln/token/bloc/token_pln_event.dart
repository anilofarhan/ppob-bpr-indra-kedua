part of 'token_pln_bloc.dart';

class HargaTokenPlnEvent extends BlocEvent {
  final String? provider;

  HargaTokenPlnEvent({required this.provider});
}

class PaymentTokenPlnEvent extends BlocEvent {
  final String? procCode;
  final String? billCode;
  final String? nominal;
  final String? pin;

  PaymentTokenPlnEvent({required this.procCode, required this.billCode, required this.nominal, required this.pin});
}
