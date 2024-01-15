import 'package:json_annotation/json_annotation.dart';

part 'transaction_response_model.g.dart';

@JsonSerializable()
class TransactionResponseModel {
  @JsonKey(name: 'amount')
  String? amount;
  @JsonKey(name: 'billAmount')
  int? billAmount;
  @JsonKey(name: 'billingCode')
  String? billingCode;
  @JsonKey(name: 'customer_data')
  String? customerData;
  @JsonKey(name: 'merchantId')
  String? merchantId;
  @JsonKey(name: 'noreg')
  String? noreg;
  @JsonKey(name: 'produk')
  String? produk;
  @JsonKey(name: 'saldoAkhir')
  int? saldoAkhir;
  @JsonKey(name: 'saldoAwal')
  int? saldoAwal;
  @JsonKey(name: 'tidTransaction')
  String? tidTransaction;
  @JsonKey(name: 'traceNo')
  String? traceNo;
  @JsonKey(name: 'trxdatetime')
  String? trxdatetime;
  @JsonKey(name: 'trxid')
  String? trxid;
  @JsonKey(name: 'hargaAnipay')
  int? hargaAnipay;
  @JsonKey(name: 'tobay')
  int? tobay;

  TransactionResponseModel(
      {this.amount,
      this.billAmount,
      this.billingCode,
      this.customerData,
      this.merchantId,
      this.noreg,
      this.produk,
      this.saldoAkhir,
      this.saldoAwal,
      this.tidTransaction,
      this.traceNo,
      this.trxdatetime,
      this.trxid,
      this.hargaAnipay,
      this.tobay});

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) => _$TransactionResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionResponseModelToJson(this);
}
