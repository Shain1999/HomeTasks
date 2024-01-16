import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';


class MainFormBloc extends Bloc<MainFormEvent, MainFormState> {
  final FirstStepBloc firstStepBloc;
  final SecondStepBloc secondStepBloc;
  final ThirdStepBloc thirdStepBloc;

  StreamSubscription? firstStepSubscription;
  StreamSubscription? secondStepSubscription;
  StreamSubscription? thirdStepSubscription;

  MainFormBloc({
    required this.firstStepBloc,
    required this.secondStepBloc,
    required this.thirdStepBloc,
  }) :super(const MainFormState()) {
    on<OnInitEvent>(OnInitFunc);
    on<OnFormSubmitEvent>(OnFormSubmitFunc);
    on<OnFormSubmitSuccess>(OnFormSubmitSuccessFunc);
    on<OnFormSubmitFailure>(OnFormSubmitFailureFunc);
    on<OnStepSuccess>(OnStepSuccessFunc);
    // Subscribe to events from step blocs
    firstStepSubscription=firstStepBloc.stream.listen((state) {
      if (state.status == ChildStepFormStatus.success) {
        add(OnStepSuccess(step: state.step));
      }
    });

    secondStepSubscription=secondStepBloc.stream.listen((state) {
      if (state.status == ChildStepFormStatus.success) {
        add(OnStepSuccess(step: state.step));
      }
    });

    thirdStepSubscription=thirdStepBloc.stream.listen((state) {
      if (state.status == ChildStepFormStatus.success) {
        add(OnStepSuccess(step: state.step));
      }
    });
  }

  @override
  Future<void> close() {
    // Close any resources here
    // Close the stream
    firstStepSubscription?.cancel();
    secondStepSubscription?.cancel();
    thirdStepSubscription?.cancel();
    return super.close();
  }

  Future<void> OnInitFunc(OnInitEvent event,
      Emitter<MainFormState> emit) async {

  }

  Future<void> OnFormSubmitFunc(OnFormSubmitEvent event,
      Emitter<MainFormState> emit) async {
    emit(state.copyWith(status: () => MainFormStatus.loading));
    add(OnFormSubmitSuccess());
  }
  Future<void> OnFormSubmitSuccessFunc(OnFormSubmitSuccess event,
      Emitter<MainFormState> emit) async {
    emit(state.copyWith(status: () => MainFormStatus.success));
  }
  Future<void> OnFormSubmitFailureFunc(OnFormSubmitFailure event,
      Emitter<MainFormState> emit) async {
    emit(state.copyWith(status: () => MainFormStatus.success));
  }
  Future<void> OnStepSuccessFunc(OnStepSuccess event,
      Emitter<MainFormState> emit) async {
    switch (event.step) {
      case CurrentStep.step1:
      // Move to step 2
        emit(state.copyWith(currentStep: () => CurrentStep.step2));
        break;
      case CurrentStep.step2:
      // Move to step 3
        emit(state.copyWith(currentStep: () => CurrentStep.step3));
        break;
      case CurrentStep.step3:
      // Handle completion of the final step
      // You might want to dispatch additional events or update the state accordingly
        add(OnFormSubmitEvent());
        break;
    }
  }
}
