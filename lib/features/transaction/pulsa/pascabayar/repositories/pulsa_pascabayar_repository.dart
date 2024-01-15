import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/bloc/pulsa_pascabayar_event.dart';

abstract class PulsaPascabayarRepository {
  Future<BaseResponse<List<TransactionResponseModel>>> inquiryPulsaPascabayar(
      InquiryPulsaPascabayarEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> paymentPulsaPascabayar(
      PaymentPulsaPascabayarEvent event);
}
