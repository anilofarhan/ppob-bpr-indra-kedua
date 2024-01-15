import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;
  final EdgeInsetsGeometry padding;
  final TextAlign textAlign;

  const CustomText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textOverflow,
    this.textDecoration,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  const CustomText.white({
    Key? key,
    required this.text,
    this.color = Colors.white,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textOverflow,
    this.textDecoration,
    this.padding = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          overflow: textOverflow,
          decoration: textDecoration,
          textBaseline: TextBaseline.alphabetic,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
