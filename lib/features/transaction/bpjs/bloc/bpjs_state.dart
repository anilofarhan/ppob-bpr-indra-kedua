part of 'bpjs_bloc.dart';

class InquiryBPJSSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  InquiryBPJSSuccessState(this.data);
}

class PaymentBPJSSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  PaymentBPJSSuccessState(this.data);
}

class SessionExpiredState extends BlocState {
  final String? message;

  SessionExpiredState(this.message);
}
