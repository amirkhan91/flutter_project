import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/login_bloc/auth_repository.dart';
import 'package:test_proj/login_bloc/form_submisstion_status.dart';
import 'package:test_proj/login_bloc/login_bloc.dart';
import 'package:test_proj/login_bloc/login_event.dart';
import 'package:test_proj/login_bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) =>
          LoginBloc(authRepository: context.read<AuthRepository>()),
      child: _loginForm(),
    ));
  }

  Widget _loginForm() {
    return Form(
        key: _fromKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _userNameField(),
              _passwordField(),
              const SizedBox(
                height: 50,
              ),
              _loginButton()
            ],
          ),
        ));
  }

  Widget _userNameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder:  (context, state){
return TextFormField(
        decoration:
            const InputDecoration(icon: Icon(Icons.person), hintText: 'Username'),
        validator: (value) => state.isValidUsername ?null: 'Username too short',
        onChanged: (value){
          context.read<LoginBloc>().add(LoginUserNameChanged(username:value));
        },
      );
      }
      
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state){
return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
            icon: Icon(Icons.security), hintText: 'Password'),
        validator: (value) =>state.isValidPassword ?null: 'password too short',
        onChanged: (value){
          context.read<LoginBloc>().add(LoginPasswordChanged(password:value));
        },
      );
      },

       
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state){
      return state.formSubmisstionStatus is  FormSubmitting
      ?const  CircularProgressIndicator()
      : ElevatedButton(
        onPressed: () {
          if(_fromKey.currentState!.validate()){
context.read<LoginBloc>().add(LoginSubmitted());
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,),
          child: const Text('Login'));
        
    });
     
        
  }
}
