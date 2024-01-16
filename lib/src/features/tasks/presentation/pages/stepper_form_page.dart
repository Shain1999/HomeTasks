import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart' as TitleObj;
import 'package:hometasks/src/features/tasks/presentation/bloc/addTask/task_add_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_event.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/form_field_widget.dart';

class StepperFormPage extends StatelessWidget {
  const StepperFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
        actions: [
          ElevatedButton(onPressed: () {}, child: Icon(Icons.save)),
          ElevatedButton(onPressed: () {
            ScaffoldMessenger.of(context)
          .showSnackBar(
            SnackBar(
              content: Text(context.read<FirstStepBloc>().state.titleField!.value.toString())));

          }, child: Icon(Icons.refresh))
        ],),
      body: Stepper(steps: [
        Step(
          title: Text('Step1'), content: BlocListener<FirstStepBloc, FirstStepFormState>(

          listener: (context, state) {
            if (state.status == ChildStepFormStatus.success) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  const SnackBar(content: Text("Operation Success")));
            }
            if (state.status == ChildStepFormStatus.error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  const SnackBar(
                      content: Text("An error accourd check your form")));
            }
            if(state.titleField?.status==FieldStatus.valid){
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  const SnackBar(
                      content: Text("good input")));
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                _TitleInput(),
                const SizedBox(height: 12.0),
                _DescriptionInput(),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
        ),)
      ],

      ),
    );
  }
}
class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstStepBloc, FirstStepFormState>(
      buildWhen: (previous, current) => previous.titleField != current.titleField,
      builder: (context, state) {
        if (state.titleField!=null) {
          return stringFormField<String,TitleObj.Title>(formField: state.titleField);
        } else {
          return Center();
        }
      },

    );
  }
}
class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstStepBloc, FirstStepFormState>(
      buildWhen: (previous, current) =>
      previous.descriptionField != current.descriptionField,
      builder: (context, state) {
        if (state.descriptionField != null) {
          return stringFormField<String, Description>(
              formField: state.descriptionField);
        } else {
          return Center();
        }
      },

    );
  }
}