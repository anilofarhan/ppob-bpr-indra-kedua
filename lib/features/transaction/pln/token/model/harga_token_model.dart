import 'package:json_annotation/json_annotation.dart';

part 'harga_token_model.g.dart';

@JsonSerializable()
class HargaTokenModel {
  @JsonKey(name: 'hargaPublic')
  double? hargaPublic;
  @JsonKey(name: 'jenisProduk')
  String? jenisProduk;
  @JsonKey(name: 'kodeProduk')
  String? kodeProduk;

  HargaTokenModel({this.hargaPublic, this.jenisProduk, this.kodeProduk});

  factory HargaTokenModel.fromJson(Map<String, dynamic> json) => _$HargaTokenModelFromJson(json);
  Map<String, dynamic> toJson() => _$HargaTokenModelToJson(this);
}
