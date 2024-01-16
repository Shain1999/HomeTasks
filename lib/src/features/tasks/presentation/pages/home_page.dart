import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_list_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_list_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_list_state.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"), actions: [ElevatedButton(onPressed: () {
        context.goNamed('addTask');
      }, child: Icon(Icons.add)), ElevatedButton(onPressed: () {
        context.read<TaskListBloc>().add(const OnGetTasks());
      }, child: Icon(Icons.refresh))
      ],),
      body: BlocConsumer<TaskListBloc, TasksListState>(
        builder: (context, state) {
          if (state.status == TasksViewStatus.initial) {
            context.read<TaskListBloc>().add(const OnGetTasks());
            return const Center(child: Text("Initial"));
          }
          if (state.status == TasksViewStatus.loading) {
            return const Center(child: const CircularProgressIndicator());
          }
          if (state.status == TasksViewStatus.failure) {
            return Center(child: Text(state.errorMessage!),);
          }
          if (state.status == TasksViewStatus.success) {
            final tasks = state.tasks ?? [];

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return _buildTaskListTile(task);
              },
            );
          }
          return Container(); // Placeholder for other states if needed
        },
        listener: (context, state) {
          if (state.status == TasksViewStatus.success) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("Operation Success")));
          }
          if (state.status == TasksViewStatus.failure) {

            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("Operation Failed")));
          }

        },
      ),
    );
  }

  Widget _buildTaskListTile(Task task) {
    // Implement your custom list tile widget
    return ListTile(
      title: Text(task.title.value),
      subtitle: Text(task.isCompleted ? "Completed" : "Ongoing"),
      // Add more widgets as needed
    );
  }


}