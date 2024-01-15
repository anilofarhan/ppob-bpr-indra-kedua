// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/component/confirmation_product_dialog.dart';
import 'package:ppob/core/component/dialog_payment_sukses.dart';
import 'package:ppob/core/component/information_dialog.dart';
import 'package:ppob/core/component/loading_view.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/component/pin/pin_modal_dialog.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/constant/style.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/core/utils.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/bloc/pulsa_prabayar_bloc.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/bloc/pulsa_prabayar_event.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/bloc/pulsa_prabayar_state.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/model/harga_pulsa_model.dart';

import '../../../core/component/finger/finger_modal_dialog.dart';

class SaldoDanaScreen extends StatelessWidget {
  SaldoDanaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<HargaPulsaPublicBloc>(
        create: (context) => GetIt.I<HargaPulsaPublicBloc>(),
      ),
      BlocProvider<PaymentPulsaPrabayarBloc>(
        create: (context) => GetIt.I<PaymentPulsaPrabayarBloc>(),
      )
    ], child: _SaldoDanaScreenLayout());
  }
}

class _SaldoDanaScreenLayout extends StatefulWidget {
  const _SaldoDanaScreenLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SaldoDanaScreenState();
}

class _SaldoDanaScreenState extends State<_SaldoDanaScreenLayout> {
  final noPonselController = TextEditingController();
  List<HargaPulsaModel> hargaPublisList = [];
  LoadingController loadingController = LoadingController();
  int selectHargaPulsa = -1;
  var isEnabledBtn = false;
  final produk = "DANA";

  @override
  void initState() {
    super.initState();
    initAction();
  }

  void initAction() {
    noPonselController.addListener(() {
      _enableBtn();
    });
    BlocProvider.of<HargaPulsaPublicBloc>(context)
        .add(HargaPulsaPublicEvent(provider: produk));
  }

