import 'package:test_proj/to_do_app_list/domain/repositories/todo_repository.dart';

class DeleteToDo {
  final ToDoRepository repository;

  DeleteToDo(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteToDo(id);
  }
}