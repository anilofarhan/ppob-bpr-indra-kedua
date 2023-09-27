part of 'token_pln_bloc.dart';

class HargaTokenSuccessState extends BlocState {
  final List<HargaTokenModel> data;

  HargaTokenSuccessState(this.data);
}

class HargaNotFoundState extends BlocState {
  final String? message;

  HargaNotFoundState(this.message);
}

class InquiryTokenSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  InquiryTokenSuccessState(this.data);
}

class PaymentTokenSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  PaymentTokenSuccessState(this.data);
}

class PaymentTokenPlnShowLoadingState extends BlocState {}

class PaymentTokenPlnHideLoadingState extends BlocState {}
