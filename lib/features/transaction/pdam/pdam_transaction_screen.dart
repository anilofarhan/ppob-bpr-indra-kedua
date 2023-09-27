// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/component/confirmation_product_dialog.dart';
import 'package:ppob/core/component/dialog_konfirmasi_sukses.dart';
import 'package:ppob/core/component/dialog_payment_sukses.dart';
import 'package:ppob/core/component/finger/finger_modal_dialog.dart';
import 'package:ppob/core/component/information_dialog.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/component/pin/pin_modal_dialog.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/core/utils.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_bloc.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_event.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_state.dart';

class PdamTransactionScreen extends StatelessWidget {
  String title;
  String kodeProduk;
  PdamTransactionScreen(
      {Key? key, required this.title, required this.kodeProduk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<InquiryPdamBloc>(
            create: (context) => GetIt.I<InquiryPdamBloc>(),
          ),
          BlocProvider<PaymentPdamBloc>(
            create: (context) => GetIt.I<PaymentPdamBloc>(),
          ),
        ],
        child: _PdamProductsLayout(
          kodeProduk: kodeProduk,
          title: title,
        ));
  }
}

class _PdamProductsLayout extends StatefulWidget {
  String title;
  String kodeProduk;
  _PdamProductsLayout({Key? key, required this.title, required this.kodeProduk})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PdamProductsScreenState();
}

class _PdamProductsScreenState extends State<_PdamProductsLayout> {
  final noPonselController = TextEditingController();
  bool isEnableBtn = false;
  late String product;
  late String title;

  @override
  void initState() {
    product = widget.kodeProduk;
    title = widget.title;
    super.initState();
    initAction();
  }

