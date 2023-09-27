import 'package:get_it/get_it.dart';
import 'package:ppob/features/transaction/internet/bloc/internet_bloc.dart';
import 'package:ppob/features/transaction/internet/repositories/internet_repository.dart';
import 'package:ppob/features/transaction/internet/repositories/internet_repository_impl.dart';
import 'package:ppob/features/transaction/multifinance/bloc/multifinance_bloc.dart';
import 'package:ppob/features/transaction/multifinance/repositories/multifinance_repository.dart';
import 'package:ppob/features/transaction/multifinance/repositories/multifinance_repository_impl.dart';
import 'package:ppob/features/transaction/pbb/bloc/pbb_bloc.dart';
import 'package:ppob/features/transaction/pbb/repositories/pbb_repository.dart';
import 'package:ppob/features/transaction/pbb/repositories/pbb_repository_impl.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_bloc.dart';
import 'package:ppob/features/transaction/pdam/repositories/pdam_repository.dart';
import 'package:ppob/features/transaction/pdam/repositories/pdam_repository_impl.dart';
import 'package:ppob/features/transaction/bpjs/bloc/bpjs_bloc.dart';
import 'package:ppob/features/transaction/bpjs/repositories/bpjs_repository.dart';
import 'package:ppob/features/transaction/bpjs/repositories/bpjs_repository_impl.dart';
import 'package:ppob/features/transaction/pln/tagihan/bloc/tagihan_pln_bloc.dart';
import 'package:ppob/features/transaction/pln/tagihan/repositories/tagihan_pln_repository.dart';
import 'package:ppob/features/transaction/pln/tagihan/repositories/tagihan_pln_repository_impl.dart';
import 'package:ppob/features/transaction/pln/token/bloc/token_pln_bloc.dart';
import 'package:ppob/features/transaction/pln/token/repositories/token_pln_repository.dart';
import 'package:ppob/features/transaction/pln/token/repositories/token_pln_repository_impl.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/bloc/pulsa_pascabayar_bloc.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/repositories/pulsa_pascabayar_repository.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/repositories/pulsa_pascabayar_repository_impl.dart';
import 'package:ppob/features/transaction/telkom/bloc/telkom_bloc.dart';
import 'package:ppob/features/transaction/telkom/repositories/telkom_repository.dart';
import 'package:ppob/features/transaction/telkom/repositories/telkom_repository_impl.dart';
import 'package:ppob/features/transaction/tv/bloc/tv_berbayar_bloc.dart';
import 'package:ppob/features/transaction/tv/repositories/tv_prabayar_repository.dart';
import 'package:ppob/features/transaction/tv/repositories/tv_prabayar_repository_impl.dart';

import 'pulsa/prabayar/bloc/pulsa_prabayar_bloc.dart';
import 'pulsa/prabayar/repositories/pulsa_prabayar_repository.dart';
import 'pulsa/prabayar/repositories/pulsa_prabayar_repository_impl.dart';

class TransactionModule {
  static void init() {
    //pulsa prabayar
    GetIt.I.registerLazySingleton<PulsaPrabayarRepository>(
      () => PulsaPrabayarRepositoryImpl(),
    );
    GetIt.I.registerFactory(() => HargaPulsaPublicBloc(GetIt.I()));
    GetIt.I.registerFactory(() => PaymentPulsaPrabayarBloc(GetIt.I()));

    //pulsa pascabayar
    GetIt.I.registerLazySingleton<PulsaPascabayarRepository>(
      () => PulsaPascabayarRepositoryImpl(),
    );
    GetIt.I.registerFactory(() => InquiryPulsaPascabayarBloc(GetIt.I()));
    GetIt.I.registerFactory(() => PaymentPulsaPascabayarBloc(GetIt.I()));

    //pdam
    GetIt.I.registerLazySingleton<PdamRepository>(
      () => PdamRepositoryImpl(),
    );
    GetIt.I.registerFactory(() => PdamProductsBloc(GetIt.I()));
    GetIt.I.registerFactory(() => InquiryPdamBloc(GetIt.I()));
    GetIt.I.registerFactory(() => PaymentPdamBloc(GetIt.I()));

    //pbb
    GetIt.I.registerLazySingleton<PbbRepository>(
          () => PbbRepositoryImpl(),
    );
    GetIt.I.registerFactory(() => PbbProductsBloc(GetIt.I()));
    GetIt.I.registerFactory(() => InquiryPbbBloc(GetIt.I()));
    GetIt.I.registerFactory(() => PaymentPbbBloc(GetIt.I()));


    //tv
    GetIt.I.registerLazySingleton<TvPrabayarRepository>(
      () => TvPrabayarRepositoryImpl(),
    );
    GetIt.I.registerFactory(() => InquiryTvBloc(GetIt.I()));
    GetIt.I.registerFactory(() => PaymentTvBloc(GetIt.I()));

    //multi finance
    GetIt.I.registerLazySingleton<MultifinanceRepository>(
      () => MultifinanceRepositoryImpl(),
    );
    GetIt.I.registerFactory(() => InquiryMultifinanceBloc(GetIt.I()));
    GetIt.I.registerFactory(() => PaymentMultifinanceBloc(GetIt.I()));

    _tokenPlnModule();
    _tagihanPlnModule();
    _telkomModule();
    _internetModule();
    _bpjsModule();
  }

  static void _tokenPlnModule() {
    GetIt.I.registerLazySingleton<TokenPlnRepository>(
        () => TokenPlnRepositoryImpl());
    GetIt.I.registerFactory(() => HargaTokenPlnBloc(GetIt.I()));
    GetIt.I.registerFactory(() => PaymentTokenPlnBloc(GetIt.I()));
  }

  static void _tagihanPlnModule() {
    GetIt.I.registerLazySingleton<TagihanPlnRepository>(
        () => TagihanPlnRepositoryImpl());
    GetIt.I.registerFactory(() => TagihanPlnBloc(GetIt.I()));
  }

  static void _telkomModule() {
    GetIt.I
        .registerLazySingleton<TelkomRepository>(() => TelkomRepositoryImpl());
    GetIt.I.registerFactory(() => TelkomBloc(GetIt.I()));
  }

  static void _internetModule() {
    GetIt.I
        .registerLazySingleton<InternetRepository>(() => InternetRepositoryImpl());
    GetIt.I.registerFactory(() => InternetBloc(GetIt.I()));
  }

  static void _bpjsModule() {
    GetIt.I.registerLazySingleton<BPJSRepository>(() => BPJSRepositoryImpl());
    GetIt.I.registerFactory(() => BPJSBloc(GetIt.I()));
  }
}
