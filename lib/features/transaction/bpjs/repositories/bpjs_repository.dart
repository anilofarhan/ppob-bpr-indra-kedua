import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/bpjs/bloc/bpjs_bloc.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';

abstract class BPJSRepository {
  Future<BaseResponse<List<TransactionResponseModel>>> postInquiryBPJS(InquiryBPJSEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> postPaymentBPJS(PaymentBPJSEvent event);
}
