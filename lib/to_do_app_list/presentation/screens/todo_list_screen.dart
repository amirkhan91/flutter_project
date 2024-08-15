import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_proj/to_do_app_list/domain/entities/todo_entity.dart';
import 'package:test_proj/to_do_app_list/presentation/blocs/todo_bloc.dart';
import 'package:test_proj/to_do_app_list/presentation/blocs/todo_event.dart';
import 'package:test_proj/to_do_app_list/presentation/blocs/todo_state.dart';

class ToDoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'All':
                  context.read<ToDoBloc>().add(GetToDoListEvent());
                  break;
                case 'Completed':
                  context.read<ToDoBloc>().add(FilterToDoEvent(true));
                  break;
                case 'Pending':
                  context.read<ToDoBloc>().add(FilterToDoEvent(false));
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'All', child: Text('All')),
              PopupMenuItem(value: 'Completed', child: Text('Completed')),
              PopupMenuItem(value: 'Pending', child: Text('Pending')),
            ],
          ),
        ],
      ),
      body: BlocBuilder<ToDoBloc, ToDoState>(
        builder: (context, state) {
          if (state is ToDoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ToDoLoaded) {
            final toDoList = state.toDoList;
            if (toDoList.isEmpty) {
              return Center(child: Text('No tasks available'));
            }
            return ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                final toDo = toDoList[index];
                return ListTile(
                  title: Text(toDo.title ?? 'No title'),
                  subtitle: Text(toDo.body ?? 'No description'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: toDo.isCompleted,
                        onChanged: (value) {
                          final updatedToDo = ToDoEntity(
                            userId: toDo.userId,
                            id: toDo.id,
                            title: toDo.title,
                            body: toDo.body,
                            isCompleted: value ?? false,
                          );
                          context.read<ToDoBloc>().add(UpdateToDoEvent(updatedToDo));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          context.read<ToDoBloc>().add(DeleteToDoEvent(toDo.id ?? 0));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ToDoError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add ToDo screen or display a dialog
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
