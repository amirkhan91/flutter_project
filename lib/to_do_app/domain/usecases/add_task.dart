
import 'package:test_proj/to_do_app/data/repositories/task_repository.dart';
import 'package:test_proj/to_do_app/domain/entities/task.dart';

class AddTask {
  final TaskRepository repository;

  AddTask(this.repository);

  Future<void> call(Task task) async {
    await repository.addTask(task);
  }
}
