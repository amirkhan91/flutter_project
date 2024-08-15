import 'package:test_proj/to_do_app_list/api_config.dart';
import 'package:test_proj/to_do_app_list/data/model/to_do_model.dart';
import 'package:test_proj/to_do_app_list/domain/entities/todo_entity.dart';
import 'package:test_proj/to_do_app_list/domain/repositories/todo_repository.dart';


class ToDoRepositoryImpl implements ToDoRepository {
  final ApiConfig apiConfig;

  ToDoRepositoryImpl(this.apiConfig);

  @override
  Future<List<ToDoEntity>> getToDoList() async {
    final List<ToDoListModel> models = await apiConfig.getData();
    return models.map((model) => ToDoEntity(
      userId: model.userId,
      id: model.id,
      title: model.title,
      body: model.body,
      isCompleted: model.completed ?? false, // Default to false if null
    )).toList();
  }

  @override
  Future<void> addToDo(ToDoEntity toDo) async {
    final model = ToDoListModel(
      userId: toDo.userId,
      title: toDo.title,
      body: toDo.body,
      completed: toDo.isCompleted,
    );
    await apiConfig.addToDo(model);
  }

  @override
  Future<void> updateToDo(ToDoEntity toDo) async {
    final model = ToDoListModel(
      userId: toDo.userId,
      id: toDo.id,
      title: toDo.title,
      body: toDo.body,
      completed: toDo.isCompleted,
    );
    await apiConfig.updateToDo(model);
  }

  @override
  Future<void> deleteToDo(int id) async {
    await apiConfig.deleteToDo(id);
  }

  @override
  Future<List<ToDoEntity>> filterToDoList(bool showCompleted) async {
    final List<ToDoEntity> allToDos = await getToDoList();
    return allToDos.where((todo) => todo.isCompleted == showCompleted).toList();
  }
}
