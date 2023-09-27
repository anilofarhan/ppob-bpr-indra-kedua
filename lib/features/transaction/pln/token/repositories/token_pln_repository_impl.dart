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
import 'package:ppob/features/transaction/pln/token/bloc/token_pln_bloc.dart';
import 'package:ppob/features/transaction/pln/token/model/harga_token_model.dart';
import 'package:ppob/features/transaction/pln/token/repositories/token_pln_repository.dart';
import 'package:ppob/ppob_module.dart';

class TokenPlnRepositoryImpl extends TokenPlnRepository {
  @override
  Future<BaseResponse<List<HargaTokenModel>>> getHargaTokenPln(HargaTokenPlnEvent event) async {
    var map = {
      "reg_no": event.regNo,
      "cif": event.cif,
      // "cid": event.cid,
      "provider": event.provider,
      "method": RequestMethod.GET_HARGA_PUBLIC,
      "traceNo": await TraceNoUtils.getTraceNo(),
      "serialNo": Constants.SERIAL_NO
    };

    String data = payloadEncrypt(
      dataToEncrypt: jsonEncode(map),
      method: RequestMethod.GET_HARGA_PUBLIC,
    );

    var request = RequestTrx(method: RequestMethod.GET_HARGA_PUBLIC, data: data);

    return handleResponse(
      request: () async => await dio.post("/edx/cs/general", data: request),
      onSuccess: (result) {
        if (result.data["status"] == Constants.RC_SUKSES) {
          var decrypt = CryptoHash.parseData(
            result.data["data"],
            RequestMethod.GET_HARGA_PUBLIC,
            GetIt.I<PPOBBuildConfig>().secretKey,
          );

          return BaseResponse<List<HargaTokenModel>>.fromJson(
            jsonDecode(decrypt!),
            (json) => List<HargaTokenModel>.from(
              (json as Iterable).map((model) => HargaTokenModel.fromJson(model)),
            ),
          );
        }
        return BaseResponse(description: result.data["description"], status: result.data["status"]);
      },
    );
  }

  @override
  Future<BaseResponse<List<TransactionResponseModel>>> postPaymentTokenPln(PaymentTokenPlnEvent event) async {
    var map = {
      "method": RequestMethod.TRANSACTION,
      "processing_code": event.procCode,
      "reg_no": Constants.NO_REKENING,
      "cif": event.cif,
      "cid": event.cid,
      "traceNo": await TraceNoUtils.getTraceNo(),
      "serialNo": Constants.SERIAL_NO,
      "product": Constants.PLN,
      "billing_code": event.billCode,
      "amount": event.nominal,
      "trxdatetime": DateTime.now().dateFotmat()
    };

    if (event.procCode == ProccesingCode.TRX_PLN_PREPAID_PAY) {
      map["pinTransaksi"] = event.pin;
    }

    String data = payloadEncrypt(dataToEncrypt: jsonEncode(map), method: RequestMethod.TRANSACTION);

    var request = RequestTrx(method: RequestMethod.TRANSACTION, data: data);

    return handleResponse(
      request: () async => await dio.post("/edx/cs/general", data: request),
      onSuccess: (result) {
        if (result.data["status"] == Constants.RC_SUKSES) {
          var decrypt = CryptoHash.parseData(result.data["data"], RequestMethod.TRANSACTION, GetIt.I<PPOBBuildConfig>().secretKey);

          return BaseResponse<List<TransactionResponseModel>>.fromJson(
              jsonDecode(decrypt!), (json) => List<TransactionResponseModel>.from((json as Iterable).map((model) => TransactionResponseModel.fromJson(model))));
        }
        return BaseResponse(description: result.data["description"], status: result.data["status"]);
      },
    );
  }
}
