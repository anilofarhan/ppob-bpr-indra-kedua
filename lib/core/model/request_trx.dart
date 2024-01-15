import 'package:json_annotation/json_annotation.dart';

part 'request_trx.g.dart';

@JsonSerializable()
class RequestTrx {
  @JsonKey(name: "method")
  String method;
  @JsonKey(name: "cid")
  String cid = "002";
  @JsonKey(name: "data")
  String data;

  RequestTrx({required this.method, required this.data});

  factory RequestTrx.fromJson(Map<String, dynamic> json) =>
      _$RequestTrxFromJson(json);

  Map<String, dynamic> toJson() => _$RequestTrxToJson(this);
}
