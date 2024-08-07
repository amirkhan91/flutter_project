// import 'package:get_it/get_it.dart';
// import 'package:test_proj/to_do_app/data/datasources/task_local_data_source.dart';
// import 'package:test_proj/to_do_app/data/datasources/task_local_data_source_impl.dart';
// import 'package:test_proj/to_do_app/data/repositories/task_repository.dart';
// import 'package:test_proj/to_do_app/data/repositories/task_repository_impl.dart';
// import 'package:test_proj/to_do_app/domain/usecases/add_task.dart';
// import 'package:test_proj/to_do_app/domain/usecases/get_tasks.dart';
// import 'package:test_proj/to_do_app/presentation/bloc/task/task_bloc.dart';


// final sl = GetIt.instance;

// void init() {
//   // BLoC
//   sl.registerFactory(() => TaskBloc(getTasks: sl(), addTask: sl()));

//   // Use cases
//   sl.registerLazySingleton(() => GetTasks(sl()));
//   sl.registerLazySingleton(() => AddTask(sl()));

//   // Repository
//   sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));

//   // Data sources
//   sl.registerLazySingleton<TaskLocalDataSource>(() => TaskLocalDataSourceImpl());
// }
