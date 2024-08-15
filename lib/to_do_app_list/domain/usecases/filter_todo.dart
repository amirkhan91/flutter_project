import 'package:test_proj/to_do_app_list/domain/entities/todo_entity.dart';
import 'package:test_proj/to_do_app_list/domain/repositories/todo_repository.dart';

class FilterToDo {
  final ToDoRepository repository;

  FilterToDo(this.repository);

  Future<List<ToDoEntity>> call(bool showCompleted) async {
    return await repository.filterToDoList(showCompleted);
  }
}