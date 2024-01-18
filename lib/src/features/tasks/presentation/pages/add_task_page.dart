import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/addTask/task_add_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
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
      }, child: Icon(Icons.refresh))
      ],),
      body: BlocConsumer<MainFormBloc, MainFormState>(
        builder: (context, state) {

          if (state.status == MainFormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == MainFormStatus.failure) {
            return Center(child: Text(state.errorMessage!),);
          }

          if (state.status == MainFormStatus.initial) {

            return Stepper(steps: [],currentStep: state.currentStep!.index,);
          }
          return const Center();

        },
        listener: (context, state) {
          if (state.status == MainFormStatus.success) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("Operation Success")));
          }
          if (state.status == MainFormStatus.error) {

            ScaffoldMessenger.of(context)
                .showSnackBar(
                const SnackBar(content: Text("An error accourd check your form")));
          }
        },
      ),
    );
  }

}
