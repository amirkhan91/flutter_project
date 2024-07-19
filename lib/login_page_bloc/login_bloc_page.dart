import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/login_page_bloc/login_event_page.dart';
import 'package:test_proj/login_page_bloc/login_state_page.dart';
import 'package:http/http.dart' as http;
// part 'login_event_page.dart';
// part 'login_state_page.dart';

class LoginBlocPage extends Bloc<LoginEventPage, LoginStatePage>{
  LoginBlocPage():super(LoginStatePage()){
   on<EmailChanged>(_onEmailChanged);
   on<PasswordChanged>(_onPasswordChanged);
  //  on<LoginApi>(_loginApi);
   
    }

     void _onEmailChanged(EmailChanged event, Emitter<LoginStatePage> emit){
    emit(
      state.copyWith(
        email: event.email
      )
    );
  }
  void _onPasswordChanged(PasswordChanged event,Emitter<LoginStatePage> emit){
    emit(
      state.copyWith(
        password: event.password
      )
    );
  }

  // void _loginApi(LoginApi event, Emitter<LoginStatePage> emit)async{
  //   Map data = {'email': state.email, 'password': state.password};
  //   try{
  //     final response = await http.post(Uri.parse(data),body: data);
  //     if(response.statusCode==201){}
  //   }catch(e){
  //     emit(
  //       state.copyWith(message: e.toString())
  //     );
  //   }
  // }
  }

 

