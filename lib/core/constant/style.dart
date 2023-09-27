// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class Style {
  static TextStyle get text18spBlack {
    return TextStyle(fontSize: 18.sp, color: AppColors.black);
  }

  static TextStyle get text12spBlack {
    return TextStyle(fontSize: 12.sp, color: AppColors.black);
  }

  static TextStyle get text14spBlack {
    return TextStyle(fontSize: 14.sp, color: AppColors.black);
  }

  static TextStyle get text14spBlackItalic {
    return TextStyle(fontSize: 14.sp, color: AppColors.black, fontStyle: FontStyle.italic);
  }

  static TextStyle get text14spBlackBold {
    return TextStyle(
        fontSize: 14.sp, color: AppColors.black, fontWeight: FontWeight.bold);
  }

  static TextStyle get text14spBlueBold {
    return TextStyle(
        fontSize: 14.sp,
        color: AppColors.kTextBlue,
        fontWeight: FontWeight.bold);
  }

  static TextStyle get text18spBlackBold {
    return TextStyle(
        fontSize: 18.sp, color: AppColors.black, fontWeight: FontWeight.bold);
  }

  static TextStyle get text14spRedBold {
    return TextStyle(
        fontSize: 14.sp,
        color: AppColors.colorAccent,
        fontWeight: FontWeight.bold);
  }

  static TextStyle get text18spRedBold {
    return TextStyle(
        fontSize: 18.sp,
        color: AppColors.colorAccent,
        fontWeight: FontWeight.bold);
  }

  static TextStyle get text18spWhiteBold {
    return TextStyle(
        fontSize: 18.sp,
        color: AppColors.white,
        fontWeight: FontWeight.bold);
  }

  static TextStyle get text18spWhiteBoldItalic {
    return TextStyle(
        fontSize: 18.sp,
        color: AppColors.white,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold);
  }

  static TextStyle get text18spBlueBold {
    return TextStyle(
        fontSize: 18.sp,
        color: AppColors.kTextBlue,
        fontWeight: FontWeight.bold);
  }

  static TextStyle get text18spGreyBold {
    return TextStyle(
        fontSize: 18.sp, color: Colors.black54, fontWeight: FontWeight.bold);
  }

  static TextStyle get text18spWhite {
    return TextStyle(fontSize: 18.sp, color: AppColors.white);
  }

  static TextStyle get text14spWhite {
    return TextStyle(fontSize: 18.sp, color: AppColors.white);
  }

  static TextStyle get text14spWhiteItalic {
    return TextStyle(fontSize: 18.sp, color: AppColors.white, fontStyle: FontStyle.italic,);
  }

  static TextStyle get text11spWhite {
    return TextStyle(fontSize: 12.sp, color: AppColors.white);
  }

  static TextStyle get text11spWhiteItalic {
    return TextStyle(fontSize: 12.sp, color: AppColors.white, fontStyle: FontStyle.italic);
  }

  static TextStyle get text16spWhite {
    return TextStyle(fontSize: 16.sp, color: AppColors.white);
  }

  static TextStyle get text16spRed {
    return TextStyle(fontSize: 16.sp, color: AppColors.colorPrimary);
  }

  static TextStyle get text14spRed {
    return TextStyle(fontSize: 14.sp, color: AppColors.colorPrimary);
  }

  static TextStyle get text18spRed {
    return TextStyle(fontSize: 18.sp, color: AppColors.colorPrimary);
  }

  static TextStyle get text14spGreyBold {
    return TextStyle(
        fontSize: 14.sp, color: Colors.grey[500], fontWeight: FontWeight.bold);
  }

  static TextStyle get text14spGrey {
    return TextStyle(fontSize: 14.sp, color: Colors.grey[500]);
  }

  static TextStyle get text18spGrey {
    return TextStyle(fontSize: 18.sp, color: Colors.grey[500]);
  }
}
