import 'package:equatable/equatable.dart';
import 'package:test_proj/to_do_app_list/domain/entities/todo_entity.dart';

abstract class ToDoState extends Equatable {
  const ToDoState();

  @override
  List<Object?> get props => [];
}

class ToDoInitial extends ToDoState {}

class ToDoLoading extends ToDoState {}

class ToDoLoaded extends ToDoState {
  final List<ToDoEntity> toDoList;

  const ToDoLoaded({required this.toDoList});

  @override
  List<Object?> get props => [toDoList];
}

class ToDoError extends ToDoState {
  final String message;

  const ToDoError({required this.message});

  @override
  List<Object?> get props => [message];
}
