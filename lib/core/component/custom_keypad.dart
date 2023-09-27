import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppob/core/component/custom_elevated_button.dart';
import 'package:ppob/core/constant/colors.dart';

class CustomKeyPad extends StatelessWidget {
  final TextEditingController pinController;
  final Function? onChange;
  final Function? onSubmit;
  final bool isPinLogin;
  final double? buttonSize;
  final double? height;
  final int maxDigit;

  const CustomKeyPad(
      {Key? key,
      required this.pinController,
      this.onChange,
      this.onSubmit,
      this.isPinLogin = true,
      this.buttonSize,
      this.height,
      this.maxDigit = 6})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 60, right: 60),
      height: height,
      child: GridView.count(
        crossAxisCount: 3,
        // maxCrossAxisExtent: Get.width / 6,
        shrinkWrap: true,
        mainAxisSpacing: Get.width / 24,
        crossAxisSpacing: Get.width / 12,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          buttonWidget('1'),
          buttonWidget('2'),
          buttonWidget('3'),
          buttonWidget('4'),
          buttonWidget('5'),
          buttonWidget('6'),
          buttonWidget('7'),
          buttonWidget('8'),
          buttonWidget('9'),
          iconButtonWidget(Icons.close, () {
            // if (pinController.text.length > 6) {
            //   pinController.text = pinController.text.substring(0, 5);
            // }
            pinController.clear();
            // onSubmit!(pinController.text);
          }),
          buttonWidget('0'),
          !isPinLogin
              ? iconButtonWidget(Icons.backspace, () {
                  if (pinController.text.isNotEmpty) {
                    pinController.text = pinController.text
                        .substring(0, pinController.text.length - 1);
                  }
                  if (pinController.text.length > 6) {
                    pinController.text = pinController.text.substring(0, 5);
                  }
                  onChange!(pinController.text);
                })
              : Container(
                  width: buttonSize,
                ),
        ],
      ),
    );
  }

  buttonWidget(String buttonText) {
    return SizedBox(
      height: buttonSize,
      width: buttonSize,
      child: CustomElevatedButton(
        text: buttonText,
        textColor: AppColors.colorPrimary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        hasBorder: true,
        bgColor: Colors.white,
        radius: 10,
        onPressed: () {
          if (pinController.text.length <= 5) {
            pinController.text = pinController.text + buttonText;
            onChange!(pinController.text);
          }
        },
      ),
    );
  }

  iconButtonWidget(IconData icon, Function() function) {
    return Container(
      height: buttonSize,
      width: buttonSize,
      decoration:
          const BoxDecoration(color: Colors.orangeAccent, shape: BoxShape.circle),
      child: CustomElevatedButton(
        useIcon: true,
        icon: icon,
        textColor: AppColors.colorPrimary,
        hasBorder: true,
        bgColor: Colors.white,
        radius: 10,
        onPressed: function,
      ),
    );
  }
}
