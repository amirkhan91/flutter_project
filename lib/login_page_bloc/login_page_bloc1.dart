import 'package:bloc/bloc.dart';
import 'login_page_event1.dart';
import 'login_page_state1.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginInitial()) {
    on<LoginButtonPressedEvent>((event, emit) async {
      emit(LoginLoading());

      // Simulate a delay for a network request
      await Future.delayed(const Duration(seconds: 1));

      // Logic to emit the appropriate state
      if (event.username == 'user' && event.password == 'password') {
        emit(LoginSuccess());
      } else if (event.username == 'wrong_user' && event.password == 'wrong_password') {
        emit(const LoginFailure('Invalid username or password'));
      } else {
        emit(const LoginFailure('An error occurred. Please try again.'));
      }
    });
  }
}