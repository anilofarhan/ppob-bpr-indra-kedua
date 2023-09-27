import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pbb/bloc/pbb_event.dart';
import 'package:ppob/features/transaction/pbb/model/pbb_products_model.dart';

abstract class PbbRepository {
  Future<BaseResponse<List<PbbProductsModel>>> getPbbProducts(
      PbbProductsBlocEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> inquiryPbb(
      InquiryPbbEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> paymentPbb(
      PaymentPbbEvent event);
}
