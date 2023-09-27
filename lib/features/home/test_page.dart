import 'package:flutter/material.dart';
import 'package:ppob/core/constant/constants.dart';

import 'home_menu_screen.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MenuPPOBScreen(
                      noRekening: Constants.NO_REKENING,
                      isFinger: Constants.isFinger,
                      noPin: Constants.PIN_TRANSAKSI,
                      serialNo: Constants.SERIAL_NO,
                    )));
          },
          child: const Text("PPOB MENU")),
    );
  }
}
