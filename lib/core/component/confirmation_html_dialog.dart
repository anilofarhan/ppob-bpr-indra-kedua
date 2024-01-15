// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/colors.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/utils.dart';

class ConfirmationHtmlDialog extends StatelessWidget {
  final VoidCallback onSubmit;
  final String imageProductPath;
  final String? productName;
  final String? noPelanggan;
  final String? deskripsi;
  final bool showTutupButton;
  const ConfirmationHtmlDialog(
      {required this.onSubmit, required this.imageProductPath, required this.productName, required this.noPelanggan, required this.deskripsi, this.showTutupButton = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              color: Colors.grey[300],
            ),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                ImageAsset(imgPath: Assets.ic_question_mark, height: 30.h, width: 30.h),
                height_10(),
                Text(
                  Strings.korfirmasi,
                  style: TextStyle(fontSize: 18.sp, color: AppColors.black, fontWeight: FontWeight.bold),
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(200)), color: Colors.grey[300]),
                  child: ImageAsset(imgPath: imageProductPath, height: 40.h, width: 40.h, fit: BoxFit.contain),
                ),
                width_10(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName ?? "",
                        style: TextStyle(fontSize: 14.sp, color: AppColors.black, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        noPelanggan ?? "",
                        style: TextStyle(fontSize: 14.sp, color: AppColors.black),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Html(data: deskripsi),
          ),
          height_10(),
          showTutupButton
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ButtonRed(
                    title: Strings.tutup,
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        SystemNavigator.pop();
                      }
                    },
                  ),
                )
              : Row(
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
