import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/login_bloc/auth_repository.dart';
import 'package:test_proj/login_bloc/form_submisstion_status.dart';
import 'package:test_proj/login_bloc/login_event.dart';
import 'package:test_proj/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({required  this.authRepository}) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUserNameChanged) {
      emit(state.copyWith(username: event.username));
    } else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    } else if (event is LoginSubmitted) {
      emit(state.copyWith(formSubmisstionStatus: FormSubmitting()));

      try{
        await authRepository.login();
        emit(state.copyWith(formSubmisstionStatus: SubmissionSuccess()));
      }catch(e){
        emit(state.copyWith(formSubmisstionStatus: SubmissionFailed(e as Exception)));
      }

    }
  }
}
