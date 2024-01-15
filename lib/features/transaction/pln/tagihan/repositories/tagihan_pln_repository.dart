import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pln/tagihan/bloc/tagihan_pln_bloc.dart';

abstract class TagihanPlnRepository {
  Future<BaseResponse<List<TransactionResponseModel>>> inquiryTagihanPln(InquiryTagihanPlnEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> paymentTagihanPln(PaymentTagihanPlnEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> inquiryPlnNonTaglis(InquiryPlnNontaglisEvent event);
  Future<BaseResponse<List<TransactionResponseModel>>> paymentPlnNonTaglis(PaymentPlnNontaglisEvent event);
}
