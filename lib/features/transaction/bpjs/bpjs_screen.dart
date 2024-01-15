import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/component/confirmation_html_dialog.dart';
import 'package:ppob/core/component/dialog_konfirmasi_sukses.dart';
import 'package:ppob/core/component/finger/finger_modal_dialog.dart';
import 'package:ppob/core/component/information_dialog.dart';
import 'package:ppob/core/component/loading_view.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/component/pin/pin_modal_dialog.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/constant/style.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/core/utils.dart';
import 'package:ppob/features/transaction/bpjs/bloc/bpjs_bloc.dart';

class BPJSScreen extends StatelessWidget {
  const BPJSScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<BPJSBloc>(
        create: (context) => GetIt.I<BPJSBloc>(),
      ),
    ], child: const _BPJSLayout());
  }
}

class _BPJSLayout extends StatefulWidget {
  const _BPJSLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BPJSScreenState();
}

class _BPJSScreenState extends State<_BPJSLayout> {
  final nomerController = TextEditingController();
  LoadingController loadingController = LoadingController();
  late BPJSBloc _bloc;
  String provider = Constants.BPJSKS;
  RxBool enableButton = false.obs;

  @override
  void initState() {
    _bloc = BlocProvider.of<BPJSBloc>(context);
    super.initState();
    nomerController.addListener(() {
      if (nomerController.text.isNotEmpty) {
        enableButton.value = true;
      } else {
        enableButton.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<BPJSBloc, BlocState>(
            listener: (context, state) {
              if (state is InquiryBPJSSuccessState) {
                /*String content = "Trx ID: ${state.data[0].trxid}\n\n"
                    "${state.data[0].customerData!.replaceToRp}";
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationProductDialog(
                    onSubmit: () async {
                      Navigator.pop(context);
                      _showInputPin();
                    },
                    imageProductPath: providerImg(provider),
                    noPelanggan: nomerController.text,
                    productName: provider,
                    deskripsi: content,
                  ),
                );*/
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

                var col1 = state.data[0].customerData!.replaceAll("\$", "").replaceAll("'", "").split("_");
                // var col1 = "161122163833 _SIMPATI_081287372727_10000_SN10-081287372727".split("_");
                // print("text "+state.data[0].customerData!.replaceAll("\$", "").replaceAll("'", ""));
                String ss = "<div style='font-size:16px; padding:5px'>" "</div><table style='width:100%;'>"
                    "<tr style='padding-bottom:5px'><td>IDPEL</td>" "<td>\t\t:\t\t</td><td>" +
                    col1[1].trim() +
                    "</td></tr>" +
                    "<tr style='padding-bottom:5px'><td>NAMA</td><td>\t\t:\t\t</td><td>" +
                    col1[3] +
                    "</td></tr>" +
                    "<tr style='padding-bottom:5px'><td>TAGIHAN</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[5].currencyFormat() +
                    "</td>" +
                    "</tr>" +
                    "<tr style='padding-bottom:5px'><td>ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[7].currencyFormat() +
                    "</td>" +
                    "</tr>" +
                    "<tr style='padding-bottom:5px'><td>RP BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
                    col1[9].currencyFormat() +
                    "</td>" +
                    "</tr><tr style='width:100px;'><td>TRXID</td><td>\t\t:\t\t</td><td>" +
                    state.data[0].trxid! +
                    "</td></tr></table></div>";

                showDialog(
                  context: context,
                  builder: (context) => DialogKonfirmasiSukses(
                    onSubmit: () async {
                      Navigator.pop(context);
                      _showInputFinger();
                      // _showInputPin();
                    },
                    htmlStr: ss,
                    imageProductPath: providerImg(provider),
                    productName: provider,
                    noPelanggan: nomerController.text,
                    onTutupPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              } else if (state is PaymentBPJSSuccessState) {
                String content = _bloc.generateDetailContent(state.data[0]);
                // print("kontent "+content);
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationHtmlDialog(
                    onSubmit: () async {
                      Navigator.pop(context);
                      // _showInputPin();
                      _showInputFinger();
                    },
                    imageProductPath: providerImg(provider),
                    noPelanggan: nomerController.text,
                    productName: provider,
                    deskripsi: content,
                    showTutupButton: true,
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
              } else if (state is SessionExpiredState) {
                loadingController
                    .showMsgOnly(state.message ?? Strings.terjadi_kesalahan);
                setState(() {});
              }
            },
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: Strings.bpjs_kesehatan,
            elevation: false,
            context: context,
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: const BoxConstraints(),
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
                                    iconPath: Assets.ic_bpjs_kesehatan,
                                    title: Strings.nomor_pelanggan,
                                    hintText: "",
                                    controller: nomerController,
                                    isPhoneContact: false,
                                  ),
                                  height_10(),
                                  LoadingView(
                                    loadingController: loadingController,
                                  ),
                                  height_20(),
                                  Obx(() {
                                    return ButtonRed(
                                      isEnabled: enableButton.value,
                                      title: Strings.lanjut,
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        _submitInquiry();
                                      },
                                      width: double.infinity,
                                    );
                                  }),
                                  height_50(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))),
          ),
        ));
  }

  void _showInputPin() async {
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
    Map<String, dynamic> value = {};
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
    String nopel = kReleaseMode
        ? setPrefixNopel(nomerController.text)
        : nomerController.text;
    _bloc.add(
      InquiryBPJSEvent(billCode: nopel),
    );
  }

  void _submitPayment(String pin) {
    print("payment "+pin);
    String nopel = kReleaseMode
        ? setPrefixNopel(nomerController.text)
        : nomerController.text;
    _bloc.add(
      PaymentBPJSEvent(
        billCode: nopel,
        pin: pin,
      ),
    );
  }

  String setPrefixNopel(String nopel) {
    if (nopel.length == 13) {
      return "000" + nopel;
    } else if (nopel.length == 11) {
      return "88888" + nopel;
    } else {
      return nopel;
    }
  }

  Widget title() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Text('BPJS Kesehatan', style: Style.text18spGreyBold),
    );
  }
}
