// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/component/loading_view.dart';
import 'package:ppob/core/component/my_widget.dart';
import 'package:ppob/core/constant/colors.dart';
import 'package:ppob/core/constant/strings.dart';
import 'package:ppob/core/constant/style.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_bloc.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_event.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_state.dart';
import 'package:ppob/features/transaction/pdam/model/pdam_products_model.dart';
import 'package:ppob/features/transaction/pdam/pdam_transaction_screen.dart';

class PdamProductsScreen extends StatelessWidget {
  PdamProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PdamProductsBloc>(
        create: (context) => GetIt.I<PdamProductsBloc>(),
      ),
    ], child: _PdamProductsLayout());
  }
}

class _PdamProductsLayout extends StatefulWidget {
  const _PdamProductsLayout({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PdamProductsScreenState();
}

class _PdamProductsScreenState extends State<_PdamProductsLayout> {
  final noSearchController = TextEditingController();
  final loadingController = LoadingController();
  List<PdamProductsModel> datas = [];
  List<PdamProductsModel> allDatas = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    initAction();
  }

  void initAction() {
    noSearchController.addListener(_onSearchChanged);

    BlocProvider.of<PdamProductsBloc>(context)
        .add(PdamProductsBlocEvent(product: 'PDAM'));
  }

  _onSearchChanged() {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        datas.clear();
        datas.addAll(allDatas.where((element) =>
            element.kode!.toLowerCase().contains(noSearchController.text)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PdamProductsBloc, BlocState>(
          listener: (context, state) {
            if (state is PdamProductsSuccessState) {
              setState(() {
                datas.clear();
                allDatas.clear();
                allDatas.addAll(state.datas);
                datas.addAll(state.datas);
              });
            } else if (state is HideLoadingState) {
              setState(() {
                loadingController.hideLoading();
              });
            } else if (state is ShowLoadingState) {
              setState(() {
                loadingController.showLoading();
              });
            } else if (state is ErrorState) {
              setState(() {
                loadingController.showError(state.message ?? "", () {
                  BlocProvider.of<PdamProductsBloc>(context)
                      .add(PdamProductsBlocEvent(product: 'PDAM'));
                });
              });
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: Strings.pdam,
          elevation: false,
          context: context,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
              color: AppColors.colorPrimary,
              child: _inputSearch(),
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: datas.length,
                    itemBuilder: (context, index) {
                      return itemListPdam(datas[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        color: Colors.grey[300],
                        height: 1,
                      );
                    },
                  ),
                  LoadingView(loadingController: loadingController)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemListPdam(PdamProductsModel pdam) {
    return Material(
        color: Colors.white,
        child: InkWell(
          onTap: () async {
            await Navigator.of(context)
                .push(MaterialPageRoute(
                  builder: (context) => PdamTransactionScreen(
                    kodeProduk: pdam.jenisProduk ?? "",
                    title: pdam.kode ?? "",
                  ),
                ))
                .then((value) => {
                      if (value == true) {Navigator.pop(context)}
                    });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  pdam.kode ?? "",
                  style: Style.text14spBlackBold,
                )),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                )
              ],
            ),
          ),
        ));
  }

  Widget _inputSearch() {
    return Card(
        child: Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          controller: noSearchController,
          style: Style.text18spBlack,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              hintText: Strings.cari,
              border: InputBorder.none,
              hintStyle: Style.text18spGrey,
              contentPadding: EdgeInsets.fromLTRB(0, 12, 45, 12)),
        ),
        Visibility(
          visible: noSearchController.text.isNotEmpty,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.grey),
            onPressed: () {
              noSearchController.text = "";
            },
          ),
        ),
      ],
    ));
  }
}