  void _enableBtn() {
    if (noPonselController.text.length >= 4 && selectHargaPulsa > -1) {
      setState(() {
        isEnabledBtn = true;
      });
    } else {
      setState(() {
        isEnabledBtn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HargaPulsaPublicBloc, BlocState>(
          listener: (context, state) {
            if (state is HargaPulsaSuccessState) {
              //
              // var col1 = "220523145117 _DANA_088973966368_20000_230522GM11494857".split("_");
              // print("dana ya "+data.customerData!+" - "+col1![0]);

              // List<String> col1 = data.customerData!.replaceAll("\$", "").replaceAll("'", "").trim().split("_");
              // List<String> col1 = "231122131357 _TELEPON_02175910000_DUM""MY TELKOM IPN-01_JPA            :_-___JAN 2014-      46.35500____46355_3000__'49355_".replaceAll("\$", "").replaceAll("'", "").trim().split("_");
              // List<String> col1 = "221122174344 _TELEPON_02175910000_DUM""MY TELKOM IPN-01_JPA            :_-___JAN 2014-      46.35500____46355_3000__'49355_".replaceAll("\$", "").replaceAll("'", "").trim().split("_");
              // print("data2 "+col1[0]+" "+col1[1]+" "+" "+col1[2]+" "+" "+col1[3]+" "+" "+col1[4]+" "+" "+col1[5]+" "+" "+col1[6]+" "+" "+col1[7]+" "+" "+col1[8]+" "+" "+col1[9]+" ");



              setState(() {
                hargaPublisList.clear();
                hargaPublisList.addAll(state.datas);
              });
            } else if (state is HargaNotfoundState) {
              loadingController
                  .showMsgOnly(state.message ?? Strings.terjadi_kesalahan);
              setState(() {});
            } else if (state is HideLoadingState) {
              loadingController.hideLoading();
              setState(() {});
            } else if (state is ShowLoadingState) {
              loadingController.showLoading();
              setState(() {});
            } else if (state is ErrorState) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      InformationFailedDialog(message: state.message ?? ""));
            }
          },
        ),
        BlocListener<PaymentPulsaPrabayarBloc, BlocState>(
          listener: (context, state) {
            if (state is PaymentPulsaSuccessState) {
              var data = state.datas[0];
              var col1 = data.customerData?.trim().split("_");

              //hereppob
              // String tgl = col1![0].formatDateTime12String();
              List<String> tgl = col1![0].formatDateTime12String().split(" ");

              // List<String> tgl2 = tgl.split(" ");
              String ss = "<div style='width:100%;font-size:16px; padding:5px;'><br/>"
                  "<div style='font-size:22px;width:100%;text-align:center; padding-bottom:2px;'>TRANSAKSI SUKSES</div>"
                  "<br/>"
                  //hereppob
                  // "<div style='text-align:center;'>Tanggal: $tgl WITA<br/>"
                  // "</div>" +
                  "<div style='text-align:center;'>"
                  "<br/>Tanggal: ${tgl[0]}<br/>"
                  "Jam: ${tgl[1]} WITA<br/></div>"
                  "<br/>"
                  "<div style='text-align:center;font-weight: bold;padding-bottom:5px;'>TOP UP SALDO " +
                  col1[1] +
                  "</div><br/>" +
                  "<table style='width:100%;font-size:14px;padding-left:5px;padding-bottom:5px;padding-top:5px;'>" +
                  "<tr style='padding-bottom:5px;'><td style='width:80px;'>REF</td><td>\t\t:\t\t</td>" +
                  "<td>" +
                  col1[4] +
                  "</td></tr>" +
                  "<tr style='padding-bottom:5px;' ><td>NO PELANGGAN</td><td>\t\t:\t\t</td><td>" +
                  col1[2] +
                  "</td></tr>" +
                  "<tr><td>SALDO</td><td>\t\t:\t\t</td><td>" +
                  col1[3].trim().currencyFormat() +
                  "</td></tr>" +
                  "</table></div>";

              showDialog(
                context: context,
                builder: (context) => DialogPaymentSukses(
                  htmlStr: ss,
                  onTutupPressed: () {
                    Navigator.pop(context);
                  },
                  fileName: "ppob_dana_"+col1[4],
                ),
              );
            } else if (state is PaymentPulsaShowLoadingState) {
              showProgressDialog(context);
            } else if (state is PaymentPulsaHideLoadingState) {
              dismissProgressDialog(context);
            } else if (state is ErrorState) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      InformationFailedDialog(message: state.message ?? ""));
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: Strings.topup_dana,
          elevation: false,
          context: context,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CurveHeader(height: 120.h),
                        Container(
                          padding: EdgeInsets.all(15.h),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Masukkan nomor ponsel yang terdaftar pada aplikasi Dana",
                                style: Style.text11spWhite,
                              ),
                              InputNoPelanggan(
                                  iconPath: Assets.ic_dana,
                                  title: Strings.nomor_ponsel,
                                  hintText: "0857xxx",
                                  controller: noPonselController,
                                  isPhoneContact: true,
                                  onContactValue: (contact) {
                                    setState(() {
                                      noPonselController.text = contact;
                                    });
                                  }),
                              height_10(),
                              LoadingView(
                                loadingController: loadingController,
                              ),
                              Visibility(
                                  visible: hargaPublisList.isNotEmpty,
                                  child: Card(
                                    elevation: 5,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        imageProvider(),
                                        Container(
                                          color: Colors.grey[100],
                                          child: GridView.count(
                                            mainAxisSpacing: 1,
                                            crossAxisSpacing: 1,
                                            childAspectRatio: 1 / 0.5,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            crossAxisCount: 2,
                                            padding: EdgeInsets.all(1),
                                            children: _itemHargaPulsa(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              height_20(),
                              ButtonRed(
                                isEnabled: isEnabledBtn,
                                title: Strings.lanjut,
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        ConfirmationProductDialog(
                                      onSubmit: () async {
                                        Navigator.pop(context);
                                        // _showInputPin();
                                        _showInputFinger();
                                      },
                                      imageProductPath: Assets.ic_dana,
                                      noPelanggan: noPonselController.text,
                                      productName: produk,
                                      deskripsi:
                                          "Top up saldo $produk ${hargaPublisList[selectHargaPulsa].kodeProduk!.currencyFormat()}\nHarga : ${hargaPublisList[selectHargaPulsa].hargaPublic!.currencyFormat2()}",
                                    ),
                                  );
                                },
                                width: double.infinity,
                              ),
                              height_10(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void _showInputPin() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return PinModalBottomSheetPPOB(
          pinListener: (pin) {
            _submitPayment(pin);
          },
        );
      },
    );
  }

  void _showInputFinger() async {
    Map<String, dynamic> value = Map();
    value = await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FingerModalBottomSheetPPOB();
      },
    );

    if(value!=null && value["response"]!=""){
      _submitPayment(value["response"]);

    }
  }

  void _submitPayment(String pin) {
    BlocProvider.of<PaymentPulsaPrabayarBloc>(context).add(
      PaymentPulsaPrabayarEvent(
        noHp: noPonselController.text,
        nominal: hargaPublisList[selectHargaPulsa].kodeProduk,
        pin: pin,
        product: produk,
      ),
    );
  }

  List<Widget> _itemHargaPulsa() {
    List<Widget> l = [];
    for (int i = 0; i < hargaPublisList.length; i++) {
      var value = hargaPublisList[i];
      l.add(widgetItem(value, i));
    }

    return l;
  }

  Widget widgetItem(HargaPulsaModel value, int index) {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          setState(() {
            selectHargaPulsa = index;
            _enableBtn();
          });
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(3.w),
          decoration: selectHargaPulsa == index
              ? BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 0),
                    ),
                  ],
                )
              : BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value.kodeProduk!.currencyFormat(),
                style: selectHargaPulsa == index
                    ? Style.text18spBlueBold
                    : Style.text14spBlackBold,
              ),
              height_5(),
              Text(
                value.hargaPublic!.currencyFormat2(),
                style: selectHargaPulsa == index
                    ? Style.text14spBlueBold
                    : Style.text14spGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProvider() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Text(
          Strings.denominasi.toUpperCase(),
          style: Style.text18spGreyBold,
        ));
  }
}
