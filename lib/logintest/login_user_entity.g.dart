// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginUserEntityAdapter extends TypeAdapter<LoginUserEntity> {
  @override
  final int typeId = 9;

  @override
  LoginUserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginUserEntity()
      ..sessionId = fields[0] as String?
      ..secretKey = fields[1] as String?
      ..username = fields[2] as String?
      ..fullName = fields[3] as String?
      ..cardNo = fields[4] as String?
      ..nik = fields[5] as String?
      ..noSnHp = fields[6] as String?
      ..noRek = fields[7] as String?
      ..tanggalLahir = fields[8] as String?
      ..alamat = fields[9] as String?
      ..noPonsel = fields[10] as String?
      ..idNasabah = fields[11] as int?
      ..flagLogin = fields[12] as int?
      ..cardStatus = fields[13] as String?
      ..isCreatePin = fields[14] as bool?
      ..isFtcPassword = fields[15] as bool?
      ..kantorCabang = fields[16] as String?
      ..dataLogin = fields[17] as BaseLoginUserResponse?
      ..isLogin = fields[18] as bool?
      ..cif = fields[19] as String?
      ..passwordLama = fields[20] as String?;
  }

  @override
  void write(BinaryWriter writer, LoginUserEntity obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.sessionId)
      ..writeByte(1)
      ..write(obj.secretKey)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.cardNo)
      ..writeByte(5)
      ..write(obj.nik)
      ..writeByte(6)
      ..write(obj.noSnHp)
      ..writeByte(7)
      ..write(obj.noRek)
      ..writeByte(8)
      ..write(obj.tanggalLahir)
      ..writeByte(9)
      ..write(obj.alamat)
      ..writeByte(10)
      ..write(obj.noPonsel)
      ..writeByte(11)
      ..write(obj.idNasabah)
      ..writeByte(12)
      ..write(obj.flagLogin)
      ..writeByte(13)
      ..write(obj.cardStatus)
      ..writeByte(14)
      ..write(obj.isCreatePin)
      ..writeByte(15)
      ..write(obj.isFtcPassword)
      ..writeByte(16)
      ..write(obj.kantorCabang)
      ..writeByte(17)
      ..write(obj.dataLogin)
      ..writeByte(18)
      ..write(obj.isLogin)
      ..writeByte(19)
      ..write(obj.cif)
      ..writeByte(20)
      ..write(obj.passwordLama);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginUserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
