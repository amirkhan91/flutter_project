import 'package:equatable/equatable.dart';
import 'package:test_proj/to_do_app_list/domain/entities/todo_entity.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();

  @override
  List<Object?> get props => [];
}

class GetToDoListEvent extends ToDoEvent {}

class AddToDoEvent extends ToDoEvent {
  final ToDoEntity toDo;

  const AddToDoEvent(this.toDo);

  @override
  List<Object?> get props => [toDo];
}

class UpdateToDoEvent extends ToDoEvent {
  final ToDoEntity toDo;

  const UpdateToDoEvent(this.toDo);

  @override
  List<Object?> get props => [toDo];
}

class DeleteToDoEvent extends ToDoEvent {
  final int id;

  const DeleteToDoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class FilterToDoEvent extends ToDoEvent {
  final bool showCompleted;

  const FilterToDoEvent(this.showCompleted);

  @override
  List<Object?> get props => [showCompleted];
}
