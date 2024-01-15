import 'package:flutter/material.dart';

class BasicConfirmDialogHome extends StatelessWidget {
  final String? text;
  final VoidCallback? cancelOnPressed;
  final String? cancelText;
  final VoidCallback? confirmOnPressed;
  final String? confirmText;
  const BasicConfirmDialogHome({this.text, this.cancelOnPressed, this.confirmOnPressed, this.cancelText, this.confirmText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text??""),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: confirmOnPressed, child: Text(confirmText??"YES")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
