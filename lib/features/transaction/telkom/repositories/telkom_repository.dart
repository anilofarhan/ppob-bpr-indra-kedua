import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/telkom/bloc/telkom_bloc.dart';

abstract class TelkomRepository {
  Future<BaseResponse<List<TransactionResponseModel>>> inquiryTelkom(InquiryTelkomEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> paymentTelkom(PaymentTelkomEvent event);
}
