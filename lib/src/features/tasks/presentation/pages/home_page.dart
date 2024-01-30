import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_list_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_list_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_list_state.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/homePage/task_card.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/homePage/task_list_widget.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton:ElevatedButton(onPressed: () {
        context.goNamed('addTask');
      }, child: Icon(Icons.add)) ,
      appBar: AppBar(
        title: Text("Home"), actions: [ ElevatedButton(onPressed: () {
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

            return TaskListWidget(tasks);
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
}