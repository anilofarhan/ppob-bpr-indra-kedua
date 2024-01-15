// ignore_for_file: prefer_const_constructors

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
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/core/model/prefix_pulsa_model.dart';
import 'package:ppob/core/utilities/pulsa_provider_util.dart';
import 'package:ppob/core/utils.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/bloc/pulsa_pascabayar_bloc.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/bloc/pulsa_pascabayar_event.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/bloc/pulsa_pascabayar_state.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/bloc/pulsa_prabayar_bloc.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/bloc/pulsa_prabayar_state.dart';

class PulsaPascabayarScreen extends StatelessWidget {
  PulsaPascabayarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<InquiryPulsaPascabayarBloc>(
        create: (context) => GetIt.I<InquiryPulsaPascabayarBloc>(),
      ),
      BlocProvider<PaymentPulsaPascabayarBloc>(
        create: (context) => GetIt.I<PaymentPulsaPascabayarBloc>(),
      )
    ], child: _PulsaPascabayarLayout());
  }
}

class _PulsaPascabayarLayout extends StatefulWidget {
  const _PulsaPascabayarLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PulsaPascabayarScreenState();
}

class _PulsaPascabayarScreenState extends State<_PulsaPascabayarLayout> {
  final noPonselController = TextEditingController();
  PrefixPulsaModel? prefix;
  String product = "";
  bool isEnableBtn = false;

  @override
  void initState() {
    super.initState();
    initAction();
  }

