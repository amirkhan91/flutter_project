
import 'package:test_proj/to_do_app/data/datasources/task_local_data_source.dart';
import 'package:test_proj/to_do_app/data/models/task_model.dart';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final List<TaskModel> _tasks = [];

  @override
  Future<List<TaskModel>> getTasks() async {
    return _tasks;
  }

  @override
  Future<void> addTask(TaskModel taskModel) async {
    _tasks.add(taskModel);
  }

  @override
  Future<void> updateTask(TaskModel taskModel) async {
    final index = _tasks.indexWhere((task) => task.id == taskModel.id);
    if (index != -1) {
      _tasks[index] = taskModel;
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    _tasks.removeWhere((task) => task.id == taskId);
  }
}
