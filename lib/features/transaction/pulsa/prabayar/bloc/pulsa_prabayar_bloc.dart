import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/bloc/pulsa_prabayar_event.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/bloc/pulsa_prabayar_state.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/repositories/pulsa_prabayar_repository.dart';

class HargaPulsaPublicBloc extends Bloc<HargaPulsaPublicEvent, BlocState> {
  final PulsaPrabayarRepository repository;

  HargaPulsaPublicBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(HargaPulsaPublicEvent event) async* {
    print("masuk HargaPulsaPublicBloc");

    yield ShowLoadingState();
    if (event is HargaPulsaPublicEvent) {
      try {
        var results = await repository.getHargaPulsaPublic(event);

        if (results.status == Constants.RC_SUKSES) {
          yield HargaPulsaSuccessState(results.data!);
          yield HideLoadingState();
        } else {
          yield HargaNotfoundState(results.description);
        }
      } catch (e) {
        yield HideLoadingState();
        yield ErrorState(message: e.toString());
      }
    }
  }
}

class PaymentPulsaPrabayarBloc
    extends Bloc<PaymentPulsaPrabayarEvent, BlocState> {
  final PulsaPrabayarRepository repository;

  PaymentPulsaPrabayarBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(PaymentPulsaPrabayarEvent event) async* {
    yield PaymentPulsaShowLoadingState();
    if (event is PaymentPulsaPrabayarEvent) {
      try {
        var results = await repository.postPaymentPulsaPrabayar(event);

        if (results.status == Constants.RC_SUKSES) {
          yield PaymentPulsaHideLoadingState();
          yield PaymentPulsaSuccessState(results.data!);
        } else {
          yield PaymentPulsaHideLoadingState();
          yield ErrorState(message: results.description);
        }
      } catch (e) {
        yield PaymentPulsaHideLoadingState();
        yield ErrorState(message: e.toString());
      }
    }
  }
}
