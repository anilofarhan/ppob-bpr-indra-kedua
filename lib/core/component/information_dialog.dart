import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/colors.dart';
import 'package:ppob/core/constant/strings.dart';

class InformationFailedDialog extends StatelessWidget {
  final String message;
  const InformationFailedDialog({required this.message, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                ImageAsset(imgPath: Assets.error, height: 30.h, width: 30.h),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  Strings.pemberitahuan,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  SystemNavigator.pop();
                }
              },
              child: Center(
                child: Text(Strings.tutup.toUpperCase()),
              ),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 12))),
            ),
          )
        ],
      ),
    );
  }
}

class InformationWarningDialog extends StatelessWidget {
  final String message;
  const InformationWarningDialog({required this.message, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                ImageAsset(imgPath: Assets.error, height: 30.h, width: 30.h),
                //Icon(Icons.error, size: 50, color: Colors.orange),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  Strings.pemberitahuan,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  SystemNavigator.pop();
                }
              },
              child: Center(
                child: Text(Strings.tutup.toUpperCase()),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 12)),
                backgroundColor: MaterialStateProperty.all(Colors.orange),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InformationSuccessDialog extends StatelessWidget {
  final String message;
  final VoidCallback? onPressed;
  const InformationSuccessDialog(
      {required this.message, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                ImageAsset(
                    imgPath: Assets.checked_green, height: 30.h, width: 30.h),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  Strings.pemberitahuan,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: onPressed ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      SystemNavigator.pop();
                    }
                  },
              child: Center(
                child: Text(Strings.tutup.toUpperCase()),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.kGreen),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 12))),
            ),
          )
        ],
      ),
    );
  }
}
