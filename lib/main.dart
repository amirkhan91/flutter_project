import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_proj/api_config/api_config.dart';
import 'package:test_proj/login_bloc/auth_repository.dart';
import 'package:test_proj/login_bloc/login_page.dart';
import 'package:test_proj/login_page_bloc/login_ui_bloc.dart';
import 'package:test_proj/multiple_api_call/multi_res_page.dart';
import 'package:test_proj/phone_bloc/phone_bloc.dart';
import 'package:test_proj/phone_bloc/phone_details.dart';
import 'package:test_proj/router/go_router.dart';

import 'login_page_bloc/login_bloc_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePageData(),
      ),
      GoRoute(
        path: '/details',
        builder: (context, state) => DetailsPage(),
      ),
    ],
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MultiResponsePage()
        // LoginUiBloc()
        // RepositoryProvider(
        //   create: (context) => AuthRepository(),
        //   child: const LoginPage(),
        // )

        // BlocProvider(
        //   create: (context) => PhoneBloc(ApiCongig()),
        //   child: const PhoneDetailPage(),
        // )
        // const MyHomePage(title: 'Flutter Demo Home Page'),
        );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp.router(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //       useMaterial3: true,
  //     ),
  //     routerDelegate: _router.routerDelegate,
  //     routeInformationParser: _router.routeInformationParser,
  //   );
  // }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
