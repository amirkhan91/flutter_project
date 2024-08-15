import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/login_page_bloc/login_bloc_page.dart';
import 'package:test_proj/login_page_bloc/login_event_page.dart';
import 'package:test_proj/login_page_bloc/login_state_page.dart';

class LoginUiBloc extends StatefulWidget {
  const LoginUiBloc({super.key});

  @override
  State<LoginUiBloc> createState() => _LoginUiBlocState();
}

class _LoginUiBlocState extends State<LoginUiBloc> {
  late LoginBlocPage _loginBlocPage;
  final emailFocusNode = FocusNode();
  final passwrodFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _loginBlocPage = LoginBlocPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(create: (_)=> _loginBlocPage,
      child: Padding(padding: const EdgeInsets.all(100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<LoginBlocPage, LoginStatePage>(
            buildWhen: (current, previous)=> current.email != previous.email,
            builder: (context, state){
            return TextFormField(
              keyboardType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                hintText: 'Email',border: OutlineInputBorder()
              ),
              onChanged: (value){
                context.read<LoginBlocPage>().add(EmailChanged(email: value));
              },
              onFieldSubmitted: (value){},
            );
          }),
          const SizedBox(height: 20,),
          BlocBuilder<LoginBlocPage, LoginStatePage>(
            buildWhen: (current, previous)=> current.password != previous.password,
            builder: (context, state){
            return TextFormField(
              keyboardType: TextInputType.text,
              focusNode: passwrodFocusNode,
              decoration: const InputDecoration(
                hintText: 'Password',border: OutlineInputBorder()
              ),
              onChanged: (value){
                context.read<LoginBlocPage>().add(PasswordChanged(password: value));
              },
              onFieldSubmitted: (value){},
            );
          }),
        const  SizedBox(
            height: 50,
          ),
          ElevatedButton(onPressed: (){}, child:const Text('Login'))
        ],
      ),),)
    );
  }
}
