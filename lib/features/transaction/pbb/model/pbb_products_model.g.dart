// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pbb_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PbbProductsModel _$PbbProductsModelFromJson(Map<String, dynamic> json) {
  return PbbProductsModel(
    idProduk: json['idProduk'] as int?,
    jenisProduk: json['jenisProduk'] as String?,
    kode: json['kode'] as String?,
    produk: json['produk'] as String?,
    tcode: json['tcode'] as String?,
    uCode: json['uCode'] as String?,
  );
}

Map<String, dynamic> _$PbbProductsModelToJson(PbbProductsModel instance) =>
    <String, dynamic>{
      'idProduk': instance.idProduk,
      'jenisProduk': instance.jenisProduk,
      'kode': instance.kode,
      'produk': instance.produk,
      'tcode': instance.tcode,
      'uCode': instance.uCode,
    };
