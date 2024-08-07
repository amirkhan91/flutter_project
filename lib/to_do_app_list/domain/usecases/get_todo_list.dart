import 'package:test_proj/to_do_app_list/domain/entities/todo_entity.dart';
import 'package:test_proj/to_do_app_list/domain/repositories/todo_repository.dart';

class GetToDoList {
  final ToDoRepository repository;

  GetToDoList(this.repository);

  Future<List<ToDoEntity>> call() async {
    return await repository.getToDoList();
  }
}