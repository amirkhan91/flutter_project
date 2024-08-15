import 'package:test_proj/to_do_app_list/domain/entities/todo_entity.dart';
import 'package:test_proj/to_do_app_list/domain/repositories/todo_repository.dart';

class UpdateToDo {
  final ToDoRepository repository;

  UpdateToDo(this.repository);

  Future<void> call(ToDoEntity toDo) async {
    return await repository.updateToDo(toDo);
  }
}