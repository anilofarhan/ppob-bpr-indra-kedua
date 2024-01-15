import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppob/core/constant/colors.dart';
import 'package:ppob/core/constant/strings.dart';

class CustomElevatedButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final bool isFullWidth;
  final bool hasBorder;
  final bool useIcon;
  final IconData? icon;
  final double radius;
  final Function()? onPressed;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry padding;

  const CustomElevatedButton({
    Key? key,
    this.text = Strings.tutup,
    this.textColor = Colors.white,
    this.bgColor = AppColors.kGreen,
    this.isFullWidth = false,
    this.hasBorder = false,
    this.useIcon = false,
    this.icon,
    this.radius = 20,
    this.onPressed = getBack,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  static void getBack() {
    Get.back();
  }

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: widget.isFullWidth
          ? SizedBox(
              width: double.infinity, child: Center(child: generateContent()))
          : generateContent(),
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(widget.textColor),
          alignment: Alignment.center,
          textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
              fontSize: widget.fontSize, fontWeight: widget.fontWeight)),
          backgroundColor: MaterialStateProperty.all<Color>(widget.bgColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              side: widget.hasBorder
                  ? BorderSide(width: 1, color: widget.textColor)
                  : BorderSide.none)),
          padding:
              MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 12))),
    );
  }

  generateContent() {
    if (widget.useIcon) {
      return Icon(widget.icon, size: widget.fontSize! * 2);
    } else {
      return Padding(
          padding: widget.padding,
          child: Text(widget.text, textAlign: TextAlign.center));
    }
  }
}
