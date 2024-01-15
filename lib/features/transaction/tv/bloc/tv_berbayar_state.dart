import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';

class InquiryTvSuccessState extends BlocState {
  TransactionResponseModel data;

  InquiryTvSuccessState(this.data);
}

class PaymentTvSuccessState extends BlocState {
  TransactionResponseModel data;

  PaymentTvSuccessState(this.data);
}
