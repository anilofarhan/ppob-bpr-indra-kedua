import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FingerModalPPOBController extends GetxController {
  late BuildContext context;
  static FingerModalPPOBController get to => Get.find<FingerModalPPOBController>();
  final GlobalKey<FormState> fingerKey = GlobalKey<FormState>();

  Rx<String> failedMessage = ''.obs;

  late Function fingerListener = "".obs;

  final TextEditingController pinController = TextEditingController();
  RxBool hideFinger = true.obs;
  final RxBool canConfirm = false.obs;
  final RxBool isShowMessage = false.obs;
  // late Function function;

  FingerModalPPOBController({required this.context/*, required this.fingerListener*/});

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
  void dispose() {
    // TODO: implement dispose
    pinController.text = "";
    hideFinger = false.obs;
    pinController.dispose();
    super.dispose();

  }


  @override
  void onClose() {
    pinController.text = "";
    hideFinger = false.obs;
    pinController.dispose();
    super.onClose();
  }
}
