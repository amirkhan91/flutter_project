import 'package:test_proj/login_bloc/form_submisstion_status.dart';

class LoginState {
  final String username;
  bool get isValidUsername => username.length > 3;
  final String password;
  bool get isValidPassword => password.length > 6;
  final FormSubmisstionStatus formSubmisstionStatus;
  LoginState(
      {this.username = '',
      this.password = '',
      this.formSubmisstionStatus = const InitialFormStatus()});
  LoginState copyWith(
      {String? username,
      String? password,
      FormSubmisstionStatus? formSubmisstionStatus}) {
    return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formSubmisstionStatus:
            formSubmisstionStatus ?? this.formSubmisstionStatus);
  }
}
