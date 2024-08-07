import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/constant/Style.dart' as app_style;
import 'package:share_plus/share_plus.dart';

class DialogPaymentSukses extends StatelessWidget {
  final GlobalKey key3 = GlobalKey();
  final String htmlStr;
  final OnTutupPressed? onTutupPressed;
  final String fileName;

  DialogPaymentSukses({required this.htmlStr, this.onTutupPressed, required this.fileName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Dialog(
        insetPadding: EdgeInsets.all(10.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RepaintBoundary(
                key: key3,
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        Strings.detail_transaksi,
                        style: app_style.Style.text18spBlackBold,
                      ),
                      //herelogo
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                        child: ImageAsset(
                          imgPath: Assets.logo,
                          fit: BoxFit.fitHeight, height: 46,
                        ),
                      ),
                      Html(data: htmlStr),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 16.0, 25, 0),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.pop(context, true);
                    shareInboxDetail(fileName+"");
                  },
                  child: Center(
                    child: Text(
                      "BAGIKAN".toUpperCase(),
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(BorderSide(width: 1.0, color: Colors.red)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 5)),
                  ),
                  // style: ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all(Colors.blue),
                  //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15))),
                  //     padding: MaterialStateProperty.all(
                  //         const EdgeInsets.symmetric(vertical: 15))),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    if (onTutupPressed != null) {
                      onTutupPressed!.call();
                    }
                  },
                  child: Center(
                    child: Text(Strings.tutup.toUpperCase()),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red[600]),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 5)),
                  ),
                  // style: ButtonStyle(
                  //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15))),
                  //     padding: MaterialStateProperty.all(
                  //         const EdgeInsets.symmetric(vertical: 15))),
                ),
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  shareInboxDetail(String? fileName) async {
    final boundary = key3.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    final image = await boundary?.toImage(pixelRatio: 2.0);
    final byteData = await image?.toByteData(format: ImageByteFormat.png);
    final imageBytes = byteData?.buffer.asUint8List();

    if (imageBytes != null) {
      final directory = await getTemporaryDirectory();
      final imagePath = await File('${directory.path}/$fileName.png').create();
      await imagePath.writeAsBytes(imageBytes).then((value) async {
        await Share.shareFiles(
          [value.path],
          mimeTypes: ['image/png'],
        );
      });
    }
  }
}

typedef OnTutupPressed = void Function();
