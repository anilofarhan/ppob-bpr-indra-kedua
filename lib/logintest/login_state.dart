import 'package:equatable/equatable.dart';
import 'package:ppob/core/model/response.dart';

import 'login_user_response.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  final BaseLoginUserResponse? baseResponse;

  LoginSuccessState({this.baseResponse});

  @override
  List<Object?> get props => [baseResponse];
}

class LoginInitialState extends LoginState {}

class RequestBuatPinSuccessState extends LoginState {
  final BaseResponse? baseResponse;
  RequestBuatPinSuccessState({this.baseResponse});

  @override
  List<Object?> get props => [baseResponse];
}

class RequestBuatPasswordSuccessState extends LoginState {
  final BaseResponse? baseResponse;
  RequestBuatPasswordSuccessState({this.baseResponse});

  @override
  List<Object?> get props => [baseResponse];
}

class LoginFailedState extends LoginState {
  final String? message;
  LoginFailedState({this.message});

  @override
  List<Object?> get props => [message];
}

class LoginLoadingState extends LoginState {}
