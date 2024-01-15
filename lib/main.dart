import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/ppob_module.dart';

import 'core/base/build_config.dart';
import 'core/constant/colors.dart';
import 'features/home/home_menu_screen.dart';
import 'features/home/test_page.dart';
import 'logintest/dio_module.dart';
import 'logintest/login_bloc.dart';
import 'logintest/login_event.dart';
import 'logintest/login_state.dart';

String _baseUrlProd = "http://online.bprindra.com:19012/";
String _baseUrlDev = "http://online.bprindra.com:19012/";
String _secretKey = "a8eeea6c3c839d8b96a8a1a43a13e5c3";
String _rsaKey =
    "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDr/Wj9Qwsu/e5rqh0V4M909gPjKN5/woboOVD/jtlfEwAbUke/giXEyT9onqlsMYQeFgO5f9z1Z2Ce7WKCdZawi+p0fohzULrPcxGlsOC4GjBOHinsP5L/axUj3hX0mtVJ6TsWNIyKT02A+fJ9xBy62qS3Xo2773Cppt5APQYv8wIDAQAB";
void main() => {
      DioModule.init(),
      runApp(
        const MyApp(),
      ),
    };

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PPOB',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.colorPrimary,
          ),
        ),
        home: LoginLayout(),
      ),
    );
  }
}

class LoginLayout extends StatefulWidget {
  @override
  _LoginLayoutState createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  String? sessionId;
  String noRek = "";
  @override
  void initState() {
    super.initState();
     // BlocProvider.of<LoginBloc>(context)
     //     .add(LoginUserRequestEvent(user: "XamgVaKT1551", pass: "bpr456"));

     BlocProvider.of<LoginBloc>(context)
         .add(LoginUserRequestEvent(user: "trsnadew2", pass: "bpr111"));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Constants.NO_REKENING = state.baseResponse?.data![0].noRek ?? "";
              Constants.PIN_TRANSAKSI = state.baseResponse?.data![0].pinTransaksi ?? "";
              Constants.isFinger = state.baseResponse?.data![0].flagFingerprint==1;
              Constants.SERIAL_NO = state.baseResponse?.data![0].noMesinHp??"";
              print("pin transaksi "+state.baseResponse!.data![0].pinTransaksi!);
              print("flag "+Constants.isFinger.toString());
              PPOBModule.init(
                buildConfig: () => PPOBBuildConfig(
                    baseUrl: _baseUrlProd,
                    rsaKey: _rsaKey,
                    secretKey: state.baseResponse?.trxseckey ?? "",
                    sessionId: state.baseResponse?.session ?? "",
                    cif: state.baseResponse?.data![0].cif ?? "",
                    debug: true),
              );
            } else if (state is LoginFailedState) {
              print("state error: ${state.message}");
            } else if (state is LoginLoadingState) {
              print("Loading");
            }
          },
        ),
      ],
      child: TestPage(),
    );
  }
}
