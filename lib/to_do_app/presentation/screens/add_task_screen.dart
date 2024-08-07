import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/to_do_app/domain/entities/task.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_bloc.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_event.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final task = Task(
                  id: DateTime.now().toString(),
                  title: _titleController.text,
                  isCompleted: false,
                );
                context.read<TaskBloc>().add(AddTaskEvent(task));
                Navigator.pop(context);
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
