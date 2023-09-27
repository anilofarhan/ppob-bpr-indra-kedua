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
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/core/utils.dart';
import 'package:ppob/features/transaction/multifinance/bloc/multifinance_bloc.dart';
import 'package:ppob/features/transaction/multifinance/bloc/multifinance_event.dart';
import 'package:ppob/features/transaction/multifinance/bloc/multifinance_state.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/model/harga_pulsa_model.dart';

class MultifinanceScreen extends StatelessWidget {
  MultifinanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<InquiryMultifinanceBloc>(
        create: (context) => GetIt.I<InquiryMultifinanceBloc>(),
      ),
      BlocProvider<PaymentMultifinanceBloc>(
        create: (context) => GetIt.I<PaymentMultifinanceBloc>(),
      )
    ], child: _MultifinanceScreenLayout());
  }
}

class _MultifinanceScreenLayout extends StatefulWidget {
  const _MultifinanceScreenLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultifinanceScreenState();
}

class _MultifinanceScreenState extends State<_MultifinanceScreenLayout> {
  final noPonselController = TextEditingController();
  List<HargaPulsaModel> hargaPublisList = [];
  var isEnabledBtn = false;
  String? optionValue;

  @override
  void initState() {
    super.initState();
    initAction();
  }

  void initAction() {
    noPonselController.addListener(() {
      _enableBtn();
    });
  }

