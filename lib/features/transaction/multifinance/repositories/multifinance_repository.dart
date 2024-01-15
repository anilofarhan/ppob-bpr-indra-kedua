import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/multifinance/bloc/multifinance_event.dart';

abstract class MultifinanceRepository {
  Future<BaseResponse<List<TransactionResponseModel>>> postInquiryMultifinance(
      InquiryMultifinanceEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> postPaymentMultifinance(
      PaymentMultifinanceEvent event);
}
