import 'package:equatable/equatable.dart';

abstract class LoginPageState extends Equatable {
  const LoginPageState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginPageState {}

class LoginLoading extends LoginPageState {}

class LoginSuccess extends LoginPageState {}

class LoginFailure extends LoginPageState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}
