
import 'package:test_proj/to_do_app/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task); 
  Future<void> deleteTask(String taskId);
}