  void initAction() {
    noPonselController.addListener(() {
      if (noPonselController.text.length > 9) {
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
        BlocListener<InquiryPulsaPascabayarBloc, BlocState>(
          listener: (context, state) {
            if (state is InquiryPulsaPascabayarSuccessState) {
              // setState(() {
              //   String content = "Trx ID: ${state.data.trxid}\n\n"
              //       "${state.data.customerData!.replaceToRp}";
              //   showDialog(
              //     context: context,
              //     builder: (context) => ConfirmationProductDialog(
              //       onSubmit: () async {
              //         Navigator.pop(context);
              //         _showInputPin();
              //       },
              //       imageProductPath: Assets.ic_pulsa_pascabayar,
              //       noPelanggan: noPonselController.text,
              //       productName: product,
              //       deskripsi: content,
              //     ),
              //   );
              // });
              // var col1 = "161122163833 _SIMPATI_081287372727_10000_SN10-081287372727".split("_");
              // final dt = col1![0].trim().toDateTime();

              /*String ss = "<div style='width:100%;font-size:16px'><br/>" +
                  "<div style='font-size:22px;width:100%;text-align:center;'>TRANSAKSI SUKSES</div>" +
                  "<br/><br/>Tanggal: " +
                  dt.dateFotmat(pattern: "dd/MM/yyyy HH:mm:ss") +
                  " WITA<br/><br/><div style='font-weight: bold;'>" +
                  data.produk! +
                  "</div><br/><table style='width:100%;'><tr><td style='width:100px;'>PRODUK</td><td>\t\t:\t\t</td>" +
                  "<td>" +
                  col1[1] +
                  "</td></tr><tr><td>DENOM</td>" +
                  "<td>\t\t:\t\t</td><td>" +
                  col1[3].trim().currencyFormat() +
                  "</td></tr>" +
                  "<tr><td>NO PONSEL</td><td>\t\t:\t\t</td><td>" +
                  col1[2] +
                  "</td></tr>" +
                  "<tr><td>TOTAL BAYAR</td><td>\t\t:\t\t</td><td> Rp " +
                  data.billAmount!.currencyFormat() +
                  "</td>" +
                  "</tr><tr><td>KODE TRX</td><td>\t\t:\t\t</td><td></td></tr><tr><td colspan='3'>" +
                  data.trxid! +
                  "</td></tr></table></div>";*/
              var col1 = state.data.customerData!.replaceAll("\$", "").replaceAll("'", "").split("_");
              // print("text "+state.data[0].customerData!.replaceAll("\$", "").replaceAll("'", ""));
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
                  "<tr style='padding-bottom:5px'><td>BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
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
        BlocListener<PaymentPulsaPascabayarBloc, BlocState>(
          listener: (context, state) {
            if (state is PaymentPulsaPascabayarSuccessState) {
              var data = state.data;
              var col1 = data.customerData?.trim().split("_");

              //hereppob
              // final dt = col1![0].trim().toDateTime();
              List<String> tgl = col1![0].formatDateTime12String().split(" ");

              String ss = "<div style='width:100%;font-size:16px'><br/><div style='font-size:22px;width:100%;text-align:center;'>" +
                  "TRANSAKSI SUKSES</div><br/>"
                  "<br/>"
                  //hereppob
                  // "Tanggal: " +
                  // dt.dateFotmat(pattern: "dd/MM/yyyy HH:mm:ss") +
                  // " WITA<br/>"
                  "<div style='text-align:center;'>"
                  "<br/>Tanggal: ${tgl[0]}<br/>"
                  "Jam: ${tgl[1]} WITA<br/></div>"
                  "<br/>"
                  "<table style='width:100%;'><tr><td style='width:80px;'>REF</td><td>\t\t:\t\t</td><td></td></tr><tr><td colspan='3'>" +
                  col1[6] +
                  "</td></tr><tr><td>OPERATOR</td><td>\t\t:\t\t</td><td>" +
                  col1[1] +
                  "</td></tr><tr><td>NO. PONSEL</td><td>\t\t:\t\t</td><td>" +
                  col1[2] +
                  "</td></tr><tr><td>NAMA</td><td>\t\t:\t\t</td><td>" +
                  col1[3] +
                  "</td></tr><tr><td>NO. RESI</td><td>\t\t:\t\t</td><td>" +
                  col1[4] +
                  "</td></tr><tr><td>TOTAL TAGIHAN</td><td>\t\t:\t\t</td><td>Rp." +
                  col1[7].trim().currencyFormat() +
                  "</td></tr><tr><td>BIAYA ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
                  col1[8].trim().currencyFormat() +
                  "</td></tr><tr style='font-weight: bold;'><td>TOTAL BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
                  col1[9].trim().currencyFormat() +
                  "</td></tr></table></div>";

              showDialog(
                context: context,
                builder: (context) => DialogPaymentSukses(
                  htmlStr: ss,
                  onTutupPressed: () {
                    Navigator.pop(context);
                  },
                  fileName: "ppob_pulsapasca_"+col1[6],
                ),
              );
            } else if (state is ShowLoadingState) {
              showProgressDialog(context);
            } else if (state is HideLoadingState) {
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
          title: Strings.pulsa_pascabayar,
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
                        CurveHeader(height: 100.h),
                        Container(
                          padding: EdgeInsets.all(15.h),
                          width: double.infinity,
                          child: Column(
                            children: [
                              InputNoPelanggan(
                                  iconPath: Assets.ic_pulsa_pascabayar,
                                  title: Strings.nomor_ponsel,
                                  hintText: "0857xxx",
                                  controller: noPonselController,
                                  isPhoneContact: true,
                                  onContactValue: (contact) {
                                    setState(() {
                                      noPonselController.text = contact;
                                    });
                                  }),
                              height_30(),
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

  void _submitInquiry() {
    _getProduct();
    BlocProvider.of<InquiryPulsaPascabayarBloc>(context).add(
      InquiryPulsaPascabayarEvent(
        noHp: noPonselController.text,
        product: product,
      ),
    );
  }

  void _submitPayment(String pin) async {
    _getProduct();
    BlocProvider.of<PaymentPulsaPascabayarBloc>(context).add(
      PaymentPulsaPascabayarEvent(
        noHp: noPonselController.text,
        pin: pin,
        product: product,
      ),
    );
  }

  void _getProduct() {
    prefix =
        PulsaProviderUtil.prefixModel[noPonselController.text.substring(0, 4)];
    setState(() {
      switch (prefix!.product) {
        case Constants.IM3:
          product = "INDOSAT";
          break;
        case Constants.MENTARI:
          product = "INDOSAT";
          break;
        case Constants.TRI:
          product = "TRI";
          break;
        case Constants.AS:
          product = "TELKOMSEL";
          break;
        case Constants.SIMPATI:
          product = "TELKOMSEL";
          break;
        case Constants.AXIS:
          product = "AXIS";
          break;
        case Constants.XL:
          product = "XL";
          break;
        case Constants.SMART:
          product = "SMARTFREN";
          break;
      }
    });
  }

  Widget imageProvider() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: ImageAsset(
          imgPath: providerPulsaImg(prefix!.prefix),
          height: 25.h,
          fit: BoxFit.fitHeight),
    );
  }
}
