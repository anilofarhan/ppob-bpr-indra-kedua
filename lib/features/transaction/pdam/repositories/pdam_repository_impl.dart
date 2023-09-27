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
import 'package:ppob/features/transaction/pdam/bloc/pdam_event.dart';
import 'package:ppob/features/transaction/pdam/model/pdam_products_model.dart';
import 'package:ppob/features/transaction/pdam/repositories/pdam_repository.dart';
import 'package:ppob/ppob_module.dart';

class PdamRepositoryImpl extends PdamRepository {
  @override
  Future<BaseResponse<List<PdamProductsModel>>> getPdamProducts(
      PdamProductsBlocEvent event) async {
    var map = {"method": ProccesingCode.GET_PDAM, "produk": event.product, "traceNo": await TraceNoUtils.getTraceNo(), "serialNo": Constants.SERIAL_NO};
    // print("traceno "+TraceNoUtils.getTraceNo()+" serial No "+Constants.SERIAL_NO);
    // print("test "+await TraceNoUtils.getTraceNo());
    String data = payloadEncrypt(
        dataToEncrypt: jsonEncode(map), method: ProccesingCode.GET_PDAM);

    var request = RequestTrx(method: ProccesingCode.GET_PDAM, data: data);

    return handleResponse(
      request: () async => await dio.post("/edx/cs/general", data: request),
      onSuccess: (result) {
        // print("dåat"+result.toString());
        if (result.data["status"] == Constants.RC_SUKSES ||
            result.data["status"] == Constants.RC_R00) {
          var decrypt = CryptoHash.parseData(result.data["data"],
              ProccesingCode.GET_PDAM, GetIt.I<PPOBBuildConfig>().secretKey);

          return BaseResponse<List<PdamProductsModel>>.fromJson(
              jsonDecode(decrypt!),
              (json) => List<PdamProductsModel>.from((json as Iterable)
                  .map((model) => PdamProductsModel.fromJson(model))));
        }
        return BaseResponse(
            description: result.data["description"],
            status: result.data["status"]);
      },
    );
  }

  @override
  Future<BaseResponse<List<TransactionResponseModel>>> inquiryPdam(
      InquiryPdamEvent event) async {
    var map = {
      "method": RequestMethod.TRANSACTION,
      "processing_code": ProccesingCode.TRX_PDAM_INQ,
      "reg_no": Constants.NO_REKENING,
      "cif": event.cif,
      "cid": event.cid,
      "traceNo": await TraceNoUtils.getTraceNo(),
      "serialNo": Constants.SERIAL_NO,
      "product": event.pdamCode,
      "billing_code": event.noPelanggan,
      "trxdatetime": DateTime.now().dateFotmat()
    };

    String data = payloadEncrypt(
        dataToEncrypt: jsonEncode(map), method: RequestMethod.TRANSACTION);

    var request = RequestTrx(method: RequestMethod.TRANSACTION, data: data);

    return handleResponse(
      request: () async => await dio.post("/edx/cs/general", data: request),
      onSuccess: (result) {
        print(result.data);
        if (result.data["status"] == Constants.RC_SUKSES ||
            result.data["status"] == Constants.RC_R00) {
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

  @override
  Future<BaseResponse<List<TransactionResponseModel>>> paymentPdam(
      PaymentPdamEvent event) async {
    var map = {
      "method": RequestMethod.TRANSACTION,
      "processing_code": ProccesingCode.TRX_PDAM_PAY,
      "reg_no": Constants.NO_REKENING,
      "cif": event.cif,
      "cid": event.cid,
      "traceNo": await TraceNoUtils.getTraceNo(),
      "serialNo": Constants.SERIAL_NO,
      "product": event.pdamCode,
      "billing_code": event.noPelanggan,
      "trxdatetime": DateTime.now().dateFotmat(),
      "pinTransaksi": event.pin,
    };

    String data = payloadEncrypt(
        dataToEncrypt: jsonEncode(map), method: RequestMethod.TRANSACTION);

    var request = RequestTrx(method: RequestMethod.TRANSACTION, data: data);

    return handleResponse(
      request: () async => await dio.post("/edx/cs/general", data: request),
      onSuccess: (result) {
        if (result.data["status"] == Constants.RC_SUKSES ||
            result.data["status"] == Constants.RC_R00) {
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
