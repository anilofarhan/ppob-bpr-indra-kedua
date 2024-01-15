// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, non_constant_identifier_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:ppob/core/component/dialog_payment_sukses.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/colors.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/constant/style.dart';

CustomAppBar(
    {required BuildContext context,
    String title = "",
    OnBackPressed? onBackPressed,
    bool elevation = true,
    List<Widget>? actionMenus}) {
  return AppBar(
    title: Text(title),
    actions: actionMenus,
    elevation: elevation ? 3 : 0,
    leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: onBackPressed ??
            () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                SystemNavigator.pop();
              }
            }),
  );
}

CustomAppBarText(
    {required BuildContext context,
      required Widget title,
      OnBackPressed? onBackPressed,
      bool elevation = true,
      List<Widget>? actionMenus}) {
  return AppBar(
    title: title,
    actions: actionMenus,
    elevation: elevation ? 3 : 0,
    leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: onBackPressed ??
                () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                SystemNavigator.pop();
              }
            }),
  );
}


OptionProducts(
    {String? hintText,
    required String? selectedValue,
    required List<String> menus,
    required Function(String selectedValue) onSelectedListener}) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3))),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.product,
            style: Style.text18spGreyBold,
          ),
          Divider(
            color: Colors.grey[300],
          ),
          DropdownButton(
            isExpanded: true,
            hint: hintText == null ? null : Text(hintText),
            value: selectedValue,
            items: menus.map((e) {
              return DropdownMenuItem<String>(value: e, child: Text(e));
            }).toList(),
            onChanged: (value) {
              onSelectedListener.call(value.toString());
            },
          ),
        ],
      ),
    ),
  );
}

CurveHeader({required double height}) {
  return Stack(
    children: [
      Container(
        height: height,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              height: height,
              color: AppColors.colorPrimary,
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: ImageAsset(
                    imgPath: Assets.curve_main, fit: BoxFit.fitHeight))
          ],
        ),
      ),
    ],
  );
}

ButtonRed(
    {required String title,
    required VoidCallback? onPressed,
    double? width,
    bool isEnabled = true}) {
  return Container(
    width: width,
    child: ElevatedButton(
      child: Text(
        title.toUpperCase(),
        style: Style.text16spWhite,
      ),
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w)),
        backgroundColor: MaterialStateProperty.all<Color>(
            isEnabled ? AppColors.colorPrimary : AppColors.disableButton),
        side: MaterialStateProperty.all<BorderSide>(BorderSide(
            color:
                isEnabled ? AppColors.colorPrimary : AppColors.disableButton)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
    ),
  );
}

ButtonRedOutline(
    {required String title,
    required VoidCallback? onPressed,
    double? width,
    bool isEnabled = true}) {
  return Container(
    width: width,
    child: ElevatedButton(
      child: Text(
        title.toUpperCase(),
        style: Style.text16spRed,
      ),
      onPressed: isEnabled ? onPressed : null,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w)),
        backgroundColor: MaterialStateProperty.all<Color>(
            isEnabled ? Colors.white : AppColors.disableButton),
        side: MaterialStateProperty.all<BorderSide>(BorderSide(
            color:
                isEnabled ? AppColors.colorPrimary : AppColors.disableButton)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
    ),
  );
}

ImageAsset(
    {required String imgPath,
    double? height,
    double? width,
    BoxFit? fit = BoxFit.fill}) {
  return Image.asset(
    imgPath,
    height: height,
    width: width,
    fit: fit,
    package: "ppob",
    errorBuilder: (context, error, stackTrace) {
      return Image.asset(imgPath,
          height: height, width: width, fit: fit, package: "..");
    },
  );
}

void showProgressDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return _progressDialog(context);
    },
  );
}

void dismissProgressDialog(BuildContext context) {
  Navigator.pop(context);
}

Widget _progressDialog(BuildContext context) {
  return WillPopScope(
    child: AlertDialog(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox.fromSize(
              child: SpinKitThreeBounce(
                color: AppColors.colorPrimary,
                size: 15.h,
              ),
              size: Size(35.w, 25.h)),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "Mohon tunggu...",
                  style: TextStyle(
                    fontSize: 14.h,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
          ),
        ],
      ),
    ),
    onWillPop: () async {
      return false;
    },
  );
}

showDialogSukses(
    {required BuildContext context,
    required htmlStr,
    OnTutupPressed? onTutupPressed}) {
  showDialog(
    context: context,
    builder: (context) => DialogPaymentSukses(
      htmlStr: htmlStr,
      onTutupPressed: onTutupPressed,
      fileName: "file ",
    ),
  );
}

typedef OnBackPressed = void Function();
typedef PinListener = void Function(String pin);
typedef FingerListener = void Function(String pin);
typedef OnContactValue = void Function(String contact);

class InputNoPelanggan extends StatelessWidget {
  late String iconPath;
  late String title;
  TextEditingController? controller;
  String? hintText = "";
  bool isPhoneContact = false;
  OnContactValue? onContactValue;

  InputNoPelanggan(
      {Key? key,
      required this.iconPath,
      required this.title,
      required this.controller,
      this.hintText,
      this.isPhoneContact = false,
      this.onContactValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: SizedBox(
        height: 85.h,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(3),
                  topLeft: Radius.circular(3),
                ),
                color: Colors.grey[100],
              ),
              margin: EdgeInsets.only(right: 10),
              width: 50.w,
              height: double.infinity,
              padding: EdgeInsets.all(3.w),
              child: ImageAsset(imgPath: iconPath, fit: BoxFit.fitWidth),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 5),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Style.text14spBlack,
                    ),
                    TextField(
                      controller: controller,
                      style: TextStyle(fontSize: 18.sp),
                      decoration:
                          InputDecoration(hintText: hintText, counterText: ""),
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                      minLines: 1,
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isPhoneContact,
              child: Row(
                children: [
                  Container(
                    color: Colors.grey[300],
                    width: 2,
                    height: 30,
                  ),
                  IconButton(
                    onPressed: () async {
                      _askPermissions(context);
                    },
                    icon: ImageAsset(imgPath: Assets.ic_contact_book),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _askPermissions(BuildContext context) async {
    final granted = await FlutterContactPicker.requestPermission();
    if (granted) {
      final PhoneContact contact =
          await FlutterContactPicker.pickPhoneContact();
      String sss = contact.phoneNumber?.number ?? "";
      onContactValue?.call(sss
          .replaceAll("(", "")
          .replaceAll(")", "")
          .replaceAll("+", "")
          .replaceAll("-", "")
          .replaceAll(" ", "")
          .replaceAll("+62", "0"));
    } else {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

void showSnakeBar(BuildContext context, String msg) {
  final snackBar = SnackBar(content: Text(msg));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
