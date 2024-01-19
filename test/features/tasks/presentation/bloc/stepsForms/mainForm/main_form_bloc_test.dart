import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart' as desc;
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_bloc.dart';

import '../../../../../../helpers/test_helper.mocks.dart';

void main() {

  late FirstStepBloc firstStepBloc;
  late ThirdStepBloc thirdStepBloc;
  late AddTaskUseCase addTaskUseCase;
  late MockDomainFirebaseTaskRepository mockDomainFirebaseTaskRepository;
  late MainFormBloc mainFormBloc;
  late SecondStepBloc secondStepBloc;


  group('MainBloc Test', () {
    final Map<String,dynamic> firstStepTestValues={
      'title':Title.create('test title'),
      'description':desc.Description.create('test desc'),
      'category':TaskCategory.cleaning,
      'priority':TaskPriority.low
    };
    final Map<String,dynamic> secondStepTestValues={
      'dueDate':DateTime.now(),
      'estimatedTime':Duration(hours: 4),
      'reminders':TaskReminders.daily,
      'reccuring':TaskReccuring.once
    };
    setUp(() {
      mockDomainFirebaseTaskRepository = MockDomainFirebaseTaskRepository();
      addTaskUseCase = AddTaskUseCase(repository: mockDomainFirebaseTaskRepository);
      mainFormBloc=MainFormBloc(addTaskUseCase: addTaskUseCase);
      secondStepBloc=SecondStepBloc(mainFormBloc: mainFormBloc);
      firstStepBloc = FirstStepBloc(mainFormBloc: mainFormBloc);
      thirdStepBloc = ThirdStepBloc(mainFormBloc: mainFormBloc);
    });

    tearDown(() {
      secondStepBloc.close();
      firstStepBloc.close();
      thirdStepBloc.close();
      mainFormBloc.close();
    });

    blocTest<MainFormBloc, MainFormState>(
      'receives OnStepSuccess from FirstStepBloc and updates currentStep and data',
      build: () => mainFormBloc,
      act: (mainBloc) async {
        // Trigger the OnStepSuccess event
        mainFormBloc.add(OnStepSuccess(step: firstStepBloc.state.step, values: firstStepTestValues));

        await expectLater(
          mainFormBloc.stream,
          emits(
            isA<MainFormState>().having(
                  (state) => state.currentStep,
              'currentStep',
              CurrentStep.step2,
            ).having(
                  (state) => state.step1Data,
              'step1Data',
              firstStepTestValues,
            ),
          ),
        );
      },
    );
    blocTest<MainFormBloc, MainFormState>(
      'receives OnStepSuccess from SecondStepBloc and updates currentStep and data',
      build: () => mainFormBloc,
      act: (mainBloc) async {
        // Trigger the OnStepSuccess event
        mainFormBloc.add(OnStepSuccess(step: secondStepBloc.state.step, values: secondStepTestValues));

        await expectLater(
          mainFormBloc.stream,
          emits(
            isA<MainFormState>().having(
                  (state) => state.currentStep,
              'currentStep',
              CurrentStep.step3,
            ).having(
                  (state) => state.step2Data,
              'step2Data',
              secondStepTestValues,
            ),
          ),
        );
      },
    );
  });
}
