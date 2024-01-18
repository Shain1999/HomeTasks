import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart' as TitleObj;
import 'package:hometasks/src/features/tasks/presentation/bloc/addTask/task_add_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_event.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/date_picker.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/estimated_time_picker.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/form_field_widget.dart';



class DateTimeForm extends StatelessWidget {
  const DateTimeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SecondStepBloc, SecondStepFormState>(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: _DueDateInput()),
                Gap(10),
                Expanded(child: _EstimatedTimeInput()),
              ],
            ),
            Gap(12),
            _TaskReccuringInput(),
            Gap(12),
            _TaskRemindersInput(),
            Gap(12),
            Row(
              children: [
                _SubmitButton(),
                Gap(10),
                _CancelButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class _TaskReccuringInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondStepBloc, SecondStepFormState>(
      buildWhen: (previous, current) =>
      previous.reccuringField != current.reccuringField,
      builder: (context, state) {
        if (state.reccuringField != null) {
          return dropDownTaskReccuringFormField(taskReccuring: state.reccuringField, onReccuringChanged: (value) {
            context.read<SecondStepBloc>().add(
              UpdateTaskReccuringEvent(value!),
            );
          },);
        } else {
          return Center();
        }
      },
    );
  }
}
class _TaskRemindersInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondStepBloc, SecondStepFormState>(
      buildWhen: (previous, current) =>
      previous.reminderField != current.reminderField,
      builder: (context, state) {
        if (state.reminderField != null) {
          return dropDownTaskRemindersFormField(taskReminders: state.reminderField, onRemindersChanged: (value) {
            context.read<SecondStepBloc>().add(
              UpdateTaskReminderEvent(value!),
            );
          },);
        } else {
          return Center();
        }
      },
    );
  }
}


class _DueDateInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondStepBloc, SecondStepFormState>(
      buildWhen: (previous, current) =>
      previous.dueDateField != current.dueDateField,
      builder: (context, state) {
        if (state.dueDateField != null) {
          return createDatePicker(
            context,
            state.dueDateField,
            'Due Date',
                (newDate) {
              context.read<SecondStepBloc>().add(
                UpdateDueDateEvent(newDate),
              );
            },
          );
        } else {
          return Center();
        }
      },
    );
  }
}
class _EstimatedTimeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondStepBloc, SecondStepFormState>(
      buildWhen: (previous, current) =>
      previous.estimatedTimeField != current.estimatedTimeField,
      builder: (context, state) {
        if (state.estimatedTimeField != null) {
          return DurationPickerWidget(initialDuration: state.estimatedTimeField,
            label: 'Estimated Time',
            onChange: (newDuration) {
              context.read<SecondStepBloc>().add(
                UpdateEstimatedTimeEvent(newDuration),
              );
            },
          );
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
    return BlocBuilder<SecondStepBloc, SecondStepFormState>(
      buildWhen: (previous, current) => previous.status != current.status || current != null,
      builder: (context, state) {
        if (state == null) {
          // Handle the case where the state is null (e.g., loading or initial state)
          return const CircularProgressIndicator();
        }

        return ElevatedButton(
          key: const Key('timeInfoForm_submitButton_elevatedButton'),
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: state.isFormValid
              ? () => context.read<SecondStepBloc>().add(OnStepSubmit(step: state.step))
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
    return BlocBuilder<SecondStepBloc, SecondStepFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == ChildStepFormStatus.loading
            ? const SizedBox.shrink()
            : TextButton(
          key: const Key('timeInfoForm_cancelButton_elevatedButton'),
          onPressed: () {},
          child: const Text('CANCEL'),
        );
      },
    );
  }
}