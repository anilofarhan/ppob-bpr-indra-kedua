// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/colors.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/utils.dart';
import 'package:ppob/features/transaction/bpjs/bpjs_screen.dart';
import 'package:ppob/features/transaction/emoney/saldo_emoney_screen.dart';
import 'package:ppob/features/transaction/gopay/saldo_gopay_screen.dart';
import 'package:ppob/features/transaction/dana/saldo_dana_screen.dart';
import 'package:ppob/features/transaction/internet/internet_screen.dart';
import 'package:ppob/features/transaction/linkaja/saldo_linkaja_screen.dart';
import 'package:ppob/features/transaction/multifinance/multifinance_secreen.dart';
import 'package:ppob/features/transaction/ovo/saldo_ovo_screen.dart';
import 'package:ppob/features/transaction/paketdata/paket_data_screen.dart';
import 'package:ppob/features/transaction/pdam/pdam_products_screen.dart';
import 'package:ppob/features/transaction/pln/tagihan/tagihan_pln_screen.dart';
import 'package:ppob/features/transaction/pln/token/token_pln_screen.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/pulsa_pascabayar_screen.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/pulsa_prabayar_screen.dart';
import 'package:ppob/features/transaction/shopee/saldo_shopee_screen.dart';
import 'package:ppob/features/transaction/telkom/telkom_screen.dart';
import 'package:ppob/features/transaction/tv/tv_berbayar_secreen.dart';
import 'package:ppob/util/basic_confirm_dialog.dart';

class MenuPPOBScreen extends StatefulWidget {
  String noRekening;
  bool isFinger;
  String noPin;
  String serialNo;
  MenuPPOBScreen({Key? key, required this.noRekening, required this.isFinger, required this.noPin, required this.serialNo}) : super(key: key);


  @override
  HomeMenuState createState() => HomeMenuState();
}

