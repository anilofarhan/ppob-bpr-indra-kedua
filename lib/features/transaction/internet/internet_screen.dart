import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/component/dialog_konfirmasi_sukses.dart';
import 'package:ppob/core/component/dialog_payment_sukses.dart';
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
import 'package:ppob/features/transaction/internet/bloc/internet_bloc.dart';

enum INTERNET { none, indihome, firstmedia}

class InternetScreen extends StatelessWidget {
  const InternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<InternetBloc>(
        create: (context) => GetIt.I<InternetBloc>(),
      ),
    ], child: const _TokenPlnLayout());
  }
}

class _TokenPlnLayout extends StatefulWidget {
  const _TokenPlnLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InternetScreenState();
}

class _InternetScreenState extends State<_TokenPlnLayout> {
  final nomerController = TextEditingController();

  LoadingController loadingController = LoadingController();
  int selectHargaToken = -1;
  final String provider = Constants.INTERNET;
  late InternetBloc _bloc;

  INTERNET _internet = INTERNET.none;
  RxBool enableButton = false.obs;

  @override
  void initState() {
    _bloc = BlocProvider.of<InternetBloc>(context);
    nomerController.addListener(() {
      if (_internet != INTERNET.none && nomerController.text.isNotEmpty) {
        enableButton.value = true;
      } else {
        enableButton.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, BlocState>(
      listener: (context, state) {
        if (state is InquiryInternetSuccessState) {
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
          var col1 = state.data[0].customerData!.replaceAll("\$", "").replaceAll("'", "").split("_");
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
              state.data[0].trxid! +
              "</td></tr></table></div>";
          String name = "";
          if(_internet.name=="firstmedia"){
            name = "FIRSTMEDIA";
          } else {
            name = "INDIHOME";
          }
          showDialog(
            context: context,
            builder: (context) => DialogKonfirmasiSukses(
              onSubmit: () async {
                Navigator.pop(context);
                // _showInputPin();
                _showInputFinger();
              },
              htmlStr: ss,
              imageProductPath: providerImg(provider),
              productName: name,
              noPelanggan: nomerController.text,
              onTutupPressed: () {
                Navigator.pop(context);
              },
            ),
          );
          // String content = "Trx ID: ${state.data[0].trxid}\n\n"
          //     "${state.data[0].customerData!.replaceToRp}";
          // showDialog(
          //   context: context,
          //   builder: (context) => ConfirmationProductDialog(
          //     onSubmit: () async {
          //       Navigator.pop(context);
          //       _showInputPin();
          //     },
          //     imageProductPath: providerImg(provider),
          //     noPelanggan: nomerController.text,
          //     productName: provider,
          //     deskripsi: content,
          //   ),
          // );
        } else if (state is PaymentInternetSuccessState) {
          String content = "";
          String fileName = "";
          if (state.data[0].produk!.toLowerCase() == "indihome") {
            content = _bloc.generatePaymentIndiHomeContent(state.data[0]);
            List<String> col1 = state.data[0].customerData!.replaceAll("\$", "").replaceAll("'", "").trim().split("_");
            fileName = col1[10];
          } else {
            content = _bloc.generatePaymentFirstMediaContent(state.data[0]);
            List<String> col1 = state.data[0].customerData!.replaceAll("\$", "").replaceAll("'", "").trim().split("_");
            fileName = col1[10];
          }

          showDialog(
            context: context,
            builder: (context) => DialogPaymentSukses(
              htmlStr: content,
              onTutupPressed: () {
                Navigator.pop(context);
              },
              fileName: "ppob_internet_"+fileName,
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
        } else if (state is SessionExpiredState) {
          loadingController
              .showMsgOnly(state.message ?? Strings.terjadi_kesalahan);
          setState(() {});
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: "Internet",
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
                        padding: EdgeInsets.fromLTRB(10.h, 15.h, 10.h, 15.h),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  title(),
                                  const Divider(height: 1, thickness: 1),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Radio<INTERNET>(
                                            value: INTERNET.indihome,
                                            groupValue: _internet,
                                            onChanged: selectTelkomOption,
                                          ),
                                          Text('INDIHOME',
                                              style: Style.text12spBlack),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Radio<INTERNET>(
                                            value: INTERNET.firstmedia,
                                            groupValue: _internet,
                                            onChanged: selectTelkomOption,
                                          ),
                                          Text('FIRSTMEDIA',
                                              style: Style.text12spBlack),
                                        ],
                                      ),

                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            height_20(),
                            InputNoPelanggan(
                              iconPath: Assets.ic_internet,
                              title: Strings.nomor_pelanggan,
                              hintText: "",
                              controller: nomerController,
                              isPhoneContact: false,
                            ),
                            height_10(),
                            LoadingView(
                              loadingController: loadingController,
                            ),
                            height_10(),
                            Obx(() {
                              return ButtonRed(
                                isEnabled: enableButton.value,
                                title: Strings.lanjut,
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  switch (_internet) {
                                    case INTERNET.indihome:
                                      _submitInquiryTelkom("Speedy");
                                      break;
                                    case INTERNET.firstmedia:
                                      _submitInquiryTelkom("FIRSTMEDIA");
                                      break;
                                    default:
                                      break;
                                  }
                                },
                                width: double.infinity,
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void selectTelkomOption(value) {
    setState(() {
      _internet = value!;
    });
  }

  void _showInputPin() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return PinModalBottomSheetPPOB(
          pinListener: (pin) {
            switch (_internet) {
              case INTERNET.indihome:
                _submitPaymentTelkom("Speedy", pin);
                break;
              case INTERNET.firstmedia:
                _submitPaymentTelkom("FIRSTMEDIA", pin);
                break;

              default:
                break;
            }
          },
        );
      },
    );
  }

  void _showInputFinger() async {
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (context) {
    //     return FingerModalBottomSheetPPOB(
    //       fingerListener: (pin) {
    //         switch (_internet) {
    //           case INTERNET.indihome:
    //             _submitPaymentTelkom("Speedy", pin);
    //             break;
    //           case INTERNET.firstmedia:
    //             _submitPaymentTelkom("FIRSTMEDIA", pin);
    //             break;
    //
    //           default:
    //             break;
    //         }
    //       },
    //     );
    //   },
    // );

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
      switch (_internet) {
                case INTERNET.indihome:
                  _submitPaymentTelkom("Speedy", value["response"]);
                  break;
                case INTERNET.firstmedia:
                  _submitPaymentTelkom("FIRSTMEDIA", value["response"]);
                  break;

                default:
                  break;
              }
            }



  }

  void _submitInquiryTelkom(String product) {
    _bloc.add(
      InquiryInternetEvent(billCode: nomerController.text, produk: product),
    );
  }

  void _submitPaymentTelkom(String product, String pin) {
    _bloc.add(
      PaymentInternetEvent(
        billCode: nomerController.text,
        produk: product,
        pin: pin,
      ),
    );
  }

  Widget title() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
      child: Text('Bayar Tagihan', style: Style.text14spGreyBold),
    );
  }
}
