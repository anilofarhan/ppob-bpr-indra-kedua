import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_event.dart';
import 'package:ppob/features/transaction/pdam/bloc/pdam_state.dart';
import 'package:ppob/features/transaction/pdam/repositories/pdam_repository.dart';

class PdamProductsBloc extends Bloc<PdamProductsBlocEvent, BlocState> {
  final PdamRepository repository;

  PdamProductsBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(PdamProductsBlocEvent event) async* {
    yield ShowLoadingState();
    if (event is PdamProductsBlocEvent) {
      try {
        var results = await repository.getPdamProducts(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield PdamProductsSuccessState(results.data!);
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

class InquiryPdamBloc extends Bloc<InquiryPdamEvent, BlocState> {
  final PdamRepository repository;

  InquiryPdamBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(InquiryPdamEvent event) async* {
    yield ShowLoadingState();
    if (event is InquiryPdamEvent) {
      try {
        var results = await repository.inquiryPdam(event);
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

class PaymentPdamBloc extends Bloc<PaymentPdamEvent, BlocState> {
  final PdamRepository repository;

  PaymentPdamBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(PaymentPdamEvent event) async* {
    yield ShowLoadingState();
    if (event is PaymentPdamEvent) {
      try {
        var results = await repository.paymentPdam(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield PaymentPdamSuccessState(results.data![0]);
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
