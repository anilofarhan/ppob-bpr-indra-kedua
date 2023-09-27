import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:ppob/core/base/build_config.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/core/constant/method.dart';
import 'package:ppob/core/constant/proccesing_code.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/core/httpclient/handler_response.dart';
import 'package:ppob/core/model/request_trx.dart';
import 'package:ppob/core/model/response.dart';
import 'package:ppob/core/utilities/crypto_hash.dart';
import 'package:ppob/core/utilities/trace_number.dart';
import 'package:ppob/core/utils.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/bloc/pulsa_prabayar_event.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/model/harga_pulsa_model.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/repositories/pulsa_prabayar_repository.dart';
import 'package:ppob/ppob_module.dart';

class PulsaPrabayarRepositoryImpl extends PulsaPrabayarRepository {
  @override
  Future<BaseResponse<List<HargaPulsaModel>>> getHargaPulsaPublic(
      HargaPulsaPublicEvent event) async {

    print("masuk getHargaPulsaPublic");

    var map = {
      "reg_no": Constants.NO_REKENING,
      "cif": event.cif,
      "cid": "002",
      "traceNo": await TraceNoUtils.getTraceNo(),
      "serialNo": Constants.SERIAL_NO,
      "provider": event.provider,
      "method": RequestMethod.GET_HARGA_PUBLIC
    };

    String data = payloadEncrypt(
        dataToEncrypt: jsonEncode(map), method: RequestMethod.GET_HARGA_PUBLIC);

    var request =
        RequestTrx(method: RequestMethod.GET_HARGA_PUBLIC, data: data);

    return handleResponse(
      request: () async => await dio.post("/edx/cs/general", data: request),
      onSuccess: (result) {
        if (result.data["status"] == Constants.RC_SUKSES) {
          var decrypt = CryptoHash.parseData(
              result.data["data"],
              RequestMethod.GET_HARGA_PUBLIC,
              GetIt.I<PPOBBuildConfig>().secretKey);

          return BaseResponse<List<HargaPulsaModel>>.fromJson(
              jsonDecode(decrypt!),
              (json) => List<HargaPulsaModel>.from((json as Iterable)
                  .map((model) => HargaPulsaModel.fromJson(model))));
        }
        print("response data "+result.data["description"].toString());
        return BaseResponse(
            description: result.data["description"],
            status: result.data["status"]);
      },
    );
  }

  @override
  Future<BaseResponse<List<TransactionResponseModel>>> postPaymentPulsaPrabayar(
      PaymentPulsaPrabayarEvent event) async {
    var map = {
      "method": RequestMethod.TRANSACTION,
      "processing_code": ProccesingCode.TRX_PULSA_PREPAID,
      "reg_no": Constants.NO_REKENING,
      "pinTransaksi": event.pin,
      "cif": event.cif,
      "cid": "002",
      "traceNo": await TraceNoUtils.getTraceNo(),
      "serialNo": Constants.SERIAL_NO,
      "product": event.product,
      "billing_code": event.noHp,
      "amount": event.nominal,
      "trxdatetime": DateTime.now().dateFotmat()
    };

    print("request data ${jsonEncode(map)}");

    String data = payloadEncrypt(
        dataToEncrypt: jsonEncode(map), method: RequestMethod.TRANSACTION);

    var request = RequestTrx(method: RequestMethod.TRANSACTION, data: data);

    return handleResponse(
      request: () async => await dio.post("/edx/cs/general", data: request),
      onSuccess: (result) {
        if (result.data["status"] == Constants.RC_SUKSES) {
          var decrypt = CryptoHash.parseData(result.data["data"],
              RequestMethod.TRANSACTION, GetIt.I<PPOBBuildConfig>().secretKey);

          return BaseResponse<List<TransactionResponseModel>>.fromJson(
              jsonDecode(decrypt!),
              (json) => List<TransactionResponseModel>.from((json as Iterable)
                  .map((model) => TransactionResponseModel.fromJson(model))));
        }
        return BaseResponse(
            description: result.data["description"],
            status: result.data["status"]);
      },
    );
  }
}
