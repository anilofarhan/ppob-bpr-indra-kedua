part of 'internet_bloc.dart';

class InquiryInternetSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  InquiryInternetSuccessState(this.data);
}

class PaymentInternetSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  PaymentInternetSuccessState(this.data);
}

class SessionExpiredState extends BlocState {
  final String? message;

  SessionExpiredState(this.message);
}

class PaymentShowLoadingState extends BlocState {}

class PaymentHideLoadingState extends BlocState {}
