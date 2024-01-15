import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/bloc/pulsa_pascabayar_event.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/bloc/pulsa_pascabayar_state.dart';
import 'package:ppob/features/transaction/pulsa/pascabayar/repositories/pulsa_pascabayar_repository.dart';

class InquiryPulsaPascabayarBloc
    extends Bloc<InquiryPulsaPascabayarEvent, BlocState> {
  final PulsaPascabayarRepository repository;

  InquiryPulsaPascabayarBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(InquiryPulsaPascabayarEvent event) async* {
    yield ShowLoadingState();
    if (event is InquiryPulsaPascabayarEvent) {
      try {
        var results = await repository.inquiryPulsaPascabayar(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield InquiryPulsaPascabayarSuccessState(results.data![0]);
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

class PaymentPulsaPascabayarBloc
    extends Bloc<PaymentPulsaPascabayarEvent, BlocState> {
  final PulsaPascabayarRepository repository;

  PaymentPulsaPascabayarBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(PaymentPulsaPascabayarEvent event) async* {
    yield ShowLoadingState();
    if (event is PaymentPulsaPascabayarEvent) {
      try {
        var results = await repository.paymentPulsaPascabayar(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield PaymentPulsaPascabayarSuccessState(results.data![0]);
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
