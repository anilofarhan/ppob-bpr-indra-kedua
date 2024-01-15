import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_state.dart';
import 'package:ppob/features/transaction/tv/bloc/tv_berbayar_event.dart';
import 'package:ppob/features/transaction/tv/bloc/tv_berbayar_state.dart';
import 'package:ppob/features/transaction/tv/repositories/tv_prabayar_repository.dart';

class InquiryTvBloc extends Bloc<InquiryTvEvent, BlocState> {
  final TvPrabayarRepository repository;

  InquiryTvBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(InquiryTvEvent event) async* {
    yield ShowLoadingState();
    if (event is InquiryTvEvent) {
      try {
        var results = await repository.postInquiryTvPrabayar(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield InquiryPdamSuccessState(results.data![0]);
        } else {
          yield ErrorState(message: results.description);
        }
      } catch (e) {
        yield HideLoadingState();
        yield ErrorState(message: e.toString());
      }
    }
  }
}

class PaymentTvBloc extends Bloc<PaymentTvEvent, BlocState> {
  final TvPrabayarRepository repository;

  PaymentTvBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(PaymentTvEvent event) async* {
    yield ShowLoadingState();
    if (event is PaymentTvEvent) {
      try {
        var results = await repository.postPaymentTvPrabayar(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield PaymentTvSuccessState(results.data![0]);
        } else {
          yield ErrorState(message: results.description);
        }
      } catch (e) {
        yield HideLoadingState();
        yield ErrorState(message: e.toString());
      }
    }
  }
}
