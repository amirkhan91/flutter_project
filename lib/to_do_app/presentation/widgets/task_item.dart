import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/to_do_app/domain/entities/task.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_bloc.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_event.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      trailing: IconButton(
        icon: Icon(task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank),
        onPressed: () {
          final updatedTask = Task(
            id: task.id,
            title: task.title,
            isCompleted: !task.isCompleted,
          );
          context.read<TaskBloc>().add(UpdateTaskEvent(updatedTask));
        },
      ),
      onLongPress: () {
        context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
      },
    );
  }
}
