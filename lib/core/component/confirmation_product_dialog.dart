// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/constant/style.dart';
import 'package:ppob/core/utils.dart';

class ConfirmationProductDialog extends StatelessWidget {
  final VoidCallback onSubmit;
  final String imageProductPath;
  final String? productName;
  final String? noPelanggan;
  final String? deskripsi;
  const ConfirmationProductDialog(
      {required this.onSubmit,
      required this.imageProductPath,
      required this.productName,
      required this.noPelanggan,
      required this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              color: Colors.grey[300],
            ),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                ImageAsset(
                    imgPath: Assets.ic_question_mark,
                    height: 30.h,
                    width: 30.h),
                height_10(),
                Text(
                  Strings.korfirmasi,
                  style: Style.text18spBlackBold,
                ),
              ],
            ),
          ),
          height_10(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(200)),
                      color: Colors.grey[300]),
                  child: ImageAsset(
                      imgPath: imageProductPath,
                      height: 40.h,
                      width: 40.h,
                      fit: BoxFit.contain),
                ),
                width_10(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName ?? "",
                        style: Style.text14spBlackBold,
                      ),
                      Text(
                        noPelanggan ?? "",
                        style: Style.text14spBlack,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              deskripsi ?? "",
              style: Style.text14spBlack,
            ),
          ),
          height_10(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ButtonRedOutline(
                    title: Strings.batal,
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        SystemNavigator.pop();
                      }
                    },
                  ),
                ),
              ),
              width_15(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ButtonRed(
                    title: Strings.kirim,
                    onPressed: onSubmit,
                  ),
                ),
              ),
            ],
          ),
          height_15(),
        ],
      ),
    );
  }
}
