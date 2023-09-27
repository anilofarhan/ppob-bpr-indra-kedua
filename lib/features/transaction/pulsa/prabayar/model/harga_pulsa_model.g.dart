// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'harga_pulsa_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HargaPulsaModel _$HargaPulsaModelFromJson(Map<String, dynamic> json) {
  return HargaPulsaModel(
    hargaPublic: (json['hargaPublic'] as num?)?.toDouble(),
    jenisProduk: json['jenisProduk'] as String?,
    kodeProduk: json['kodeProduk'] as String?,
  );
}

Map<String, dynamic> _$HargaPulsaModelToJson(HargaPulsaModel instance) =>
    <String, dynamic>{
      'hargaPublic': instance.hargaPublic,
      'jenisProduk': instance.jenisProduk,
      'kodeProduk': instance.kodeProduk,
    };
