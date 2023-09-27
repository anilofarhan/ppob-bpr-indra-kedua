part of 'telkom_bloc.dart';

class InquiryTelkomSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  InquiryTelkomSuccessState(this.data);
}

class PaymentTelkomSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  PaymentTelkomSuccessState(this.data);
}

class SessionExpiredState extends BlocState {
  final String? message;

  SessionExpiredState(this.message);
}

class PaymentShowLoadingState extends BlocState {}

class PaymentHideLoadingState extends BlocState {}
