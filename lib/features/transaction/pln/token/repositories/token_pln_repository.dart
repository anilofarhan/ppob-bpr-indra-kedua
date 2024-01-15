import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pln/token/bloc/token_pln_bloc.dart';
import 'package:ppob/features/transaction/pln/token/model/harga_token_model.dart';

abstract class TokenPlnRepository {
  Future<BaseResponse<List<HargaTokenModel>>> getHargaTokenPln(HargaTokenPlnEvent event);

  Future<BaseResponse<List<TransactionResponseModel>>> postPaymentTokenPln(PaymentTokenPlnEvent event);
}
