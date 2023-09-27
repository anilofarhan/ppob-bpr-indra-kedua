// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/component/confirmation_product_dialog.dart';
import 'package:ppob/core/component/dialog_payment_sukses.dart';
import 'package:ppob/core/component/finger/finger_modal_dialog.dart';
import 'package:ppob/core/component/information_dialog.dart';
import 'package:ppob/core/component/loading_view.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/component/pin/pin_modal_dialog.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/constant/style.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/core/model/prefix_pulsa_model.dart';
import 'package:ppob/core/utilities/pulsa_provider_util.dart';
import 'package:ppob/core/utils.dart';

import 'bloc/pulsa_prabayar_bloc.dart';
import 'bloc/pulsa_prabayar_event.dart';
import 'bloc/pulsa_prabayar_state.dart';
import 'model/harga_pulsa_model.dart';

class PulsaPrabayarScreen extends StatelessWidget {
  PulsaPrabayarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("masuk PulsaPrabayarScreen");

    return MultiBlocProvider(providers: [
      BlocProvider<HargaPulsaPublicBloc>(
        create: (context) => GetIt.I<HargaPulsaPublicBloc>(),
      ),
      BlocProvider<PaymentPulsaPrabayarBloc>(
        create: (context) => GetIt.I<PaymentPulsaPrabayarBloc>(),
      )
    ], child: _PulsaPrabayarLayout());
  }
}

class _PulsaPrabayarLayout extends StatefulWidget {
  const _PulsaPrabayarLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PulsaPrabayarScreenState();
}

class _PulsaPrabayarScreenState extends State<_PulsaPrabayarLayout> {
  final noPonselController = TextEditingController();
  PrefixPulsaModel? prefix;
  List<HargaPulsaModel> hargaPublisList = [];
  LoadingController loadingController = LoadingController();
  int selectHargaPulsa = -1;
  String provider = "";

  @override
  void initState() {
    super.initState();
    initAction();
  }

  void initAction() {
    noPonselController.addListener(() {
      if (noPonselController.text.length >= 4 && prefix == null) {
        _getHargaPublic();
      } else if (noPonselController.text.length < 4) {
        setState(() {
          hargaPublisList.clear();
          prefix = null;
          loadingController.hideLoading();
          selectHargaPulsa = -1;
        });
      }
    });
  }

  void _getHargaPublic() {
    prefix =
        PulsaProviderUtil.prefixModel[noPonselController.text.substring(0, 4)];

    if (prefix == null) {
      showSnakeBar(context, Strings.no_ponsel_tidak_dikenal);
      return;
    }
    setState(() {
      provider = prefix!.product;
    });

    BlocProvider.of<HargaPulsaPublicBloc>(context)
        .add(HargaPulsaPublicEvent(provider: prefix!.product));
  }

  @override
  Widget build(BuildContext context) {
    if(selectHargaPulsa > -1) {
      print("hargaPublisList[selectHargaPulsa].hargaPublic " +
          hargaPublisList[selectHargaPulsa].hargaPublic.toString());
    }
    return MultiBlocListener(
      listeners: [
        BlocListener<HargaPulsaPublicBloc, BlocState>(
          listener: (context, state) {
            if (state is HargaPulsaSuccessState) {
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
              // 50100002221116164915 11000 TELKOMSEL
              // print("data.trxid "+data!.trxid!+" "+data!.billAmount!.toString()+" "+data.produk!);
              // var col1 = "161122163833 _SIMPATI_081287372727_10000_SN10-081287372727".split("_");
              final dt = col1![0].trim().toDateTime();

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

              String ss = "<div style='width:100%;font-size:16px'><br/>" +
                  "<div style='font-size:22px;width:100%;text-align:center;'>TRANSAKSI SUKSES</div>" +
                  "<br/><br/>Tanggal: " +
                  dt.dateFotmat(pattern: "dd/MM/yyyy HH:mm:ss") +
                  " WITA<br/><br/><div style='font-weight: bold;'>" +
                  data.produk! +
                  "</div><br/><table style='width:100%;'><tr><td style='width:100px;'>PRODUK</td><td>\t\t:\t\t</td>" +
                  "<td>" +
                  col1[1] +
                  "</td></tr><tr><td>DENOM</td>" +
                  "<td>\t\t:\t\t</td><td>Rp." +
                  col1[3].trim().currencyFormat() +
                  "</td></tr>" +
                  "<tr><td>NO PONSEL</td><td>\t\t:\t\t</td><td>" +
                  col1[2] +
                  "</td></tr>" +
                  "<tr><td>TOTAL BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
                  data.billAmount!.currencyFormat() +
                  "</td>" +
                  "</tr><tr><td>KODE TRX</td><td>\t\t:\t\t</td><td>" +
                  data.trxid! +
                  "</td></tr></table></div>";

              showDialog(
                context: context,
                builder: (context) => DialogPaymentSukses(
                  htmlStr: ss,
                  onTutupPressed: () {
                    Navigator.pop(context);
                  },
                  fileName: "ppob_pulsapra_"+data.trxid!,
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
          title: Strings.pulsa_prabayar,
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
                                iconPath: Assets.ic_pulsa_prabayar,
                                title: Strings.nomor_ponsel,
                                hintText: "0857xxx",
                                controller: noPonselController,
                                isPhoneContact: true,
                                onContactValue: (contact) {
                                  setState(() {
                                    hargaPublisList.clear();
                                    noPonselController.text = contact;
                                  });
                                },
                              ),
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
                                isEnabled: selectHargaPulsa != -1 &&
                                    noPonselController.text.length > 4,
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
                                      imageProductPath:
                                          providerPulsaImg(provider),
                                      noPelanggan: noPonselController.text,
                                      productName: prefix?.product,
                                      deskripsi:
                                          "Voucher ${prefix!.product} ${hargaPublisList[selectHargaPulsa].kodeProduk!.currencyFormat()}\nHarga : ${hargaPublisList[selectHargaPulsa].hargaPublic!.currencyFormat2()}",
                                    ),
                                  );
                                },
                                width: double.infinity,
                              ),
                              height_50(),
                              Text(
                                Strings.operator,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              height_10(),
                              ImageAsset(
                                imgPath: Assets.operator,
                                width: 150.w,
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

  void _submitPayment(String pin) {
    BlocProvider.of<PaymentPulsaPrabayarBloc>(context).add(
      PaymentPulsaPrabayarEvent(
        noHp: noPonselController.text,
        nominal: hargaPublisList[selectHargaPulsa].kodeProduk,
        pin: pin,
        product: prefix!.product,
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
      child: ImageAsset(
          imgPath: providerPulsaImg(provider),
          height: 25.h,
          fit: BoxFit.fitHeight),
    );
  }
}
