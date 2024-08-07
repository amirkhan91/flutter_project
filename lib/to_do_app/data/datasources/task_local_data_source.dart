
import 'package:test_proj/to_do_app/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel taskModel);
  Future<void> updateTask(TaskModel taskModel); 
  Future<void> deleteTask(String taskId);
}
