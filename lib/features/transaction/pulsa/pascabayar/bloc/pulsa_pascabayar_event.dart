import 'package:ppob/core/bloc/bloc_event.dart';

class InquiryPulsaPascabayarEvent extends BlocEvent {
  String? noHp;
  String? product;

  InquiryPulsaPascabayarEvent({required this.noHp, required this.product});
}

class PaymentPulsaPascabayarEvent extends BlocEvent {
  String? noHp;
  String? product;
  String? pin;

  PaymentPulsaPascabayarEvent(
      {required this.noHp, required this.product, required this.pin});
}
