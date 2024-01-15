// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'harga_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HargaTokenModel _$HargaTokenModelFromJson(Map<String, dynamic> json) {
  return HargaTokenModel(
    hargaPublic: (json['hargaPublic'] as num?)?.toDouble(),
    jenisProduk: json['jenisProduk'] as String?,
    kodeProduk: json['kodeProduk'] as String?,
  );
}

Map<String, dynamic> _$HargaTokenModelToJson(HargaTokenModel instance) =>
    <String, dynamic>{
      'hargaPublic': instance.hargaPublic,
      'jenisProduk': instance.jenisProduk,
      'kodeProduk': instance.kodeProduk,
    };
