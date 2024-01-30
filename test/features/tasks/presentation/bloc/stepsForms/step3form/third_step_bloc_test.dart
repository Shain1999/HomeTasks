import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

import '../../../../../../helpers/test_helper.mocks.dart';

void main() {
  group('ThirdStepFormBloc', () {
    late AddTaskUseCase addTaskUseCase;
    late MockDomainFirebaseTaskRepository mockDomainFirebaseTaskRepository;
    late MainFormBloc mainFormBloc;
    late ThirdStepBloc thirdStepBloc;

    setUp(() {
      mockDomainFirebaseTaskRepository = MockDomainFirebaseTaskRepository();
      addTaskUseCase = AddTaskUseCase(repository: mockDomainFirebaseTaskRepository);
      mainFormBloc=MainFormBloc(addTaskUseCase: addTaskUseCase);
      thirdStepBloc=ThirdStepBloc(mainFormBloc: mainFormBloc);
    });

    tearDown(() {
      thirdStepBloc.close();
    });
    blocTest<ThirdStepBloc, ThirdStepFormState>(
      'emits [ChildStepFormStatus.loading] when OnStepSubmit is added',
      build: () => thirdStepBloc,
      act: (bloc) => bloc.add(OnStepSubmit(step: CurrentStep.step3)),
      expect: () =>
      [ isA<ChildStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.loading,
      )
      ],
    );

    blocTest<ThirdStepBloc, ThirdStepFormState>(
      'emits [ChildStepFormStatus.failure] when OnStepFailure is added',
      build: () => thirdStepBloc,
      act: (bloc) => bloc.add(OnStepFailure(step: CurrentStep.step3)),
      expect: () =>
      [  isA<ChildStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.failure,
      )
      ],
    );

    // Add more tests as needed
  });
}
