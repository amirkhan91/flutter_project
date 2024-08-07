
import 'package:test_proj/to_do_app/data/repositories/task_repository.dart';
import 'package:test_proj/to_do_app/domain/entities/task.dart';

class GetTasks {
  final TaskRepository repository;

  GetTasks(this.repository);

  Future<List<Task>> call() async {
    return await repository.getTasks();
  }
}
