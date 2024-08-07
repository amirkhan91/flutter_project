import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/to_do_app_list/domain/usecases/add_todo.dart';
import 'package:test_proj/to_do_app_list/domain/usecases/delete_todo.dart';
import 'package:test_proj/to_do_app_list/domain/usecases/filter_todo.dart';
import 'package:test_proj/to_do_app_list/domain/usecases/get_todo_list.dart';
import 'package:test_proj/to_do_app_list/domain/usecases/update_todo.dart';
import 'package:test_proj/to_do_app_list/presentation/blocs/todo_event.dart';
import 'package:test_proj/to_do_app_list/presentation/blocs/todo_state.dart';


class ToDoBloc extends Bloc<ToDoEvent, ToDoState> {
  final GetToDoList getToDoList;
  final AddToDo addToDo;
  final UpdateToDo updateToDo;
  final DeleteToDo deleteToDo;
  final FilterToDo filterToDo;

  ToDoBloc({
    required this.getToDoList,
    required this.addToDo,
    required this.updateToDo,
    required this.deleteToDo,
    required this.filterToDo,
  }) : super(ToDoInitial()) {
    on<GetToDoListEvent>((event, emit) async {
      emit(ToDoLoading());
      try {
        final toDos = await getToDoList();
        emit(ToDoLoaded(toDoList: toDos));
      } catch (e) {
        emit(ToDoError(message: e.toString()));
      }
    });

    on<AddToDoEvent>((event, emit) async {
      try {
        await addToDo(event.toDo);
        add(GetToDoListEvent());
      } catch (e) {
        emit(ToDoError(message: e.toString()));
      }
    });

    on<UpdateToDoEvent>((event, emit) async {
      try {
        await updateToDo(event.toDo);
        add(GetToDoListEvent());
      } catch (e) {
        emit(ToDoError(message: e.toString()));
      }
    });

    on<DeleteToDoEvent>((event, emit) async {
      try {
        await deleteToDo(event.id);
        add(GetToDoListEvent());
      } catch (e) {
        emit(ToDoError(message: e.toString()));
      }
    });

    on<FilterToDoEvent>((event, emit) async {
      try {
        final filteredToDos = await filterToDo(event.showCompleted);
        emit(ToDoLoaded(toDoList: filteredToDos));
      } catch (e) {
        emit(ToDoError(message: e.toString()));
      }
    });
  }
}
