// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ppob/core/component/custom_keypad.dart';
import 'package:ppob/core/component/finger/finger_modal_controller.dart';
import 'package:ppob/core/constant/colors.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/core/constant/style.dart';
import 'package:ppob/core/utils.dart';

import '../custom_elevated_button.dart';
import '../custom_text.dart';


import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class FingerModalBottomSheetPPOB extends GetView<FingerModalPPOBController> {
  final _auth = LocalAuthentication();
  FingerModalBottomSheetPPOB({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

      Get.lazyPut(() => FingerModalPPOBController(context: context/*, fingerListener: this.fingerListener)*/));
      if(Constants.isFinger) {
        authenticateWithBiometrics(context);
        controller.update();
      }
      return Form(
        key: controller.fingerKey,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          margin: EdgeInsets.only(top: 40.h),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(15),
                    child: Text('PIN',
                        textAlign: TextAlign.center, style: Style.text14spBlack),
                  ),
                  Positioned(
                    right: 15,
                    top: 15,
                    child: InkWell(
                        onTap: () {
                          controller.pinController.text = "";
                          Navigator.pop(context);
                          Navigator.pop(context);
                          },
                        child: Icon(Icons.close)),
                  ),
                ],
              ),
              Divider(height: 1),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                    child: Obx(() {
                      return TextFormField(
                        controller: controller.pinController,
                        obscureText: controller.hideFinger.isTrue ? true : false,
                        obscuringCharacter: "●",
                        enabled: false,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value!.length != 6) {
                            return "Pin must be exactly 6 digits!";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 12,
                        ),
                        decoration: InputDecoration(
                          hintText: '6-digit number',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.grey,
                            letterSpacing: 2,
                            fontStyle: FontStyle.italic,
                          ),
                          errorStyle: TextStyle(
                            color: AppColors.colorPrimary,
                          ),
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.black87,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      );
                    }),
                  ),
                  Positioned(
                    right: 50,
                    top: 36,
                    child: Obx(() {
                      return IconButton(
                        icon: controller.hideFinger.isTrue
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        onPressed: () {
                          controller.hideFinger.value = !controller.hideFinger.value;
                          controller.update();
                        },
                      );
                    }),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: CustomKeyPad(
                    pinController: controller.pinController,
                    isPinLogin: false,
                    buttonSize: MediaQuery.of(context).size.width / 10,
                    height: MediaQuery.of(context).size.height / 3,
                    onChange: (String pin) {
                      controller.pinController.text = pin;
                    },
                    onSubmit: (String pin) {
                      controller.pinController.text = pin;
                    },
                  ),
                ),
              ),
              Obx(() {
                return Visibility(
                  visible: controller.isShowMessage.value,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText(
                      text: controller.failedMessage.value,
                      color: AppColors.colorPrimary,
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                );
              }),
              Divider(height: 1),
              Obx(() {
                return Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: CustomElevatedButton(
                    text: 'KONFIRMASI',
                    isFullWidth: true,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    bgColor: controller.canConfirm.value
                        ? AppColors.colorPrimary
                        : Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    onPressed: controller.canConfirm.value
                        ? () {
                      final FormState? form =
                          controller.fingerKey.currentState;
                      if (form!.validate()) {

                        var s = md5rsaEncryption(controller.pinController.text);
                        Navigator.pop(context, {"response": s.toString()});
                        // fingerListener.call(s);
                        controller.pinController.text = "";
                        controller.update();

                        // Navigator.pop(context, true);
                      }
                    }
                        : null,
                  ),
                );
              }),
            ],
          ),
        ),
      );

    }

  Future<bool> authenticateWithBiometrics(BuildContext context) async {
    try {
      if (await _canUseBiometrics()) {

        final didAuthenticate = await _auth.authenticate(
          authMessages: const <AuthMessages>[
            AndroidAuthMessages(
              cancelButton: 'Masukan PIN',
            ),
            IOSAuthMessages(
              cancelButton: 'Masukan PIN',
            ),
          ],
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
          localizedReason:
          'Authenticate Sidik Jari untuk lanjutkan transaksi',
        );

        if (didAuthenticate) {
          return await verifyFinger(context);
        } else {
          reset();
          return false;
        }
      } else {
        reset();
        return false;
      }
    } on PlatformException catch (e) {

      if (e.code == auth_error.notEnrolled) {
        reset();
        return false;
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        reset();
        return false;
      } else {
        reset();
        return false;
      }
      //gagal
    } catch (e) {
      reset();
      return false;

    }
  }

  Future<bool> verifyFinger(BuildContext context) async {
    // pinController.text = Constants.PIN_TRANSAKSI;
    // pinController.text = "324019";

    var s = rsaEncryption(Constants.PIN_TRANSAKSI);
    Navigator.pop(context, {"response": s.toString()});

    controller.update();


    return true;
  }

  void reset(){
    controller.pinController.text = "";
    controller.update();
  }

  Future<bool> _canUseBiometrics() async {
    final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final canAuthenticate =
        canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
    return canAuthenticate;
  }

}
