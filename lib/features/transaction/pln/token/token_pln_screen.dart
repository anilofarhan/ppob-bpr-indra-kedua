import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:ppob/core/constant/proccesing_code.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/constant/style.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/core/utils.dart';
import 'package:ppob/features/transaction/pln/token/bloc/token_pln_bloc.dart';
import 'package:ppob/features/transaction/pln/token/model/harga_token_model.dart';

class TokenPlnScreen extends StatelessWidget {
  const TokenPlnScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<HargaTokenPlnBloc>(
        create: (context) => GetIt.I<HargaTokenPlnBloc>(),
      ),
      BlocProvider<PaymentTokenPlnBloc>(
        create: (context) => GetIt.I<PaymentTokenPlnBloc>(),
      )
    ], child: const _TokenPlnLayout());
  }
}

class _TokenPlnLayout extends StatefulWidget {
  const _TokenPlnLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenPlnScreenState();
}

class _TokenPlnScreenState extends State<_TokenPlnLayout> {
  final nomerController = TextEditingController();
  List<HargaTokenModel> hargaPublishList = [];
  LoadingController loadingController = LoadingController();
  int selectHargaToken = -1;
  final String provider = Constants.PLN;
  late HargaTokenPlnBloc _hargaBloc;
  late PaymentTokenPlnBloc _paymentBloc;

  @override
  void initState() {
    _hargaBloc = BlocProvider.of<HargaTokenPlnBloc>(context);
    _paymentBloc = BlocProvider.of<PaymentTokenPlnBloc>(context);
    super.initState();
    initAction();
  }

  void initAction() {
    _hargaBloc.add(HargaTokenPlnEvent(provider: provider));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HargaTokenPlnBloc, BlocState>(
          listener: (context, state) {
            if (state is HargaTokenSuccessState) {
              setState(() {
                hargaPublishList.clear();
                hargaPublishList.addAll(state.data);
              });
            } else if (state is HargaNotFoundState) {
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
        BlocListener<PaymentTokenPlnBloc, BlocState>(
          listener: (context, state) {
            if (state is InquiryTokenSuccessState) {
              /*String content = "Trx ID: ${state.data[0].trxid}"
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
                  "</div><table style='width:100%;'><tr style='padding-bottom:5px'><td style='width:100px;'>NO METER</td><td>\t\t:\t\t</td>" +
                  "<td>" +
                  col1[1].trim() +
                  "</td></tr><tr style='padding-bottom:5px'><td>IDPEL</td>" +
                  "<td>\t\t:\t\t</td><td>" +
                  col1[3].trim() +
                  "</td></tr>" +
                  "<tr style='padding-bottom:5px'><td>NAMA</td><td>\t\t:\t\t</td><td>" +
                  col1[5] +
                  "</td></tr>" +
                  "<tr style='padding-bottom:5px'><td>TRF/DAYA</td><td>\t\t:\t\t</td><td>" +
                  col1[7] +
                  "</td>" +
                  "</tr>" +
                  "<tr style='padding-bottom:5px'><td>RP BELI</td><td>\t\t:\t\t</td><td>Rp." +
                  col1[9].trim().currencyFormat() +
                  "</td>" +
                  "</tr>" +
                  "<tr style='padding-bottom:5px'><td>ADMIN</td><td>\t\t:\t\t</td><td>Rp." +
                  col1[11].trim().currencyFormat() +
                  "</td>" +
                  "</tr>" +
                  "<tr style='padding-bottom:5px'><td>RP BAYAR</td><td>\t\t:\t\t</td><td>Rp." +
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
            } else if (state is PaymentTokenSuccessState) {
              String content =
                  _paymentBloc.generateDetailContent(state.data[0]);
              showDialog(
                context: context,
                builder: (context) => DialogPaymentSukses(
                  htmlStr: content,
                  onTutupPressed: () {
                    Navigator.pop(context);
                  },
                  fileName: "ppob_plntoken_"+state.data[0].trxid!,
                ),
              );
            } else if (state is PaymentTokenPlnShowLoadingState) {
              showProgressDialog(context);
            } else if (state is PaymentTokenPlnHideLoadingState) {
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
          title: Strings.token_listrik,
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
                                iconPath: Assets.ic_token_pln,
                                title: Strings.pln_nopel_meter,
                                hintText: "",
                                controller: nomerController,
                                isPhoneContact: false,
                              ),
                              height_10(),
                              LoadingView(
                                loadingController: loadingController,
                              ),
                              Visibility(
                                  visible: hargaPublishList.isNotEmpty,
                                  child: Card(
                                    elevation: 5,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        title(),
                                        Container(
                                          color: Colors.grey[100],
                                          child: GridView.count(
                                            mainAxisSpacing: 1,
                                            crossAxisSpacing: 1,
                                            childAspectRatio: 1 / 0.5,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            crossAxisCount: 2,
                                            padding: const EdgeInsets.all(1),
                                            children: _itemHargaToken(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              height_20(),
                              ButtonRed(
                                isEnabled: selectHargaToken != -1 &&
                                    nomerController.text.length > 4,
                                title: Strings.lanjut,
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _submitInquiry();
                                },
                                width: double.infinity,
                              ),
                              height_50(),
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
    _paymentBloc.add(
      PaymentTokenPlnEvent(
        billCode: nomerController.text,
        nominal: hargaPublishList[selectHargaToken].kodeProduk,
        pin: "",
        procCode: ProccesingCode.TRX_PLN_PREPAID_INQ,
      ),
    );
  }

  void _submitPayment(String pin) {
    _paymentBloc.add(
      PaymentTokenPlnEvent(
        billCode: nomerController.text,
        nominal: hargaPublishList[selectHargaToken].kodeProduk,
        pin: pin,
        procCode: ProccesingCode.TRX_PLN_PREPAID_PAY,
      ),
    );
  }

  List<Widget> _itemHargaToken() {
    List<Widget> l = [];
    for (int i = 0; i < hargaPublishList.length; i++) {
      var value = hargaPublishList[i];
      l.add(widgetItem(value, i));
    }

    return l;
  }

  Widget widgetItem(HargaTokenModel value, int index) {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          setState(() {
            selectHargaToken = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(3.w),
          decoration: selectHargaToken == index
              ? BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 0),
                    ),
                  ],
                )
              : const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                int.parse(value.kodeProduk!).toString().currencyFormat(),
                style: selectHargaToken == index
                    ? Style.text18spBlueBold
                    : Style.text14spBlackBold,
              ),
              height_5(),
              Text(
                value.hargaPublic!.currencyFormat2(),
                style: selectHargaToken == index
                    ? Style.text14spBlueBold
                    : Style.text14spGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child:
          Text(Strings.denominasi.toUpperCase(), style: Style.text18spGreyBold),
    );
  }
}
