// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponseModel _$TransactionResponseModelFromJson(
    Map<String, dynamic> json) {
  return TransactionResponseModel(
    amount: json['amount'] as String?,
    billAmount: json['billAmount'] as int?,
    billingCode: json['billingCode'] as String?,
    customerData: json['customer_data'] as String?,
    merchantId: json['merchantId'] as String?,
    noreg: json['noreg'] as String?,
    produk: json['produk'] as String?,
    saldoAkhir: json['saldoAkhir'] as int?,
    saldoAwal: json['saldoAwal'] as int?,
    tidTransaction: json['tidTransaction'] as String?,
    traceNo: json['traceNo'] as String?,
    trxdatetime: json['trxdatetime'] as String?,
    trxid: json['trxid'] as String?,
    hargaAnipay: json['hargaAnipay'] as int?,
    tobay: json['tobay'] as int?,
  );
}

Map<String, dynamic> _$TransactionResponseModelToJson(
        TransactionResponseModel instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'billAmount': instance.billAmount,
      'billingCode': instance.billingCode,
      'customer_data': instance.customerData,
      'merchantId': instance.merchantId,
      'noreg': instance.noreg,
      'produk': instance.produk,
      'saldoAkhir': instance.saldoAkhir,
      'saldoAwal': instance.saldoAwal,
      'tidTransaction': instance.tidTransaction,
      'traceNo': instance.traceNo,
      'trxdatetime': instance.trxdatetime,
      'trxid': instance.trxid,
      'hargaAnipay': instance.hargaAnipay,
      'tobay': instance.tobay,
    };
