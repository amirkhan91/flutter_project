import 'package:test_proj/to_do_app_list/domain/entities/todo_entity.dart';

abstract class ToDoRepository {
  Future<List<ToDoEntity>> getToDoList();
  Future<void> addToDo(ToDoEntity toDo);
  Future<void> updateToDo(ToDoEntity toDo);
  Future<void> deleteToDo(int id);
  Future<List<ToDoEntity>> filterToDoList(bool showCompleted);
}
