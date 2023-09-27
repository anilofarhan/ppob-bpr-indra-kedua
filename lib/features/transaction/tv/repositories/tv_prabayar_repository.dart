import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/tv/bloc/tv_berbayar_event.dart';

abstract class TvPrabayarRepository {
  Future<BaseResponse<List<TransactionResponseModel>>> postInquiryTvPrabayar(
      InquiryTvEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> postPaymentTvPrabayar(
      PaymentTvEvent event);
}
