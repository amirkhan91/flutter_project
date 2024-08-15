import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:test_proj/login_page_bloc/login_page_bloc1.dart';
import 'package:test_proj/login_page_bloc/login_page_event1.dart';
import 'package:test_proj/login_page_bloc/login_page_state1.dart';

void main() {
  group('LoginPageBloc', () {
    blocTest<LoginPageBloc, LoginPageState>(
      'emits [LoginLoading, LoginSuccess] when LoginButtonPressedEvent is added with correct credentials',
      build: () => LoginPageBloc(),
      act: (bloc) => bloc.add(const LoginButtonPressedEvent(username: 'user', password: 'password')),
      wait: const Duration(seconds: 1), // Adding a delay to ensure all states are captured
      expect: () => [
        LoginLoading(),
        LoginSuccess(),
      ],
    );

    blocTest<LoginPageBloc, LoginPageState>(
      'emits [LoginLoading, LoginFailure] when LoginButtonPressedEvent is added with wrong credentials',
      build: () => LoginPageBloc(),
      act: (bloc) => bloc.add(const LoginButtonPressedEvent(username: 'wrong_user', password: 'wrong_password')),
      wait: const Duration(seconds: 1), // Adding a delay to ensure all states are captured
      expect: () => [
        LoginLoading(),
        const LoginFailure('Invalid username or password'),
      ],
    );

    blocTest<LoginPageBloc, LoginPageState>(
      'emits [LoginLoading, LoginFailure] when LoginButtonPressedEvent is added with any other credentials',
      build: () => LoginPageBloc(),
      act: (bloc) => bloc.add(const LoginButtonPressedEvent(username: 'random_user', password: 'random_password')),
      wait: const Duration(seconds: 1), // Adding a delay to ensure all states are captured
      expect: () => [
        LoginLoading(),
        const LoginFailure('An error occurred. Please try again.'),
      ],
    );
  });
}
