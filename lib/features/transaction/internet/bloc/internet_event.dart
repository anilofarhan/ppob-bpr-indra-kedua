part of 'internet_bloc.dart';


abstract class InternetEvent extends BlocEvent {}

class InquiryInternetEvent extends InternetEvent {
  final String? billCode;
  final String? produk;

  InquiryInternetEvent({required this.billCode, required this.produk});
}

class PaymentInternetEvent extends InternetEvent {
  final String? billCode;
  final String? produk;
  final String? pin;

  PaymentInternetEvent({required this.billCode, required this.produk, required this.pin});
}
