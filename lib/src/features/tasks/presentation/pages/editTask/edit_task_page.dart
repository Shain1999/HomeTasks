import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hometasks/src/core/widgets/app_bar_widget.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_state.dart';

class EditTaskScreen extends StatelessWidget {
  final Task task;
  const EditTaskScreen({super.key, required this.task});
  @override
  Widget build(BuildContext context) {
    final taskTitleAppBar=task.title.value;
    return Scaffold(
      appBar: AppBarWidget(routeName: '$taskTitleAppBar',),
      body: BlocConsumer<TaskEditBloc, TaskState>(
        builder: (context, state) {
          if (state.status == TaskStatus.initial) {
            context.read<TaskEditBloc>().add(OnInitEditEvent(task: task));
            return const Center(child: Text("Initial"));
          }
          if (state.status == TaskStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == TaskStatus.failure) {
            return Center(child: Text(state.errorMessage!),);
          }
          if (state.status == TaskStatus.success) {
            final task = state.task;

            return Center(child: Text(task!.description.value),);
          }
          return Container(); // Placeholder for other states if needed
        },
        listener: (context, state) {
          if (state.status == TaskStatus.success) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("Operation Success")));
          }
          if (state.status == TaskStatus.failure) {

            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("Operation Failed")));
          }

        },
      ),
    );
  }
}