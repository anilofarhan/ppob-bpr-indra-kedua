import 'package:json_annotation/json_annotation.dart';

part 'pbb_products_model.g.dart';

@JsonSerializable()
class PbbProductsModel {
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

  PbbProductsModel(
      {this.idProduk,
      this.jenisProduk,
      this.kode,
      this.produk,
      this.tcode,
      this.uCode});

  factory PbbProductsModel.fromJson(Map<String, dynamic> json) =>
      _$PbbProductsModelFromJson(json);
  Map<String, dynamic> toJson() => _$PbbProductsModelToJson(this);
}
