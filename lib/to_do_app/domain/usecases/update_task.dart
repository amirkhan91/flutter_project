import 'package:test_proj/to_do_app/domain/entities/task.dart';
import 'package:test_proj/to_do_app/domain/repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository repository;

  UpdateTask(this.repository);

  Future<void> call(Task task) async {
    await repository.updateTask(task);
  }
}
