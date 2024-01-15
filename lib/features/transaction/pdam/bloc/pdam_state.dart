import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pdam/model/pdam_products_model.dart';

class PdamProductsSuccessState extends BlocState {
  List<PdamProductsModel> datas;

  PdamProductsSuccessState(this.datas);
}

class InquiryPdamSuccessState extends BlocState {
  TransactionResponseModel data;

  InquiryPdamSuccessState(this.data);
}

class PaymentPdamSuccessState extends BlocState {
  TransactionResponseModel data;

  PaymentPdamSuccessState(this.data);
}
