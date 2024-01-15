// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_trx.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestTrx _$RequestTrxFromJson(Map<String, dynamic> json) {
  return RequestTrx(
    method: json['method'] as String,
    data: json['data'] as String,
  )..cid = json['cid'] as String;
}

Map<String, dynamic> _$RequestTrxToJson(RequestTrx instance) =>
    <String, dynamic>{
      'method': instance.method,
      'cid': instance.cid,
      'data': instance.data,
    };