class HomeMenuState extends State<MenuPPOBScreen> {
  HomeMenuState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }
  @override
  void initState() {
    super.initState();
    Constants.NO_REKENING = widget.noRekening;
    Constants.isFinger = widget.isFinger;
    Constants.PIN_TRANSAKSI = widget.noPin;
    Constants.SERIAL_NO = widget.serialNo;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 740),
      builder: (context, child) =>
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: AppColors.colorPrimary,
            ),
          ),
          home: Scaffold(
            appBar: CustomAppBar(
                context: context,
                title: "PPOB",
                onBackPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    SystemNavigator.pop();
                  }
                }),
            body: GridView.count(
              crossAxisCount: 3,
              padding: EdgeInsets.all(5),
              children: _menu(),
            ),
          ),

    ));
  }

  _menu<Widget>() => [
        _menuItem(Strings.pulsa_prabayar, Assets.ic_pulsa_prabayar, () {
        Future.delayed(Duration.zero, () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PulsaPrabayarScreen()));
          });
        }),
        _menuItem(Strings.pulsa_pascabayar, Assets.ic_pulsa_pascabayar, () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PulsaPascabayarScreen()));
        }),
        _menuItem(Strings.paket_data, Assets.ic_paket_data, () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PaketDataScreen()));
        }),
        _menuItem(Strings.token_listrik, Assets.ic_token_pln, () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TokenPlnScreen()));
        }),
        _menuItem(Strings.listrik, Assets.ic_listrik, () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TagihanPlnScreen()));
        }),
        _menuItem(Strings.telkom, Assets.ic_telkom, () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TelkomScreen()));
        }),
        _menuItem(Strings.pdam, Assets.ic_pdam, () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => PdamProductsScreen()));
        }),
        _menuItem(Strings.tv_berlangganan, Assets.ic_tv, () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => TvBerbayarScreen()));
        }),
        _menuItem(Strings.multi_finance, Assets.ic_multi_finance, () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MultifinanceScreen()));
        }),
        _menuItem(Strings.bpjs_kesehatan, Assets.ic_bpjs_kesehatan, () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BPJSScreen()));
        }),
        _menuItem(Strings.saldo_gopay, Assets.ic_gopay, () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SaldoGopayScreen()));
        }),
        _menuItem(Strings.saldo_ovo, Assets.ic_ovo, () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SaldoOvoScreen()));
        }),
        _menuItemItalic(Strings.saldo_emoney, Assets.ic_emoney, () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SaldoEmoneyScreen()));
        }),
        _menuItem(Strings.saldo_shopee, Assets.ic_shopee, () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SaldoShopeeScreen()));
        }),
        _menuItem(Strings.saldo_linkaja, Assets.ic_linkaja, () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SaldoLinkajaScreen()));
        }),
        _menuItem(Strings.saldo_dana, Assets.ic_dana, () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SaldoDanaScreen()));
          // showDialog(context: context, builder: (context)
          // => BasicConfirmDialogHome(
          //   text: "Maaf, Modul ini masih dalam proses pengembangan.", confirmText: "Ya",
          //   confirmOnPressed: (){
          //     Navigator.of(context).pop();
          //     // openAppSettings();
          //   },
          // ));
        }

        ),
        _menuItem(Strings.bayar_pajak, Assets.ic_pajak, () {
          /*showDialog(context: context, builder: (context)
          => BasicConfirmDialogHome(
            text: "Maaf, Modul ini masih dalam proses pengembangan.", confirmText: "Ya",
            confirmOnPressed: (){
              Navigator.of(context).pop();
              // openAppSettings();
            },
          ));*/
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => PbbProductsScreen()));
          showDialog(context: context, builder: (context)
          => BasicConfirmDialogHome(
            text: "Maaf, Modul ini masih dalam proses pengembangan.", confirmText: "Ya",
            confirmOnPressed: (){
              Navigator.of(context).pop();
              // openAppSettings();
            },
          ));
        }),
        _menuItem(Strings.asuransi, Assets.ic_asuransi, () {
          showDialog(context: context, builder: (context)
          => BasicConfirmDialogHome(
            text: "Maaf, Modul ini masih dalam proses pengembangan.",  confirmText: "Ya",
            confirmOnPressed: (){
              Navigator.of(context).pop();
              // openAppSettings();
            },
          ));
          /*Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SaldoDanaScreen()));*/
        }),
        _menuItem(Strings.internet, Assets.ic_internet, () {
          /*showDialog(context: context, builder: (context)
          => BasicConfirmDialogHome(
            text: "Maaf, Modul ini masih dalam proses pengembangan.", confirmText: "Ya",
            confirmOnPressed: (){
              Navigator.of(context).pop();
              // openAppSettings();
            },
          ));*/
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => InternetScreen()));
          /*Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SaldoDanaScreen()));*/
        }),
        _menuItem(Strings.kartu_kredit, Assets.ic_kartu_kredit, () {
          showDialog(context: context, builder: (context)
          => BasicConfirmDialogHome(
            text: "Maaf, Modul ini masih dalam proses pengembangan.", confirmText: "Ya",
            confirmOnPressed: (){
              Navigator.of(context).pop();
              // openAppSettings();
            },
          ));
          /*Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SaldoDanaScreen()));*/
        })
      ];

  Widget _menuItemItalic(String title, String imgPath, Function function) {
    return Card(
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageAsset(
                    imgPath: imgPath, fit: BoxFit.fitHeight, height: 40.w),
                height_8(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row( children: [
                    SizedBox(width: 26,),
                    Text(
                      "E-",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 14.sp),
                    ),
                    Text(
                      "Money",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 14.sp, fontStyle: FontStyle.italic),
                    ),
                  ],)
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => function(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(String title, String imgPath, Function function) {
    return Card(
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageAsset(
                    imgPath: imgPath, fit: BoxFit.fitHeight, height: 40.w),
                height_8(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 14.sp, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => function(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
