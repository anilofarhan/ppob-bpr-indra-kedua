import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/features/transaction/multifinance/bloc/multifinance_event.dart';
import 'package:ppob/features/transaction/multifinance/bloc/multifinance_state.dart';
import 'package:ppob/features/transaction/multifinance/repositories/multifinance_repository.dart';

class InquiryMultifinanceBloc
    extends Bloc<InquiryMultifinanceEvent, BlocState> {
  final MultifinanceRepository repository;

  InquiryMultifinanceBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(InquiryMultifinanceEvent event) async* {
    yield ShowLoadingState();
    if (event is InquiryMultifinanceEvent) {
      try {
        var results = await repository.postInquiryMultifinance(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield InquiryMultifinanceSuccessState(results.data![0]);
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

class PaymentMultifinanceBloc
    extends Bloc<PaymentMultifinanceEvent, BlocState> {
  final MultifinanceRepository repository;

  PaymentMultifinanceBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(PaymentMultifinanceEvent event) async* {
    yield ShowLoadingState();
    if (event is PaymentMultifinanceEvent) {
      try {
        var results = await repository.postPaymentMultifinance(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield PaymentMultifinanceSuccessState(results.data![0]);
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
