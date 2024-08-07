import 'package:equatable/equatable.dart';

import 'package:test_proj/to_do_app/domain/entities/task.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  TaskLoaded(this.tasks);

  @override
  List<Object> get props => [tasks];
}

class TaskEmpty extends TaskState {}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);

  @override
  List<Object> get props => [message];
}
