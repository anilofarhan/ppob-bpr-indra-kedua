// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdam_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PdamProductsModel _$PdamProductsModelFromJson(Map<String, dynamic> json) {
  return PdamProductsModel(
    idProduk: json['idProduk'] as int?,
    jenisProduk: json['jenisProduk'] as String?,
    kode: json['kode'] as String?,
    produk: json['produk'] as String?,
    tcode: json['tcode'] as String?,
    uCode: json['uCode'] as String?,
  );
}

Map<String, dynamic> _$PdamProductsModelToJson(PdamProductsModel instance) =>
    <String, dynamic>{
      'idProduk': instance.idProduk,
      'jenisProduk': instance.jenisProduk,
      'kode': instance.kode,
      'produk': instance.produk,
      'tcode': instance.tcode,
      'uCode': instance.uCode,
    };
