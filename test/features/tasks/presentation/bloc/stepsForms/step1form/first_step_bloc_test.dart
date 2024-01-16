import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

void main() {
  group('FirstStepFormBloc', () {
    blocTest<FirstStepBloc, FirstStepFormState>(
      'emits [ChildStepFormStatus.loading] when OnStepSubmit is added',
      build: () => FirstStepBloc(),
      act: (bloc) => bloc.add(OnStepSubmit(step: CurrentStep.step1)),
      expect: () =>
      [ isA<ChildStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.loading,
      ), isA<ChildStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.success,
      )
      ],
    );

    blocTest<FirstStepBloc, FirstStepFormState>(
      'emits [ChildStepFormStatus.failure] when OnStepFailure is added',
      build: () => FirstStepBloc(),
      act: (bloc) => bloc.add(OnStepFailure(step: CurrentStep.step1)),
      expect: () =>
      [  isA<ChildStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.failure,
      )
      ],
    );

    blocTest<FirstStepBloc, FirstStepFormState>(
      'emits [ChildStepFormStatus.success] when OnStepSuccess is added',
      build: () => FirstStepBloc(),
      act: (bloc) => bloc.add(OnStepSuccess(step: CurrentStep.step1)),
      expect: () => [isA<ChildStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.success,
      )],
    );

    // Add more tests as needed
  });
}
