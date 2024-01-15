import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';

class InquiryMultifinanceSuccessState extends BlocState {
  TransactionResponseModel data;

  InquiryMultifinanceSuccessState(this.data);
}

class PaymentMultifinanceSuccessState extends BlocState {
  TransactionResponseModel data;

  PaymentMultifinanceSuccessState(this.data);
}
