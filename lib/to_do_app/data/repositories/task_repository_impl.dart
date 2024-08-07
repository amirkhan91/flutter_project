
import 'package:test_proj/to_do_app/data/datasources/task_local_data_source.dart';
import 'package:test_proj/to_do_app/data/models/task_model.dart';
import 'package:test_proj/to_do_app/data/repositories/task_repository.dart';
import 'package:test_proj/to_do_app/domain/entities/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl(this.localDataSource);

  @override
  Future<List<Task>> getTasks() async {
    final taskModels = await localDataSource.getTasks();
    return taskModels.map((model) => Task(
      id: model.id,
      title: model.title,
      isCompleted: model.isCompleted,
    )).toList();
  }

  @override
  Future<void> addTask(Task task) async {
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
    );
    await localDataSource.addTask(taskModel);
  }

  @override
  Future<void> updateTask(Task task) async {
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      isCompleted: task.isCompleted,
    );
    await localDataSource.updateTask(taskModel);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await localDataSource.deleteTask(taskId);
  }
  
  @override
  Future<void> completeTask(String taskId) {
   
    throw UnimplementedError();
  }
}