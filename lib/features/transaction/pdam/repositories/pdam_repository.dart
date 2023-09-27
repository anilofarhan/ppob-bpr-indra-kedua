import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_event.dart';
import 'package:ppob/features/transaction/pdam/model/pdam_products_model.dart';

abstract class PdamRepository {
  Future<BaseResponse<List<PdamProductsModel>>> getPdamProducts(
      PdamProductsBlocEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> inquiryPdam(
      InquiryPdamEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> paymentPdam(
      PaymentPdamEvent event);
}
