import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';



class MainFormBloc extends Bloc<MainFormEvent, MainFormState> {
  final AddTaskUseCase _addTaskUseCase;
  MainFormBloc({
    required AddTaskUseCase addTaskUseCase,
  }):
  _addTaskUseCase=addTaskUseCase, super(const MainFormState()) {
    on<OnInitEvent>(OnInitFunc);
    on<OnFormSubmitEvent>(OnFormSubmitFunc);
    on<OnFormSubmitSuccess>(OnFormSubmitSuccessFunc);
    on<OnFormSubmitFailure>(OnFormSubmitFailureFunc);
    on<OnStepSuccess>(OnStepSuccessFunc);

  }

  @override
  Future<void> close() {
    // Close any resources here

    return super.close();
  }

  Future<void> OnInitFunc(OnInitEvent event,
      Emitter<MainFormState> emit) async {

  }
  void stepTapped(int tappedIndex) {
    switch (tappedIndex) {
      case 0:
      // Move to step 2
        emit(state.copyWith(currentStep: () => CurrentStep.step1));
        break;
      case 1:
      // Move to step 3
        emit(state.copyWith(currentStep: () => CurrentStep.step2));
        break;
      case 2:
      // Handle completion of the final step
      // You might want to dispatch additional events or update the state accordingly
        emit(state.copyWith(currentStep: () => CurrentStep.step3));
        break;
    }
  }



  Future<void> OnFormSubmitFunc(OnFormSubmitEvent event,
      Emitter<MainFormState> emit) async {
    emit(state.copyWith(status: () => MainFormStatus.loading));
    Map<String, dynamic> formData = collectFormData(step1Data: state.step1Data,step2Data: state.step2Data,step3Data: state.step3Data);
    final Task taskToAdd = Task.createTaskFromMap(formData);
    final response = await _addTaskUseCase.handle(taskToAdd);
    if(!response.isSuccess)
    {
      emit(state.copyWith(status: ()=>MainFormStatus.failure,errorMessage: response.message));
      return;
    }
    emit(state.copyWith(status: ()=>MainFormStatus.success));
    add(const OnFormSubmitSuccess());
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

        emit(state.copyWith(currentStep: () => CurrentStep.step2,step1Data:()=> event.values));
        break;
      case CurrentStep.step2:
      // Move to step 3
        emit(state.copyWith(currentStep: () => CurrentStep.step3,step2Data:()=> event.values));
        break;
      case CurrentStep.step3:
      // Handle completion of the final step
      // You might want to dispatch additional events or update the state accordingly
        emit(state.copyWith(step3Data:()=> event.values));
        add(const OnFormSubmitEvent());
        break;
    }
  }
  Map<String,dynamic> collectFormData ({ required Map<String,dynamic> step1Data,required  Map<String,dynamic> step2Data,required Map<String,dynamic> step3Data}){
    Map<String, dynamic> formData = {};
    formData.addAll(step1Data);
    formData.addAll(step2Data);
    formData.addAll(step3Data);
    return formData;

  }
}
