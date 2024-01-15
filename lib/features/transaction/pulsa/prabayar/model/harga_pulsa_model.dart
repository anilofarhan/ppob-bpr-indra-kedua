import 'package:json_annotation/json_annotation.dart';

part 'harga_pulsa_model.g.dart';

@JsonSerializable()
class HargaPulsaModel {
  @JsonKey(name: 'hargaPublic')
  double? hargaPublic;
  @JsonKey(name: 'jenisProduk')
  String? jenisProduk;
  @JsonKey(name: 'kodeProduk')
  String? kodeProduk;

  HargaPulsaModel({this.hargaPublic, this.jenisProduk, this.kodeProduk});

  factory HargaPulsaModel.fromJson(Map<String, dynamic> json) =>
      _$HargaPulsaModelFromJson(json);
  Map<String, dynamic> toJson() => _$HargaPulsaModelToJson(this);
}
