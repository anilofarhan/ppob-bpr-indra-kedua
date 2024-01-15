import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pbb/model/pbb_products_model.dart';

class PbbProductsSuccessState extends BlocState {
  List<PbbProductsModel> datas;

  PbbProductsSuccessState(this.datas);
}

class InquiryPbbSuccessState extends BlocState {
  TransactionResponseModel data;

  InquiryPbbSuccessState(this.data);
}

class PaymentPbbSuccessState extends BlocState {
  TransactionResponseModel data;

  PaymentPbbSuccessState(this.data);
}
