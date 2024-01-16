import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/addTask/task_add_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_state.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"), actions: [ElevatedButton(onPressed: () {
      }, child: Icon(Icons.save)), ElevatedButton(onPressed: () {
        context.read<TaskAddBloc>().add(const OnFormSubmitEvent());
      }, child: Icon(Icons.refresh))
      ],),
      body: BlocConsumer<TaskAddBloc, TaskState>(
        builder: (context, state) {
          if (state.status == TaskStatus.initial) {
            context.read<TaskAddBloc>().add(const OnInitEvent());
            return const Center(child: Text("Initial"));
          }
          if (state.status == TaskStatus.loading) {
            return const Center(child: const CircularProgressIndicator());
          }
          if (state.status == TaskStatus.failure) {
            return Center(child: Text(state.errorMessage!),);
          }

          return Container(); // Placeholder for other states if needed
        },
        listener: (context, state) {
          if (state.status == TaskStatus.success) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("Operation Success")));
          }
          if (state.status == TaskStatus.error) {

            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("An error accourd check your form")));
          }
        },
      ),
    );
  }

}
