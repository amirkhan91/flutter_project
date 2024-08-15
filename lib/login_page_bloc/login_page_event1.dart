import 'package:equatable/equatable.dart';

abstract class LoginPageEvent extends Equatable {
  const LoginPageEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressedEvent extends LoginPageEvent {
  final String username;
  final String password;

  const LoginButtonPressedEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
