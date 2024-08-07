import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_proj/to_do_app/domain/usecases/add_task.dart';
import 'package:test_proj/to_do_app/domain/usecases/delete_task.dart';
import 'package:test_proj/to_do_app/domain/usecases/get_tasks.dart';
import 'package:test_proj/to_do_app/domain/usecases/update_task.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_bloc.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_state.dart';

class GetTasksMock extends Mock implements GetTasks {}
class AddTaskMock extends Mock implements AddTask {}
class UpdateTaskMock extends Mock implements UpdateTask {}
class DeleteTaskMock extends Mock implements DeleteTask {}

void main() {
  late TaskBloc taskBloc;
  late GetTasksMock getTasksMock;
  late AddTaskMock addTaskMock;
  late UpdateTaskMock updateTaskMock;
  late DeleteTaskMock deleteTaskMock;

  setUp(() {
    getTasksMock = GetTasksMock();
    addTaskMock = AddTaskMock();
    updateTaskMock = UpdateTaskMock();
    deleteTaskMock = DeleteTaskMock();
    taskBloc = TaskBloc(
      getTasks: getTasksMock,
      addTask: addTaskMock,
      updateTask: updateTaskMock,
      deleteTask: deleteTaskMock,
    );
  });

  test('initial state is TaskLoading', () {
    expect(taskBloc.state, TaskLoading());
  });

 
}