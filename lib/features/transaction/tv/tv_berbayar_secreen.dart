// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/component/confirmation_product_dialog.dart';
import 'package:ppob/core/component/dialog_payment_sukses.dart';
import 'package:ppob/core/component/finger/finger_modal_dialog.dart';
import 'package:ppob/core/component/information_dialog.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/component/pin/pin_modal_dialog.dart';
import 'package:ppob/core/constant/assets.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/extention/common_extention.dart';
import 'package:ppob/core/utils.dart';
import 'package:ppob/features/transaction/tv/bloc/tv_berbayar_bloc.dart';
import 'package:ppob/features/transaction/tv/bloc/tv_berbayar_event.dart';

import 'bloc/tv_berbayar_state.dart';

class TvBerbayarScreen extends StatelessWidget {
  TvBerbayarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<InquiryTvBloc>(
        create: (context) => GetIt.I<InquiryTvBloc>(),
      ),
      BlocProvider<PaymentTvBloc>(
        create: (context) => GetIt.I<PaymentTvBloc>(),
      )
    ], child: _TvBerbayarScreenLayout());
  }
}

class _TvBerbayarScreenLayout extends StatefulWidget {
  const _TvBerbayarScreenLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TvBerbayarScreenState();
}

class _TvBerbayarScreenState extends State<_TvBerbayarScreenLayout> {
  final noPonselController = TextEditingController();
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
        BlocListener<InquiryTvBloc, BlocState>(
          listener: (context, state) {
            if (state is InquiryTvSuccessState) {
              setState(() {
                String content = "Trx ID: ${state.data.trxid}\n\n"
                    "${state.data.customerData!.replaceToRp}";
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationProductDialog(
                    onSubmit: () async {
                      Navigator.pop(context);
                      // _showInputPin();
                      _showInputFinger();
                    },
                    imageProductPath: Assets.ic_tv,
                    noPelanggan: noPonselController.text,
                    productName: optionValue,
                    deskripsi: content,
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
        BlocListener<PaymentTvBloc, BlocState>(
          listener: (context, state) {
            if (state is PaymentTvSuccessState) {
              String ss = "Trx ID: ${state.data.trxid}<br/><br/>"
                  "${state.data.customerData!.replaceToRp}";

              showDialog(
                context: context,
                builder: (context) => DialogPaymentSukses(
                  htmlStr: ss,
                  onTutupPressed: () {
                    Navigator.pop(context);
                  },
                  fileName: "ppob_tv_"+state.data.trxid!,
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
          title: Strings.tv_berlangganan,
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
                                menus: ["INDOVISION", "CENTRIN", "AORATV"],
                                onSelectedListener: (selectedValue) {
                                  setState(() {
                                    optionValue = selectedValue;
                                    _enableBtn();
                                  });
                                },
                              ),
                              height_10(),
                              InputNoPelanggan(
                                  iconPath: Assets.ic_tv,
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
    BlocProvider.of<InquiryTvBloc>(context).add(
      InquiryTvEvent(
          noPelanggan: noPonselController.text, productCode: optionValue),
    );
  }

  void _submitPayment(String pin) {
    BlocProvider.of<PaymentTvBloc>(context).add(
      PaymentTvEvent(
          noPelanggan: noPonselController.text,
          productCode: optionValue,
          pin: pin),
    );
  }
}
