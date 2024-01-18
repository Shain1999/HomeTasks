import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart' as TitleObj;
import 'package:hometasks/src/features/tasks/presentation/bloc/addTask/task_add_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_event.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/form_field_widget.dart';



class GeneralInfoForm extends StatelessWidget {
  const GeneralInfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FirstStepBloc, FirstStepFormState>(
      // Listens to the bloc state if there is any submission failure.
      // A Snackbar will be shown if there is any [FormzStatus.submissionFailure].
      listener: (context, state) {
        if (state.status==ChildStepFormStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Something went wrong!')));
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            _TitleInput(),
            const SizedBox(height: 12.0),
            _DescriptionInput(),
            const SizedBox(height: 12.0),
            _TaskCategoryInput(),
            const SizedBox(height: 12.0),
            _TaskPriorityInput(),
            const SizedBox(height: 12.0),
            Row(
              children: [
                _SubmitButton(),
                const SizedBox(width: 8.0),
                _CancelButton(),
              ],
            ),
          ],
        ),
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
class _TaskCategoryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstStepBloc, FirstStepFormState>(
      buildWhen: (previous, current) =>
      previous.categoryField != current.categoryField,
      builder: (context, state) {
        if (state.categoryField != null) {
          return dropDownTaskCategoryFormField(taskCategory: state.categoryField, onCategoryChanged: (value) {
            context.read<FirstStepBloc>().add(
              UpdateTaskCategoryEvent(value!),
            );
          },);
        } else {
          return Center();
        }
      },
    );
  }
}
class _TaskPriorityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstStepBloc, FirstStepFormState>(
      buildWhen: (previous, current) =>
      previous.priorityField != current.priorityField,
      builder: (context, state) {
        if (state.priorityField != null) {
          return dropDownTaskPriorityFormField(taskPriority: state.priorityField, onPriorityChanged: (value) {
            context.read<FirstStepBloc>().add(
              UpdateTaskPriorityEvent(value!),
            );
          },);
        } else {
          return Center();
        }
      },
    );
  }
}


class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstStepBloc, FirstStepFormState>(
      buildWhen: (previous, current) => previous.status != current.status || current != null,
      builder: (context, state) {
        if (state == null) {
          // Handle the case where the state is null (e.g., loading or initial state)
          return const CircularProgressIndicator();
        }

        return ElevatedButton(
          key: const Key('generalInfoForm_submitButton_elevatedButton'),
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: state.isFormValid
              ? () => context.read<FirstStepBloc>().add(OnStepSubmit(step: state.step))
              : null,
          child: const Text('SUBMIT'),
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstStepBloc, FirstStepFormState>(
      buildWhen: (previous, current) => previous.status != current.status || current != null,
      builder: (context, state) {
        if (state == null) {
          // Handle the case where the state is null (e.g., loading or initial state)
          return const SizedBox.shrink();
        }

        return state.status == ChildStepFormStatus.loading
            ? const SizedBox.shrink()
            : TextButton(
          key: const Key('generalInfoForm_cancelButton_elevatedButton'),
          onPressed: () {
            // Handle cancel button action
          },
          child: const Text('CANCEL'),
        );
      },
    );
  }
}
