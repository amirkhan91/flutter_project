import 'package:test_proj/to_do_app/domain/entities/task.dart';


abstract class TaskRepository {
  Future<void> addTask(Task task);
  Future<void> completeTask(String taskId);
  Future<void> deleteTask(String taskId);
  Future<List<Task>> getTasks();
}
