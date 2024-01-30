import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/score/score.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart' as TitleObj;
import 'package:hometasks/src/features/tasks/presentation/bloc/addTask/task_add_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_event.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/form_field_widget.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/task_comments_widget.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/task_notes_widget.dart';
import 'package:hometasks/src/features/users/presentation/widgets/users_selection_dropdown.dart';



class AdditionalInfoForm extends StatelessWidget {
  const AdditionalInfoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThirdStepBloc, ThirdStepFormState>(
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
            _ScoreInput(),
            const SizedBox(height: 12.0),
            _CommentsInput(),
            const SizedBox(height: 12.0),
            _NotesInput(),
            const SizedBox(height: 12.0),
            _AssignedUsersUidsInput(),
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
class _AssignedUsersUidsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdStepBloc, ThirdStepFormState>(
      buildWhen: (previous, current) =>
      previous.assignedUserUidsField != current.assignedUserUidsField,
      builder: (context, state) {
        if (state.assignedUserUidsField != null) {
          return UserSelectionDropdown(onChangeHandler: (value) {
            context.read<ThirdStepBloc>().add(
              UpdateAssignedUserUidList(value!),
            );
          },);
        } else {
          return Center();
        }
      },

    );
  }
}
class _CommentsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdStepBloc, ThirdStepFormState>(
      buildWhen: (previous, current) =>
      previous.commentsField != current.commentsField,
      builder: (context, state) {
        if (state.commentsField != null) {
          return CommentWidget(onChangeHandler: (value) {
            context.read<ThirdStepBloc>().add(
              UpdateAssignedUserUidList(value!),
            );
          });
        } else {
          return Center();
        }
      },

    );
  }
}
class _NotesInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdStepBloc, ThirdStepFormState>(
      buildWhen: (previous, current) =>
      previous.notesField != current.notesField,
      builder: (context, state) {
        if (state.notesField != null) {
          return NotesWidget(onChangeHandler: (value) {
            context.read<ThirdStepBloc>().add(
              UpdateNotesList(value!),
            );
          });
        } else {
          return Center();
        }
      },

    );
  }
}
class _ScoreInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThirdStepBloc, ThirdStepFormState>(
      buildWhen: (previous, current) => previous.scoreField != current.scoreField,
      builder: (context, state) {
        if (state.scoreField!=null) {
          return intFormField<String,Score>(formField: state.scoreField);
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
    return BlocBuilder<ThirdStepBloc, ThirdStepFormState>(
      buildWhen: (previous, current) => previous.status != current.status || current!=null,
      builder: (context, state){
        if (state == null) {
          return const CircularProgressIndicator();
        }

        return ElevatedButton(
          key: const Key('additionalInfo_submitButton_elevatedButton'),
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: state.isFormValid
              ? () => context.read<ThirdStepBloc>().add(OnStepSubmit(step: state.step))
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
    return BlocBuilder<ThirdStepBloc, ThirdStepFormState>(
      buildWhen: (previous, current) => previous.status != current.status || current != null,
      builder: (context, state) {
        if (state == null) {
          // Handle the case where the state is null (e.g., loading or initial state)
          return const SizedBox.shrink();
        }

        return state.status == ChildStepFormStatus.loading
            ? const SizedBox.shrink()
            : TextButton(
          key: const Key('additionalInfo_cancelButton_elevatedButton'),
          onPressed: () {
            // Handle cancel button action
          },
          child: const Text('CANCEL'),
        );
      },
    );
  }
}
