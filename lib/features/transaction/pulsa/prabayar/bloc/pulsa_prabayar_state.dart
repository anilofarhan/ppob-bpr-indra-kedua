import 'package:ppob/core/bloc/bloc_state.dart';
import 'package:ppob/features/transaction/model/transaction_response_model.dart';
import 'package:ppob/features/transaction/pulsa/prabayar/model/harga_pulsa_model.dart';

class HargaPulsaSuccessState extends BlocState {
  List<HargaPulsaModel> datas;

  HargaPulsaSuccessState(this.datas);
}

class HargaNotfoundState extends BlocState {
  final String? message;

  HargaNotfoundState(this.message);
}

class PaymentPulsaSuccessState extends BlocState {
  List<TransactionResponseModel> datas;

  PaymentPulsaSuccessState(this.datas);
}

class PaymentPulsaShowLoadingState extends BlocState {}

class PaymentPulsaHideLoadingState extends BlocState {}
