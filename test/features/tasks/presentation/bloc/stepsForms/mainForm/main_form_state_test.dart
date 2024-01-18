import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hometasks/src/core/response/response.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';
import 'package:mockito/mockito.dart';

import '../../../../../../helpers/test_helper.mocks.dart';

void main() {

  late MockAddTaskUseCase mockAddTaskUseCase;

  group('FirstStepFormBloc and MainFormBloc interaction', () {
    // Stub the handle method to return a successful Result
    when(mockAddTaskUseCase.handle(any)).thenAnswer(
            (_) async => Response<Task>.ok());
    blocTest<MainFormBloc, MainFormState>(
      'receives OnStepSuccess from FirstStepBloc and updates currentStep',
      build: () {

        mockAddTaskUseCase = MockAddTaskUseCase();

        return MainFormBloc(

          addTaskUseCase: mockAddTaskUseCase
        );
      },
      act: (mainBloc) {


        // Create FirstStepFormBloc
        final firstStepBloc = mainBloc.firstStepBloc;

        // Trigger the OnStepSubmit event
        firstStepBloc.add(OnStepSubmit(step: firstStepBloc.state.step));
      },
      expect: () => [

        // Expect the OnStepSuccess event from FirstStepFormBloc
        // Adjust the expected state based on your application logic
        isA<MainFormState>().having(
              (state) => state.currentStep,
          'currentStep',
          CurrentStep.step2,
        ),
      ], // No expectations for the MainFormBloc
    );
  });
  group('SecondStepFormBloc and MainFormBloc interaction', () {
    blocTest<MainFormBloc, MainFormState>(
      'receives OnStepSuccess from FirstStepBloc and updates currentStep',
      build: () {
        final firstStepBloc = FirstStepBloc();
        final secondStepBloc = SecondStepBloc();
        final thirdStepBloc = ThirdStepBloc();

        return MainFormBloc(
            firstStepBloc: firstStepBloc,
            secondStepBloc: secondStepBloc,
            thirdStepBloc: thirdStepBloc,
            addTaskUseCase: mockAddTaskUseCase
        );
      },
      act: (mainBloc) {
        // Create FirstStepFormBloc
        final secondStepBloc = mainBloc.secondStepBloc;

        // Trigger the OnStepSubmit event
        secondStepBloc.add(OnStepSubmit(step: secondStepBloc.state.step));
      },
      expect: () => [

        // Expect the OnStepSuccess event from FirstStepFormBloc
        // Adjust the expected state based on your application logic
        isA<MainFormState>().having(
              (state) => state.currentStep,
          'currentStep',
          CurrentStep.step3,
        ),
      ], // No expectations for the MainFormBloc
    );
  });
  group('ThirdStepFormBloc and MainFormBloc interaction', () {
    blocTest<MainFormBloc, MainFormState>(
      'receives OnStepSuccess from FirstStepBloc and updates currentStep',
      build: () {
        final firstStepBloc = FirstStepBloc();
        final secondStepBloc = SecondStepBloc();
        final thirdStepBloc = ThirdStepBloc();

        return MainFormBloc(
            firstStepBloc: firstStepBloc,
            secondStepBloc: secondStepBloc,
            thirdStepBloc: thirdStepBloc,
            addTaskUseCase: mockAddTaskUseCase
        );
      },
      act: (mainBloc) {
        // Create FirstStepFormBloc
        final thirdStepBloc = mainBloc.thirdStepBloc;

        // Trigger the OnStepSubmit event
        thirdStepBloc.add(OnStepSubmit(step: thirdStepBloc.state.step));
      },
      expect: () => [

        // Expect the OnStepSuccess event from FirstStepFormBloc
        // Adjust the expected state based on your application logic
        isA<MainFormState>().having(
              (state) => state.status,
          'status',
          MainFormStatus.loading,
        ),
        isA<MainFormState>().having(
              (state) => state.status,
          'status',
          MainFormStatus.success,
        )
      ], // No expectations for the MainFormBloc
    );
  });
}