  void initAction() {
    noPonselController.addListener(() {
      if (noPonselController.text.length > 4) {
        setState(() {
          isEnableBtn = true;
        });
      } else {
        setState(() {
          isEnableBtn = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InquiryPdamBloc, BlocState>(
          listener: (context, state) {
            if (state is InquiryPdamSuccessState) {
              /*setState(() {
                String content = "Trx ID: ${state.data.trxid}\n\n"
                    "${state.data.customerData!.replaceToRp}";
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationProductDialog(
                    onSubmit: () async {
                      Navigator.pop(context);
                      _showInputPin();
                    },
                    imageProductPath: Assets.ic_pulsa_pascabayar,
                    noPelanggan: noPonselController.text,
                    productName: product,
                    deskripsi: content,
                  ),
                );
              });*/

              var col1 = state.data.customerData!.replaceAll("\$", "").replaceAll("'", "").split("_");
              String ss = "<div style='font-size:16px; padding:5px'>" +
                  "</div><table style='width:100%;'><tr style='padding-bottom:5px'><td style='width:100px;'>NAMA</td><td>\t\t:\t\t</td>" +
                  "<td>" +
                  col1[1] +
                  "</td></tr><tr style='padding-bottom:5px'><td>IDPEL</td>" +
                  "<td>\t\t:\t\t</td><td>" +
                  col1[3].trim() +
                  "</td></tr>" +
                  "<tr style='padding-bottom:5px'><td>BL/TH</td><td>\t\t:\t\t</td><td>" +
                  col1[5] +
                  "</td></tr>" +
                  "<tr style='padding-bottom:5px'><td>TAGIHAN</td><td>\t\t:\t\t</td><td>Rp." +
                  col1[7].currencyFormat() +
                  "</td>" +
                  "</tr>" +
                  "<tr style='padding-bottom:5px'><td>ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
                  col1[9].currencyFormat() +
                  "</td>" +
                  "</tr>" +
                  "<tr style='padding-bottom:5px'><td>RP BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
                  col1[11].currencyFormat() +
                  "</td>" +
                  "</tr><tr style='width:100px;'><td>TRXID</td><td>\t\t:\t\t</td><td>" +
                  state.data.trxid! +
                  "</td></tr></table></div>";

              showDialog(
                context: context,
                builder: (context) => DialogKonfirmasiSukses(
                  onSubmit: () async {
                    Navigator.pop(context);
                    // _showInputPin();
                    _showInputFinger();
                  },
                  htmlStr: ss,
                  imageProductPath: Assets.ic_pulsa_pascabayar,
                  productName: product,
                  noPelanggan: noPonselController.text,
                  onTutupPressed: () {
                    Navigator.pop(context);
                  },
                ),
              );
            } else if (state is HideLoadingState) {
              dismissProgressDialog(context);
            } else if (state is ShowLoadingState) {
              showProgressDialog(context);
            } else if (state is ErrorState) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      InformationFailedDialog(message: state.message ?? ""));
            }
          },
        ),
        BlocListener<PaymentPdamBloc, BlocState>(
          listener: (context, state) {
            if (state is PaymentPdamSuccessState) {
              setState(() {
                var data = state.data;
                var col1 = data.customerData?.trim().split("_");
                final dt = col1![0].trim().toDateTime();

                String ss = "<div style='width:100%;font-size:16px'><br/>" +
                    "<div style='font-size:22px;width:100%;text-align:center;'>TRANSAKSI SUKSES</div><br/><br/>Tanggal: " +
                    dt.dateFotmat(pattern: "dd/MM/yyyy HH:mm:ss") +
                    " WITA<br/" +
                    "><br/><table style='width:100%;'><tr><td style='width:80px;'>REF</td><td>\t\t:\t\t</td><td></td></tr><tr><td colspan='3'>" +
                    col1[7] +
                    "</td></tr><tr><td>INSTITUSI</td><td>\t\t:\t\t</td><td>" +
                    col1[1] +
                    "</td></tr><tr><td>NO REK</td><td>\t\t:\t\t</td><td>" +
                    col1[2] +
                    "</td></tr><tr><td>PERIODE</td><td>\t\t:\t\t</td><td>" +
                    col1[3] +
                    "</td></tr><tr><td>NAMA</td><td>\t\t:\t\t</td><td>" +
                    col1[4] +
                    "</td></tr><tr><td>TGL LUNAS</td><td>\t\t:\t\t</td><td>" +
                    col1[5].replaceAll("%", ":") +
                    "</td></tr><tr><td>TOTAL TAGIHAN</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[12].trim().currencyFormat() +
                    "</td></tr><tr><td>BIAYA ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[13].trim().currencyFormat() +
                    "</td></tr><tr style='font-weight: bold;'><td>TOTAL BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[14].trim().currencyFormat() +
                    "</td></tr></table></div>";

                showDialog(
                  context: context,
                  builder: (context) => DialogPaymentSukses(
                    htmlStr: ss,
                    onTutupPressed: () {
                      Navigator.pop(context, true);
                    },
                    fileName: "ppob_pdam_"+col1[7],
                  ),
                );
              });
            } else if (state is HideLoadingState) {
              dismissProgressDialog(context);
            } else if (state is ShowLoadingState) {
              showProgressDialog(context);
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
          title: title,
          elevation: false,
          context: context,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Stack(
                children: [
                  CurveHeader(height: 100.h),
                  Container(
                    padding: EdgeInsets.all(15.h),
                    width: double.infinity,
                    child: Column(
                      children: [
                        InputNoPelanggan(
                            iconPath: Assets.ic_pdam,
                            title: Strings.pln_nopel,
                            controller: noPonselController,
                            isPhoneContact: false),
                        height_40(),
                        ButtonRed(
                          isEnabled: isEnableBtn,
                          title: Strings.lanjut,
                          onPressed: () {
                            _submitInquiry();
                          },
                          width: double.infinity,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
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

  void _submitInquiry() {
    BlocProvider.of<InquiryPdamBloc>(context).add(
      InquiryPdamEvent(
        noPelanggan: noPonselController.text,
        pdamCode: product,
      ),
    );
  }

  void _submitPayment(String pin) async {
    BlocProvider.of<PaymentPdamBloc>(context).add(
      PaymentPdamEvent(
        noPelanggan: noPonselController.text,
        pdamCode: product,
        pin: pin,
      ),
    );
  }
}
