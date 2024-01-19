import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

import '../../../../../../helpers/test_helper.mocks.dart';

void main() {

  group('SecondStepFormBloc', () {
    late AddTaskUseCase addTaskUseCase;
    late MockDomainFirebaseTaskRepository mockDomainFirebaseTaskRepository;
    late MainFormBloc mainFormBloc;
    late SecondStepBloc secondStepBloc;

    setUp(() {
      mockDomainFirebaseTaskRepository = MockDomainFirebaseTaskRepository();
      addTaskUseCase = AddTaskUseCase(repository: mockDomainFirebaseTaskRepository);
      mainFormBloc=MainFormBloc(addTaskUseCase: addTaskUseCase);
      secondStepBloc=SecondStepBloc(mainFormBloc: mainFormBloc);
    });

    tearDown(() {
      secondStepBloc.close();
    });

    blocTest<SecondStepBloc, SecondStepFormState>(
      'emits [ChildStepFormStatus.loading] when OnStepSubmit is added',

      act: (bloc) => bloc.add(OnStepSubmit(step: CurrentStep.step2)),
      build:()=> secondStepBloc,
      expect: () =>
      [ isA<SecondStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.loading,
      ), isA<SecondStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.success,
      )
      ],
    );

    blocTest<SecondStepBloc, SecondStepFormState>(
      'emits [ChildStepFormStatus.failure] when OnStepFailure is added',
      build: () => SecondStepBloc(mainFormBloc: mainFormBloc),
      act: (bloc) => bloc.add(OnStepFailure(step: CurrentStep.step2)),
      expect: () =>
      [  isA<SecondStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.failure,
      )
      ],
    );

    blocTest<SecondStepBloc, SecondStepFormState>(
      'emits [UpdateEstimatedTimeEvent.change] when UpdateEstimatedTimeEvent is added',
      build: () => secondStepBloc,
      act: (bloc) => bloc.add(const UpdateEstimatedTimeEvent(Duration(hours: 6))),
      expect: () => [isA<SecondStepFormState>().having(
            (state) => state.estimatedTimeField,
        'estimatedTimeField',
        Duration(hours: 6),
      )],
    );

    // Add more tests as needed
  });
}
