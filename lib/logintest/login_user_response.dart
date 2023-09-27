import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'hive_app_types.dart';

part 'login_user_response.g.dart';

@JsonSerializable(anyMap: true)
@HiveType(typeId: HiveAppTypes.BASE_LOGIN_USER_RESPONSE_ADAPTER_TYPE)
class BaseLoginUserResponse {
  @JsonKey(name: 'status')
  @HiveField(0)
  String? status;
  @JsonKey(name: 'description')
  @HiveField(1)
  String? description;
  @JsonKey(name: 'data')
  @HiveField(2)
  List<LoginUserResponse>? data;
  @JsonKey(name: 'session')
  @HiveField(3)
  String? session;
  @JsonKey(name: 'trxseckey')
  @HiveField(4)
  String? trxseckey;

  BaseLoginUserResponse(
      {this.status, this.description, this.data, this.session, this.trxseckey});

  factory BaseLoginUserResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseLoginUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseLoginUserResponseToJson(this);
}

@JsonSerializable(explicitToJson: true, anyMap: true)
@HiveType(typeId: HiveAppTypes.LOGIN_USER_RESPONSE_ADAPTER_TYPE)
class LoginUserResponse {
  @JsonKey(name: 'idNasabah')
  @HiveField(0)
  int? idNasabah;
  @JsonKey(name: 'norek')
  @HiveField(1)
  String? noRek;
  @JsonKey(name: 'nocard')
  @HiveField(2)
  String? noCard;
  @JsonKey(name: 'noQrcode')
  @HiveField(3)
  String? noQrCode;
  @JsonKey(name: 'nik')
  @HiveField(4)
  String? nik;
  @JsonKey(name: 'namaLengkap')
  @HiveField(5)
  String? namaLengkap;
  @JsonKey(name: 'alamatLengkap')
  @HiveField(6)
  String? alamatLengkap;
  @JsonKey(name: 'noMesinHp')
  @HiveField(7)
  String? noMesinHp;
  @JsonKey(name: 'noHp')
  @HiveField(8)
  String? noHp;
  @JsonKey(name: 'tglLahir')
  @HiveField(9)
  String? tglLahir;
  @JsonKey(name: 'alamat')
  @HiveField(10)
  String? alamat;
  @JsonKey(name: 'nasabahStatus')
  @HiveField(11)
  String? nasabahStatus;
  @JsonKey(name: 'cardStatus')
  @HiveField(12)
  String? cardStatus;
  @JsonKey(name: 'maxKartu')
  @HiveField(13)
  String? maxKartu;
  @JsonKey(name: 'tgl_terbit_kartu')
  @HiveField(14)
  String? tglTerbitKartu;
  @JsonKey(name: 'grupLimit')
  @HiveField(15)
  String? grupLimit;
  @JsonKey(name: 'username')
  @HiveField(16)
  String? username;
  @JsonKey(name: 'flagRegApp')
  @HiveField(17)
  int? flagRegApp;
  @JsonKey(name: 'token')
  @HiveField(18)
  String? token;
  @JsonKey(name: 'flagPINTransaksi')
  @HiveField(19)
  int? flagPinTransaksi;
  @JsonKey(name: 'cif')
  @HiveField(20)
  String? cif;
  @JsonKey(name: 'ftcPassword')
  @HiveField(21)
  int? ftcPassword;
  @JsonKey(name: 'kantorCabang')
  @HiveField(22)
  String? kantorCabang;
  @JsonKey(name: 'flagFingerprint')
  @HiveField(23)
  int? flagFingerprint;
  @JsonKey(name: 'pinTransaksi')
  @HiveField(24)
  String? pinTransaksi;
  LoginUserResponse(
      {this.idNasabah,
      this.noRek,
      this.noCard,
      this.nik,
      this.namaLengkap,
      this.alamatLengkap,
      this.noMesinHp,
      this.noHp,
      this.tglLahir,
      this.alamat,
      this.nasabahStatus,
      this.cardStatus,
      this.maxKartu,
      this.tglTerbitKartu,
      this.grupLimit,
      this.username,
      this.flagRegApp,
      this.token,
      this.flagPinTransaksi,
      this.cif,
      this.ftcPassword,
      this.kantorCabang,
      this.flagFingerprint,
      this.pinTransaksi});

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserResponseToJson(this);
}
