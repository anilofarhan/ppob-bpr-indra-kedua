part of 'tagihan_pln_bloc.dart';

class InquiryTagihanPlnSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  InquiryTagihanPlnSuccessState(this.data);
}

class PaymentTagihanPlnSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  PaymentTagihanPlnSuccessState(this.data);
}

class InquiryPlnNontaglisSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  InquiryPlnNontaglisSuccessState(this.data);
}

class PaymentPlnNontaglisSuccessState extends BlocState {
  final List<TransactionResponseModel> data;

  PaymentPlnNontaglisSuccessState(this.data);
}

class SessionExpiredState extends BlocState {
  final String? message;

  SessionExpiredState(this.message);
}

class PaymentShowLoadingState extends BlocState {}

class PaymentHideLoadingState extends BlocState {}
