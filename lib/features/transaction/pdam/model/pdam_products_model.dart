import 'package:json_annotation/json_annotation.dart';

part 'pdam_products_model.g.dart';

@JsonSerializable()
class PdamProductsModel {
  @JsonKey(name: 'idProduk')
  int? idProduk;
  @JsonKey(name: 'jenisProduk')
  String? jenisProduk;
  @JsonKey(name: 'kode')
  String? kode;
  @JsonKey(name: 'produk')
  String? produk;
  @JsonKey(name: 'tcode')
  String? tcode;
  @JsonKey(name: 'uCode')
  String? uCode;

  PdamProductsModel(
      {this.idProduk,
      this.jenisProduk,
      this.kode,
      this.produk,
      this.tcode,
      this.uCode});

  factory PdamProductsModel.fromJson(Map<String, dynamic> json) =>
      _$PdamProductsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PdamProductsModelToJson(this);
}
