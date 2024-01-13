import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_state.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"), actions: [ElevatedButton(onPressed: () {

      }, child: Icon(Icons.save)), ElevatedButton(onPressed: () {
        context.read<TaskEditBloc>().add(const OnFormSubmitAdd());
      }, child: Icon(Icons.refresh))
      ],),
      body: BlocConsumer<TaskEditBloc, TaskEditState>(
        builder: (context, state) {
          if (state.status == TaskEditStatus.initial) {
            context.read<TaskEditBloc>().add(const OnInitAdd());
            return const Center(child: Text("Initial"));
          }
          if (state.status == TaskEditStatus.loading) {
            return const Center(child: const CircularProgressIndicator());
          }
          if (state.status == TaskEditStatus.failure) {
            return Center(child: Text(state.errorMessage!),);
          }

          return Container(); // Placeholder for other states if needed
        },
        listener: (context, state) {
          if (state.status == TaskEditStatus.success) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("Operation Success")));
          }
          if (state.status == TaskEditStatus.error) {

            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("An error accourd check your form")));
          }
        },
      ),
    );
  }

}
