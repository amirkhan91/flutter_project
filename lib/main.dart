// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:test_proj/api_config/api_config.dart';
// // import 'package:test_proj/demo_intr/design.dart';
// // import 'package:test_proj/dependency_injection/locator.dart';
// // import 'package:test_proj/dependency_injection/quote_view.dart';
// // import 'package:test_proj/login_bloc/auth_repository.dart';
// // import 'package:test_proj/login_bloc/login_page.dart';
// // import 'package:test_proj/login_page_bloc/login_ui_bloc.dart';
// // import 'package:test_proj/multiple_api_call/multi_res_page.dart';
// // import 'package:test_proj/phone_bloc/phone_bloc.dart';
// // import 'package:test_proj/phone_bloc/phone_details.dart';
// // import 'package:test_proj/router/go_router.dart';
// // import 'package:test_proj/unit_test/employee_fetch_data.dart';

// // import 'login_page_bloc/login_bloc_page.dart';

// // void main() {
// //   setupLocator();
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   // const MyApp({super.key});
// //   final GoRouter _router = GoRouter(
// //     routes: [
// //       GoRoute(
// //         path: '/',
// //         builder: (context, state) => HomePageData(),
// //       ),
// //       GoRoute(
// //         path: '/details',
// //         builder: (context, state) => DetailsPage(),
// //       ),
// //     ],
// //   );
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //         debugShowCheckedModeBanner: false,
// //         title: 'Flutter Demo',
// //         theme: ThemeData(
// //           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //           useMaterial3: true,
// //         ),
// //         home:const QuoteView()
// //         //  EmployeeData()
// //         //  DesignPage()
// //         // MultiResponsePage()
// //         // LoginUiBloc()
// //         // RepositoryProvider(
// //         //   create: (context) => AuthRepository(),
// //         //   child: const LoginPage(),
// //         // )

// //         // BlocProvider(
// //         //   create: (context) => PhoneBloc(ApiCongig()),
// //         //   child: const PhoneDetailPage(),
// //         // )
// //         // const MyHomePage(title: 'Flutter Demo Home Page'),
// //         );
// //   }
// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   return MaterialApp.router(
// //   //     debugShowCheckedModeBanner: false,
// //   //     title: 'Flutter Demo',
// //   //     theme: ThemeData(
// //   //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //   //       useMaterial3: true,
// //   //     ),
// //   //     routerDelegate: _router.routerDelegate,
// //   //     routeInformationParser: _router.routeInformationParser,
// //   //   );
// //   // }
// // }

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({super.key, required this.title});

// //   final String title;

// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   int _counter = 0;

// //   void _incrementCounter() {
// //     setState(() {
// //       _counter++;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// //         title: Text(widget.title),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             const Text(
// //               'You have pushed the button this many times:',
// //             ),
// //             Text(
// //               '$_counter',
// //               style: Theme.of(context).textTheme.headlineMedium,
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _incrementCounter,
// //         tooltip: 'Increment',
// //         child: const Icon(Icons.add),
// //       ), // This trailing comma makes auto-formatting nicer for build methods.
// //     );
// //   }
// // }
// // main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:test_proj/to_do_app_list/api_config.dart';
// import 'package:test_proj/to_do_app_list/data/reposotories/todo_repository_impl.dart';

// import 'package:test_proj/to_do_app_list/presentation/blocs/todo_bloc.dart';
// import 'package:test_proj/to_do_app_list/presentation/blocs/todo_event.dart';
// import 'package:test_proj/to_do_app_list/presentation/screens/todo_list_screen.dart';

// import 'package:test_proj/to_do_app_list/domain/usecases/get_todo_list.dart';
// import 'package:test_proj/to_do_app_list/domain/usecases/add_todo.dart';
// import 'package:test_proj/to_do_app_list/domain/usecases/update_todo.dart';
// import 'package:test_proj/to_do_app_list/domain/usecases/delete_todo.dart';
// import 'package:test_proj/to_do_app_list/domain/usecases/filter_todo.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Initialize the repository and use cases
//     final apiConfig = ApiConfig();
//     final repository = ToDoRepositoryImpl(apiConfig);

//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<ToDoBloc>(
//           create: (context) => ToDoBloc(
//             getToDoList: GetToDoList(repository),
//             addToDo: AddToDo(repository),
//             updateToDo: UpdateToDo(repository),
//             deleteToDo: DeleteToDo(repository),
//             filterToDo: FilterToDo(repository),
//           )..add(GetToDoListEvent()), // Fetch the initial list of todos
//         ),
//       ],
//       child: MaterialApp(
//         title: 'To-Do App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: ToDoListView(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:test_proj/router/go_router.dart';

import 'package:test_proj/to_do_app/data/datasources/task_local_data_source.dart';

import 'package:test_proj/to_do_app/data/datasources/task_local_data_source_impl.dart';
import 'package:test_proj/to_do_app/data/repositories/task_repository.dart';
import 'package:test_proj/to_do_app/data/repositories/task_repository_impl.dart';
import 'package:test_proj/to_do_app/domain/usecases/add_task.dart';
import 'package:test_proj/to_do_app/domain/usecases/delete_task.dart';
import 'package:test_proj/to_do_app/domain/usecases/get_tasks.dart';
import 'package:test_proj/to_do_app/domain/usecases/update_task.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_bloc.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_event.dart';
import 'package:test_proj/to_do_app/presentation/screens/add_task_screen.dart';
import 'package:test_proj/to_do_app/presentation/screens/task_list_screen.dart';

final sl = GetIt.instance;

void initDependencies() {
  sl.registerLazySingleton<TaskLocalDataSource>(() => TaskLocalDataSourceImpl());
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl())); // Ensure UpdateTask is registered
  sl.registerLazySingleton(() => DeleteTask(sl()));

  sl.registerFactory(() => TaskBloc(
    getTasks: sl(),
    addTask: sl(),
    updateTask: sl(),
    deleteTask: sl(),
  ));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencies();
  runApp(MyApp());
}
