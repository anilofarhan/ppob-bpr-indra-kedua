import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/component/confirmation_html_dialog.dart';
import 'package:ppob/core/component/confirmation_product_dialog.dart';
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
import 'package:ppob/features/transaction/pln/tagihan/bloc/tagihan_pln_bloc.dart';

enum PLN { none, pascabayar, nonTaglis }

class TagihanPlnScreen extends StatelessWidget {
  const TagihanPlnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<TagihanPlnBloc>(
        create: (context) => GetIt.I<TagihanPlnBloc>(),
      ),
    ], child: const _TokenPlnLayout());
  }
}

class _TokenPlnLayout extends StatefulWidget {
  const _TokenPlnLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TagihanPlnScreenState();
}

class _TagihanPlnScreenState extends State<_TokenPlnLayout> {
  final nomerController = TextEditingController();

  LoadingController loadingController = LoadingController();
  int selectHargaToken = -1;
  final String provider = Constants.PLN;
  late TagihanPlnBloc _bloc;

  PLN _pln = PLN.none;
  RxBool enableButton = false.obs;

  @override
  void initState() {
    _bloc = BlocProvider.of<TagihanPlnBloc>(context);
    nomerController.addListener(() {
      if (_pln != PLN.none && nomerController.text.isNotEmpty) {
        enableButton.value = true;
      } else {
        enableButton.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TagihanPlnBloc, BlocState>(
      listener: (context, state) {
        if (state is InquiryTagihanPlnSuccessState) {
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
          var col1 = state.data[0].customerData!.replaceAll("\$", "").replaceAll("'", "").split("_");
          String ss = "<div style='font-size:16px; padding:5px'>" +
              "</div><table style='width:100%;'><tr style='padding-bottom:5px'><td style='width:100px;'>IDPEL</td><td>\t\t:\t\t</td>" +
              "<td>" +
              col1[1] +
              "</td></tr><tr style='padding-bottom:5px'><td>NAMA</td>" +
              "<td>\t\t:\t\t</td><td>" +
              col1[3].trim() +
              "</td></tr>" +
              "<tr style='padding-bottom:5px'><td>TARIF/DAYA</td><td>\t\t:\t\t</td><td>" +
              col1[5].trim() +
              "</td></tr>" +
              "<tr style='padding-bottom:5px'><td>Rp TAG. PLN</td><td>\t\t:\t\t</td><td>Rp." +
              col1[7].trim().currencyFormat() +
              "</td>" +
              "</tr>" +
              "<tr style='padding-bottom:5px'><td>BL/TH</td><td>\t\t:\t\t</td><td>" +
              col1[9] +
              "</td>" +
              "</tr>" +
              "<tr style='padding-bottom:5px'><td>STAND METER</td><td>\t\t:\t\t</td><td>" +
              col1[11] +
              "</td>" +
              "</tr>" +
              "<tr style='padding-bottom:5px'><td>ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
              col1[13].trim().currencyFormat() +
              "</td>" +
              "</tr>" +
              "<tr style='padding-bottom:5px'><td>TOTAL BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
              col1[15].trim().currencyFormat() +
              "</td>" +
              "</tr><tr style='width:100px;'><td>TRXID</td><td>\t\t:\t\t</td><td>" +
              state.data[0].trxid! +
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
              imageProductPath: providerImg(provider),
              productName: provider,
              noPelanggan: nomerController.text,
              onTutupPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        } else if (state is PaymentTagihanPlnSuccessState) {
          String content = _bloc.generatePaymentTagihanContent(state.data[0]);
          showDialog(
            context: context,
            builder: (context) => ConfirmationHtmlDialog(
              onSubmit: () async {
                Navigator.pop(context);
                _showInputFinger();
              },
              imageProductPath: providerImg(provider),
              noPelanggan: nomerController.text,
              productName: provider,
              deskripsi: content,
              showTutupButton: true,
            ),
          );
        } else if (state is InquiryPlnNontaglisSuccessState) {
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
          // print("state.data.customerData! "+state.data[0].customerData!);
          var col1 = state.data[0].customerData!.replaceAll("\$", "").replaceAll("'", "").split("_");
          String ss = "<div style='font-size:16px; padding:5px'>" +
              "</div><table style='width:100%;'><tr style='padding-bottom:5px'><td style='width:100px;'>NO. REGISTRASI</td><td>\t\t:\t\t</td>" +
              "<td>" +
              col1[1] +
              "</td></tr><tr style='padding-bottom:5px'><td>NAMA</td>" +
              "<td>\t\t:\t\t</td><td>" +
              col1[3].trim() +
              "</td></tr>" +
              "<tr style='padding-bottom:5px'><td>JENIS TRANSAKSI</td><td>\t\t:\t\t</td><td>" +
              col1[5] +
              "</td></tr>" +
              "<tr style='padding-bottom:5px'><td>TGL REGISTRASI</td><td>\t\t:\t\t</td><td>" +
              col1[7] +
              "</td>" +
              "</tr>" +
              "<tr style='padding-bottom:5px'><td>BIAYA PLN</td><td>\t\t:\t\t</td><td>Rp." +
              col1[9].trim().currencyFormat() +
              "</td>" +
              "</tr>" +
              "<tr style='padding-bottom:5px'><td>ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
              col1[11].trim().currencyFormat() +
              "</td>" +
              "</tr>" +
              "<tr style='padding-bottom:5px'><td>TOTAL BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
              col1[13].trim().currencyFormat() +
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
        } else if (state is PaymentPlnNontaglisSuccessState) {
          String content = _bloc.generatePaymentNontaglisContent(state.data[0]);
          showDialog(
            context: context,
            builder: (context) => DialogPaymentSukses(
              htmlStr: content,
              onTutupPressed: () {
                Navigator.pop(context);
              },
              fileName: "ppob_plntagihan_"+state.data[0].trxid!,
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
          title: "Listrik",
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
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          title: Text('PLN Pascabayar',
                                              style: Style.text12spBlack),
                                          contentPadding: EdgeInsets.zero,
                                          horizontalTitleGap: 0,
                                          leading: Radio<PLN>(
                                            value: PLN.pascabayar,
                                            groupValue: _pln,
                                            onChanged: (value) {
                                              setState(() {
                                                _pln = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text('PLN Non Tagihan',
                                              style: Style.text12spBlack),
                                          contentPadding: EdgeInsets.zero,
                                          horizontalTitleGap: 0,
                                          leading: Radio<PLN>(
                                            value: PLN.nonTaglis,
                                            groupValue: _pln,
                                            onChanged: (value) {
                                              setState(() {
                                                _pln = value!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            height_20(),
                            InputNoPelanggan(
                              iconPath: Assets.ic_listrik,
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
                                  switch (_pln) {
                                    case PLN.pascabayar:
                                      _submitInquiryTagihanPln();
                                      break;
                                    case PLN.nonTaglis:
                                      _submitInquiryPlnNotaglis();
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

  void _showInputPin() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return PinModalBottomSheetPPOB(
          pinListener: (pin) {
            switch (_pln) {
              case PLN.pascabayar:
                _submitPaymentTagihanPln(pin);
                break;
              case PLN.nonTaglis:
                _submitPaymentPlnNontaglis(pin);
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
    //         switch (_pln) {
    //           case PLN.pascabayar:
    //             _submitPaymentTagihanPln(pin);
    //             break;
    //           case PLN.nonTaglis:
    //             _submitPaymentPlnNontaglis(pin);
    //             break;
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
      // _submitPayment(value["response"]);
      switch (_pln) {
                case PLN.pascabayar:
                  _submitPaymentTagihanPln(value["response"]);
                  break;
                case PLN.nonTaglis:
                  _submitPaymentPlnNontaglis(value["response"]);
                  break;
                default:
                  break;
              }
    }
  }

  void _submitInquiryTagihanPln() {
    _bloc.add(
      InquiryTagihanPlnEvent(billCode: nomerController.text),
    );
  }

  void _submitPaymentTagihanPln(String pin) {
    _bloc.add(
      PaymentTagihanPlnEvent(
        billCode: nomerController.text,
        pin: pin,
      ),
    );
  }

  void _submitInquiryPlnNotaglis() {
    _bloc.add(
      InquiryPlnNontaglisEvent(billCode: nomerController.text),
    );
  }

  void _submitPaymentPlnNontaglis(String pin) {
    _bloc.add(
      PaymentPlnNontaglisEvent(
        billCode: nomerController.text,
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
