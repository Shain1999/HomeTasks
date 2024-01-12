import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Title"),),
      body: BlocConsumer<TaskViewBloc, TasksViewState>(
        builder: (context, state) {
          if (state.status == TasksViewStatus.initial) {
            return const Center(child: Text("Initial"));
          }
          if (state.status == TasksViewStatus.loading) {
            return const Center(child: const CircularProgressIndicator());
          }
          if(state.status==TasksViewStatus.failure){
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
                .showSnackBar(const SnackBar(content: Text("Operation Success")));
          }
        },
      ),
    );
  }

  Widget _buildTaskListTile(Task task) {
    // Implement your custom list tile widget
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.isCompleted ? "Completed" : "Ongoing"),
      // Add more widgets as needed
    );
  }
}