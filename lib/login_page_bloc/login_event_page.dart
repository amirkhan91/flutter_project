import 'package:equatable/equatable.dart';

abstract class LoginEventPage extends Equatable {
  const LoginEventPage();
  List<Object> get props => [];
}

class EmailChanged extends LoginEventPage {
  final String email;
  const EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEventPage {
  final String password;
  const PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginApi extends LoginEventPage {}
