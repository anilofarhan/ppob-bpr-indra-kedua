import 'package:equatable/equatable.dart';

class BlocState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialState extends BlocState {}

class ShowLoadingState extends BlocState {}

class HideLoadingState extends BlocState {}

class ErrorState extends BlocState {
  final String? message;
  ErrorState({this.message});
}
