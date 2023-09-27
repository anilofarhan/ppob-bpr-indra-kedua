import 'package:hive/hive.dart';

import 'hive_app_types.dart';
import 'login_user_response.dart';

part 'login_user_entity.g.dart';

@HiveType(typeId: HiveAppTypes.LOGIN_USER_ENTITY_ADAPTER_TYPE)
class LoginUserEntity {
  @HiveField(0)
  String? sessionId;
  @HiveField(1)
  String? secretKey;
  @HiveField(2)
  String? username;
  @HiveField(3)
  String? fullName;
  @HiveField(4)
  String? cardNo;
  @HiveField(5)
  String? nik;
  @HiveField(6)
  String? noSnHp;
  @HiveField(7)
  String? noRek;
  @HiveField(8)
  String? tanggalLahir;
  @HiveField(9)
  String? alamat;
  @HiveField(10)
  String? noPonsel;
  @HiveField(11)
  int? idNasabah;
  @HiveField(12)
  int? flagLogin;
  @HiveField(13)
  String? cardStatus;
  @HiveField(14)
  bool? isCreatePin;
  @HiveField(15)
  bool? isFtcPassword;
  @HiveField(16)
  String? kantorCabang;
  @HiveField(17)
  BaseLoginUserResponse? dataLogin;
  @HiveField(18)
  bool? isLogin;
  @HiveField(19)
  String? cif;
  @HiveField(20)
  String? passwordLama;
  // @HiveField(21)
  // String? dataLogin;

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "secretKey": secretKey,
        "username": username,
        "fullName": fullName,
        "cardNo": cardNo,
        "nik": nik,
        "noSnHp": noSnHp,
        "noRek": noRek,
        "tanggalLahir": tanggalLahir,
        "alamat": alamat,
        "noPonsel": noPonsel,
        "idNasabah": idNasabah,
        "flagLogin": flagLogin,
        "cardStatus": cardStatus,
        "isCreatePin": isCreatePin,
        "isFtcPassword": isFtcPassword,
        "kantorCabang": kantorCabang,
        "BaseLoginUserResponse": BaseLoginUserResponse,
        "isLogin": isLogin,
        "cif": cif,
        "passwordLama": passwordLama,
      }..removeWhere((k, v) => v == null);
}
