import 'package:bloc/bloc.dart';
import 'package:test_proj/to_do_app/domain/usecases/add_task.dart';
import 'package:test_proj/to_do_app/domain/usecases/delete_task.dart';
import 'package:test_proj/to_do_app/domain/usecases/get_tasks.dart';
import 'package:test_proj/to_do_app/domain/usecases/update_task.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_event.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;

  TaskBloc({
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(TaskLoading()) {
    on<LoadTasksEvent>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await getTasks();
        if (tasks.isEmpty) {
          emit(TaskEmpty());
        } else {
          emit(TaskLoaded(tasks));
        }
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<AddTaskEvent>((event, emit) async {
      try {
        await addTask(event.task);
        add(LoadTasksEvent()); // Refresh the task list after adding a task
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      try {
        await updateTask(event.task); // Ensure updateTask is a callable method
        add(LoadTasksEvent()); // Refresh the task list after update
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await deleteTask(event.taskId);
        add(LoadTasksEvent()); // Refresh the task list after deletion
      } catch (e) {
        emit(TaskError(e.toString()));
      }
    });
  }
}