import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PinModalPPOBController extends GetxController {
  static PinModalPPOBController get to => Get.find<PinModalPPOBController>();
  final GlobalKey<FormState> pinKey = GlobalKey<FormState>();

  Rx<String> failedMessage = ''.obs;

  final TextEditingController pinController = TextEditingController();
  RxBool hidePin = true.obs;
  final RxBool canConfirm = false.obs;
  final RxBool isShowMessage = false.obs;

  @override
  void onInit() {
    pinController.addListener(() {
      pinController.text.length > 5
          ? canConfirm.value = true
          : canConfirm.value = false;
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    pinController.text = "";
    hidePin = false.obs;
    pinController.dispose();
    super.onClose();
  }
}
