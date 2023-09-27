import 'package:ppob/core/bloc/bloc_event.dart';

class HargaPulsaPublicEvent extends BlocEvent {
  String? provider;

  HargaPulsaPublicEvent({required this.provider});
}

class PaymentPulsaPrabayarEvent extends BlocEvent {
  String? noHp;
  String? product;
  String? nominal;
  String? pin;

  PaymentPulsaPrabayarEvent(
      {required this.noHp,
      required this.product,
      required this.nominal,
      required this.pin});
}