  void _enableBtn() {
    if (noPonselController.text.length >= 4 && optionValue != null) {
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
          BlocListener<InquiryMultifinanceBloc, BlocState>(
            listener: (context, state) {
              if (state is InquiryMultifinanceSuccessState) {
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
                      imageProductPath: Assets.ic_tv,
                      noPelanggan: noPonselController.text,
                      productName: optionValue,
                      deskripsi: content,
                    ),
                  );
                });*/

                var col1 = state.data.customerData!.replaceAll("\$", "").replaceAll("'", "").split("_");
                // var col1 = "161122163833 _SIMPATI_081287372727_10000_SN10-081287372727".split("_");
                String admin = col1[13].trim();
                if(col1[13]==null || col1[13]==""){
                  admin = "0";
                }
                String ss = "<div style='font-size:16px; padding:5px'>" +
                    "</div><table style='width:100%;'>"
                        "<tr style='padding-bottom:5px'><td>IDPEL</td>" +
                    "<td>\t\t:\t\t</td><td>" +
                    col1[1].trim() +
                    "</td></tr>" +
                    "<tr style='padding-bottom:5px'><td>NAMA</td><td>\t\t:\t\t</td><td>" +
                    col1[3] +
                    "</td></tr>" +
                    "<tr style='padding-bottom:5px'><td>NO POL</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[5] +
                    "</td>" +
                    "</tr>" +
                    "<tr style='padding-bottom:5px'><td>ANGSURAN KE</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[7] +
                    "</td>" +
                    "</tr>" +
                    "<tr style='padding-bottom:5px'><td>JATUH TEMPO</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[9] +
                    "</td>" +
                    "</tr>" +
                    "<tr style='padding-bottom:5px'><td>TAGIHAN</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[11].currencyFormat() +
                    "</td>" +
                    "</tr>" +
                    "<tr style='padding-bottom:5px'><td>ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
                    admin.currencyFormat() +
                    "</td>" +
                    "</tr>" +
                    "<tr style='padding-bottom:5px'><td>RP BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[15].currencyFormat() +
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
                    imageProductPath: Assets.ic_tv,
                    productName: optionValue,
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
          BlocListener<PaymentMultifinanceBloc, BlocState>(
            listener: (context, state) {
              if (state is PaymentMultifinanceSuccessState) {
                var data = state.data;
                var col1 = data.customerData?.trim().split("_");
                final dt = col1![0].trim().toDateTime();

                final ss = "<div style='width:100%;font-size:16px'><br/>" +
                    "<div style='font-size:22px;width:100%;text-align:center;'>" +
                    "TRANSAKSI SUKSES</div><br/><br/>Tanggal: " +
                    dt.dateFotmat(pattern: "dd/MM/yyyy HH:mm:ss") +
                    " WITA<br/><br/>" +
                    col1[2] +
                    "<br/><table style='width:100%;'><tr><td style='width:80px;'>PRODUK</td><td>\t\t:\t\t</td><td>" +
                    col1[1] +
                    "</td></tr><tr><td>NO PEL</td><td>\t\t:\t\t</td><td>" +
                    col1[3] +
                    "</td></tr><tr><td>NAMA</td><td>\t\t:\t\t</td><td>" +
                    col1[4] +
                    "</td></tr><tr><td>NO POL</td><td>\t\t:\t\t</td><td>" +
                    col1[5] +
                    "</td></tr><tr><td>KEND</td><td>\t\t:\t\t</td><td>" +
                    col1[6] +
                    "</td></tr><tr><td>ANGSURAN KE</td><td>\t\t:\t\t</td><td>" +
                    col1[7] +
                    "</td></tr><tr><td>TENOR</td><td>\t\t:\t\t</td><td>" +
                    col1[8] +
                    "</td></tr><tr><td>J TEMPO</td><td>\t\t:\t\t</td><td>" +
                    col1[9] +
                    "</td></tr><tr><td>SISA ANGSURAN</td><td>\t\t:\t\t</td><td>Rp." +
                    ((col1[10].trim() == "-")
                        ? "0"
                        : col1[10].trim().currencyFormat()) +
                    "</td></tr><tr><td>ANGSURAN</td><td>\t\t:\t\t</td><td>Rp." +
                    ((col1[11].trim() == "-")
                        ? "0"
                        : col1[11].trim().currencyFormat()) +
                    "</td></tr><tr><td>DENDA</td><td>\t\t:\t\t</td><td>Rp." +
                    ((col1[12].trim() == "-")
                        ? "0"
                        : col1[12].trim().currencyFormat()) +
                    "</td></tr><tr><td>BIAYA ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
                    ((col1[13].trim() == "-")
                        ? "0"
                        : col1[13].trim().currencyFormat()) +
                    "</td></tr><tr><td>LAINNYA</td><td>\t\t:\t\t</td><td>Rp." +
                    ((col1[14].trim() == "-")
                        ? "0"
                        : col1[14].trim().currencyFormat()) +
                    "</td></tr><tr><td>TOTAL TAGIHAN</td><td>\t\t:\t\t</td><td>Rp." +
                    ((col1[15].trim() == "-")
                        ? "0"
                        : col1[15].trim().currencyFormat()) +
                    "</td></tr><tr style='font-weight: bold;'><td>TOTAL BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
                    ((col1[16].trim() == "-")
                        ? "0"
                        : col1[16].trim().currencyFormat()) +
                    "</td></tr></table></div>";

                showDialog(
                  context: context,
                  builder: (context) => DialogPaymentSukses(
                    htmlStr: ss,
                    onTutupPressed: () {
                      Navigator.pop(context);
                    },
                    fileName: "ppob_multifinance_"+col1[2],
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
            title: Strings.multi_finance,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OptionProducts(
                                  hintText: "Pilih Produk",
                                  selectedValue: optionValue,
                                  menus: ["BAF", "MAF", "MCF", "WOM"],
                                  onSelectedListener: (selectedValue) {
                                    setState(() {
                                      optionValue = selectedValue;
                                      _enableBtn();
                                    });
                                  },
                                ),
                                height_10(),
                                InputNoPelanggan(
                                    iconPath: Assets.ic_multi_finance,
                                    title: Strings.nomor_pelanggan,
                                    controller: noPonselController,
                                    isPhoneContact: false),
                                height_20(),
                                ButtonRed(
                                  isEnabled: isEnabledBtn,
                                  title: Strings.lanjut,
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    _submitInquiry();
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
        ));
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
    BlocProvider.of<InquiryMultifinanceBloc>(context).add(
      InquiryMultifinanceEvent(
          noPelanggan: noPonselController.text, productCode: optionValue),
    );
  }

  void _submitPayment(String pin) {
    BlocProvider.of<PaymentMultifinanceBloc>(context).add(
      PaymentMultifinanceEvent(
          noPelanggan: noPonselController.text,
          productCode: optionValue,
          pin: pin),
    );
  }
}
