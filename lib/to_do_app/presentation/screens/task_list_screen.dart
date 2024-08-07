import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_proj/to_do_app/presentation/bloc/task/task_bloc.dart';
import 'package:test_proj/to_do_app/presentation/bloc/task/task_state.dart';
import 'package:test_proj/to_do_app/presentation/widgets/task_item.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            final tasks = state.tasks;
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskItem(task: tasks[index]);
              },
            );
          } else if (state is TaskEmpty) {
            return Center(child: Text('No tasks available.'));
          } else if (state is TaskError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Center(child: Text('Unexpected state.'));
          }
        },
      ),
    );
  }
}
