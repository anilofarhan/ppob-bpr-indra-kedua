import 'package:ppob/core/model/response.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/bloc/pulsa_prabayar_event.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/model/harga_pulsa_model.dart';

abstract class PulsaPrabayarRepository {
  Future<BaseResponse<List<HargaPulsaModel>>> getHargaPulsaPublic(
      HargaPulsaPublicEvent event);

  Future<BaseResponse<List<TransactionResponseModel>>> postPaymentPulsaPrabayar(
      PaymentPulsaPrabayarEvent event);
}
