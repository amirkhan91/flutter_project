import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/login_page_bloc/login_page_bloc1.dart';

import 'login_page_event1.dart';
import 'login_page_state1.dart';

class LoginPageBlocUI1 extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => LoginPageBloc(),
          child: BlocListener<LoginPageBloc, LoginPageState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              } else if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login Successful')),
                );
              }
            },
            child: BlocBuilder<LoginPageBloc, LoginPageState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final username = _usernameController.text;
                        final password = _passwordController.text;

                        BlocProvider.of<LoginPageBloc>(context).add(
                          LoginButtonPressedEvent(
                            username: username,
                            password: password,
                          ),
                        );
                      },
                      child: Text('Login'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
