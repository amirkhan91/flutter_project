import 'package:equatable/equatable.dart';
enum LoginStatus{initial, loading,success,error}

 class LoginStatePage extends Equatable{
final String email;
final String password;
final String message;
final LoginStatus loginStatus;

const LoginStatePage({
 this.email ='',
 this.password='',
 this.message = '',
 this.loginStatus = LoginStatus.initial
});

LoginStatePage copyWith({
  String? email,
  String? password,
  String? message,
  LoginStatus? loginStatus,
}){
  return LoginStatePage(
    email: email?? this.email,
    password: password?? this.password,
    message: message?? this.message,
    loginStatus: loginStatus??this.loginStatus
  );
}
@override
 List<Object> get props => [email,password,message, loginStatus];
}