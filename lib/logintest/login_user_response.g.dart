// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BaseLoginUserResponseAdapter extends TypeAdapter<BaseLoginUserResponse> {
  @override
  final int typeId = 11;

  @override
  BaseLoginUserResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaseLoginUserResponse(
      status: fields[0] as String?,
      description: fields[1] as String?,
      data: (fields[2] as List?)?.cast<LoginUserResponse>(),
      session: fields[3] as String?,
      trxseckey: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BaseLoginUserResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.session)
      ..writeByte(4)
      ..write(obj.trxseckey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseLoginUserResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LoginUserResponseAdapter extends TypeAdapter<LoginUserResponse> {
  @override
  final int typeId = 12;

  @override
  LoginUserResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginUserResponse(
      idNasabah: fields[0] as int?,
      noRek: fields[1] as String?,
      noCard: fields[2] as String?,
      nik: fields[4] as String?,
      namaLengkap: fields[5] as String?,
      alamatLengkap: fields[6] as String?,
      noMesinHp: fields[7] as String?,
      noHp: fields[8] as String?,
      tglLahir: fields[9] as String?,
      alamat: fields[10] as String?,
      nasabahStatus: fields[11] as String?,
      cardStatus: fields[12] as String?,
      maxKartu: fields[13] as String?,
      tglTerbitKartu: fields[14] as String?,
      grupLimit: fields[15] as String?,
      username: fields[16] as String?,
      flagRegApp: fields[17] as int?,
      token: fields[18] as String?,
      flagPinTransaksi: fields[19] as int?,
      cif: fields[20] as String?,
      ftcPassword: fields[21] as int?,
      kantorCabang: fields[22] as String?,
      flagFingerprint: fields[23] as int?,
      pinTransaksi: fields[24] as String?,
    )..noQrCode = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, LoginUserResponse obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.idNasabah)
      ..writeByte(1)
      ..write(obj.noRek)
      ..writeByte(2)
      ..write(obj.noCard)
      ..writeByte(3)
      ..write(obj.noQrCode)
      ..writeByte(4)
      ..write(obj.nik)
      ..writeByte(5)
      ..write(obj.namaLengkap)
      ..writeByte(6)
      ..write(obj.alamatLengkap)
      ..writeByte(7)
      ..write(obj.noMesinHp)
      ..writeByte(8)
      ..write(obj.noHp)
      ..writeByte(9)
      ..write(obj.tglLahir)
      ..writeByte(10)
      ..write(obj.alamat)
      ..writeByte(11)
      ..write(obj.nasabahStatus)
      ..writeByte(12)
      ..write(obj.cardStatus)
      ..writeByte(13)
      ..write(obj.maxKartu)
      ..writeByte(14)
      ..write(obj.tglTerbitKartu)
      ..writeByte(15)
      ..write(obj.grupLimit)
      ..writeByte(16)
      ..write(obj.username)
      ..writeByte(17)
      ..write(obj.flagRegApp)
      ..writeByte(18)
      ..write(obj.token)
      ..writeByte(19)
      ..write(obj.flagPinTransaksi)
      ..writeByte(20)
      ..write(obj.cif)
      ..writeByte(21)
      ..write(obj.ftcPassword)
      ..writeByte(22)
      ..write(obj.kantorCabang)
      ..writeByte(23)
      ..write(obj.flagFingerprint)
      ..writeByte(24)
      ..write(obj.pinTransaksi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginUserResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseLoginUserResponse _$BaseLoginUserResponseFromJson(Map json) {
  return BaseLoginUserResponse(
    status: json['status'] as String?,
    description: json['description'] as String?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) =>
            LoginUserResponse.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(),
    session: json['session'] as String?,
    trxseckey: json['trxseckey'] as String?,
  );
}

Map<String, dynamic> _$BaseLoginUserResponseToJson(
        BaseLoginUserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'description': instance.description,
      'data': instance.data,
      'session': instance.session,
      'trxseckey': instance.trxseckey,
    };

LoginUserResponse _$LoginUserResponseFromJson(Map json) {
  return LoginUserResponse(
    idNasabah: json['idNasabah'] as int?,
    noRek: json['norek'] as String?,
    noCard: json['nocard'] as String?,
    nik: json['nik'] as String?,
    namaLengkap: json['namaLengkap'] as String?,
    alamatLengkap: json['alamatLengkap'] as String?,
    noMesinHp: json['noMesinHp'] as String?,
    noHp: json['noHp'] as String?,
    tglLahir: json['tglLahir'] as String?,
    alamat: json['alamat'] as String?,
    nasabahStatus: json['nasabahStatus'] as String?,
    cardStatus: json['cardStatus'] as String?,
    maxKartu: json['maxKartu'] as String?,
    tglTerbitKartu: json['tgl_terbit_kartu'] as String?,
    grupLimit: json['grupLimit'] as String?,
    username: json['username'] as String?,
    flagRegApp: json['flagRegApp'] as int?,
    token: json['token'] as String?,
    flagPinTransaksi: json['flagPINTransaksi'] as int?,
    cif: json['cif'] as String?,
    ftcPassword: json['ftcPassword'] as int?,
    kantorCabang: json['kantorCabang'] as String?,
    flagFingerprint: json['flagFingerprint'] as int?,
    pinTransaksi: json['pinTransaksi'] as String?,
  )..noQrCode = json['noQrcode'] as String?;
}

Map<String, dynamic> _$LoginUserResponseToJson(LoginUserResponse instance) =>
    <String, dynamic>{
      'idNasabah': instance.idNasabah,
      'norek': instance.noRek,
      'nocard': instance.noCard,
      'noQrcode': instance.noQrCode,
      'nik': instance.nik,
      'namaLengkap': instance.namaLengkap,
      'alamatLengkap': instance.alamatLengkap,
      'noMesinHp': instance.noMesinHp,
      'noHp': instance.noHp,
      'tglLahir': instance.tglLahir,
      'alamat': instance.alamat,
      'nasabahStatus': instance.nasabahStatus,
      'cardStatus': instance.cardStatus,
      'maxKartu': instance.maxKartu,
      'tgl_terbit_kartu': instance.tglTerbitKartu,
      'grupLimit': instance.grupLimit,
      'username': instance.username,
      'flagRegApp': instance.flagRegApp,
      'token': instance.token,
      'flagPINTransaksi': instance.flagPinTransaksi,
      'cif': instance.cif,
      'ftcPassword': instance.ftcPassword,
      'kantorCabang': instance.kantorCabang,
      'flagFingerprint': instance.flagFingerprint,
      'pinTransaksi': instance.pinTransaksi,
    };
