abstract class LoginEvent {}

class LoginUserNameChanged extends LoginEvent {
  final String username;
  LoginUserNameChanged({required this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}
