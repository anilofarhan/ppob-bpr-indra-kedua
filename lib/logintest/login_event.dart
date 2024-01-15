import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginUserRequestEvent extends LoginEvent {
  final String? user;
  final String? pass;

  LoginUserRequestEvent({this.user, this.pass});

  @override
  List<Object?> get props => [user, pass];
}
