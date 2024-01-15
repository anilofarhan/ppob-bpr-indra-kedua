import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/constant/Style.dart' as app_style;
import 'package:ppob/core/utils.dart';

class DialogKonfirmasiSukses extends StatelessWidget {
  final VoidCallback onSubmit;
  final String htmlStr;
  final String imageProductPath;
  final String? productName;
  final String? noPelanggan;
  final OnTutupPressed? onTutupPressed;
  const DialogKonfirmasiSukses(
      {required this.onSubmit, required this.htmlStr, this.onTutupPressed, required this.productName, required this.noPelanggan, required this.imageProductPath, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Dialog(
        insetPadding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: Colors.grey[300],
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  ImageAsset(
                      imgPath: Assets.ic_question_mark,
                      height: 30.h,
                      width: 30.h),
                  height_10(),
                  Text(
                    Strings.korfirmasi,
                    style: app_style.Style.text18spBlackBold,
                  ),
                ],
              ),
            ),
            height_10(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.h),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(200)),
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
                          style: app_style.Style.text14spBlackBold,
                        ),
                        Text(
                          noPelanggan ?? "",
                          style: app_style.Style.text14spBlack,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  Html(data: htmlStr),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              child: Row(
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
            )
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}

typedef OnTutupPressed = void Function();
