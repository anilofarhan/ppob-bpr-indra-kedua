import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/core/constant/constants.dart';
import 'package:ppob/features/transaction/pbb/bloc/pbb_event.dart';
import 'package:ppob/features/transaction/pbb/bloc/pbb_state.dart';
import 'package:ppob/features/transaction/pbb/repositories/pbb_repository.dart';

class PbbProductsBloc extends Bloc<PbbProductsBlocEvent, BlocState> {
  final PbbRepository repository;

  PbbProductsBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(PbbProductsBlocEvent event) async* {
    yield ShowLoadingState();
    if (event is PbbProductsBlocEvent) {
      try {
        var results = await repository.getPbbProducts(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield PbbProductsSuccessState(results.data!);
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

class InquiryPbbBloc extends Bloc<InquiryPbbEvent, BlocState> {
  final PbbRepository repository;

  InquiryPbbBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(InquiryPbbEvent event) async* {
    yield ShowLoadingState();
    if (event is InquiryPbbEvent) {
      try {
        var results = await repository.inquiryPbb(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield InquiryPbbSuccessState(results.data![0]);
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

class PaymentPbbBloc extends Bloc<PaymentPbbEvent, BlocState> {
  final PbbRepository repository;

  PaymentPbbBloc(this.repository) : super(InitialState());

  @override
  Stream<BlocState> mapEventToState(PaymentPbbEvent event) async* {
    yield ShowLoadingState();
    if (event is PaymentPbbEvent) {
      try {
        var results = await repository.paymentPbb(event);
        yield HideLoadingState();
        if (results.status == Constants.RC_SUKSES) {
          yield PaymentPbbSuccessState(results.data![0]);
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
