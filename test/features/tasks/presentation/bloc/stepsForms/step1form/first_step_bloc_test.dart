import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart' as desc;

import '../../../../../../helpers/test_helper.mocks.dart';

void main() {
  late FirstStepBloc firstStepBloc;
  late MockDomainFirebaseTaskRepository mockDomainFirebaseTaskRepository;
  late MainFormBloc mainFormBloc;
  late AddTaskUseCase addTaskUseCase;
  group('FirstStepFormBloc', () {
    final Map<String,dynamic> firstStepTestValues={
      'title':Title.create('test title'),
      'description':desc.Description.create('test desc'),
      'category':TaskCategory.cleaning,
      'priority':TaskPriority.low
    };
    setUp(() {
      mockDomainFirebaseTaskRepository = MockDomainFirebaseTaskRepository();
      addTaskUseCase = AddTaskUseCase(repository: mockDomainFirebaseTaskRepository);
      mainFormBloc=MainFormBloc(addTaskUseCase: addTaskUseCase);
      firstStepBloc = FirstStepBloc(mainFormBloc: mainFormBloc);
    });

    tearDown(() {
      firstStepBloc.close();
      mainFormBloc.close();
    });
    blocTest<FirstStepBloc, FirstStepFormState>(
      'emits [ChildStepFormStatus.loading] when OnStepSubmit is added',
      build: () =>firstStepBloc,
      act: (bloc) => bloc.OnStepSubmitTest(),
      expect: () =>
      [ isA<FirstStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.loading,
      )
      ],
    );

    blocTest<FirstStepBloc, FirstStepFormState>(
      'emits [ChildStepFormStatus.failure] when OnStepFailure is added',
      build: () => firstStepBloc,
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
      build: () => firstStepBloc,
      act: (bloc) => bloc.OnStepSuccessTest(),
      expect: () => [isA<ChildStepFormState>().having(
            (state) => state.status,
        'status',
        ChildStepFormStatus.success,
      )],
    );

    // Add more tests as needed
  });
}
