import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/model/harga_pulsa_model.dart';

class InquiryPulsaPascabayarSuccessState extends BlocState {
  TransactionResponseModel data;

  InquiryPulsaPascabayarSuccessState(this.data);
}

class PaymentPulsaPascabayarSuccessState extends BlocState {
  TransactionResponseModel data;

  PaymentPulsaPascabayarSuccessState(this.data);
}
