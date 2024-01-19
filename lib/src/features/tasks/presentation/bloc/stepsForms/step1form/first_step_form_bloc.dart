import 'package:bloc/src/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/description/description.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart' as TitleValueObject;
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

class FirstStepBloc extends Bloc<MainFormEvent,FirstStepFormState> implements IChildStepFormFunctions{
  final MainFormBloc _mainFormBloc;

  FirstStepBloc({
    required MainFormBloc mainFormBloc,
}):_mainFormBloc=mainFormBloc, super(FirstStepFormState()){
    on<OnStepSubmit>(OnStepSubmitFunc);
    on<OnStepFailure>(OnStepFailureFunc);
    on<OnStepSuccess>(OnStepSuccessFunc);
    on<UpdateTaskCategoryEvent>(OnUpdateTaskCategoryEvent);
    on<UpdateTaskPriorityEvent>(OnUpdateTaskPriorityEvent);
  }

  @override
  Future<void> OnStepFailureFunc(OnStepFailure event, Emitter<ChildStepFormState> emit) async {
    // Handle step failure logic for step 1
    // For example, update the state to indicate failure

    emit(state.copyWith(
      status: ()=>ChildStepFormStatus.failure,
      errorMessage: 'Step 1 submission failed',
    ));
  }
  @override
  Future<void> OnUpdateTaskCategoryEvent(UpdateTaskCategoryEvent event, Emitter<ChildStepFormState> emit) async {

    emit(state.copyWith(
      categoryField: ()=>event.newCategory,
    ));
  }
  @override
  Future<void> OnUpdateTaskPriorityEvent(UpdateTaskPriorityEvent event, Emitter<ChildStepFormState> emit) async {

    emit(state.copyWith(
      priorityField: ()=>event.newPriority,
    ));
  }

  @override
  Future<void> OnStepSubmitFunc(OnStepSubmit event, Emitter<ChildStepFormState> emit) async {
    // Handle step 1 submission logic
    // For example, validate the form fields and update the state accordingly
    // You might want to dispatch events to the main form bloc or other blocs
    // to notify about the submission or handle other business logic.
    // Replace the following with your logic
    emit(state.copyWith(
      status: ()=>ChildStepFormStatus.loading,
      // Update other properties as needed
    ));

    // Dispatch an event to the main form bloc to move to the next step
    add(OnStepSuccess(step: state.step,values: state.getCurrentValuesToMap()));
  }

  @override
  Future<void> OnStepSuccessFunc(OnStepSuccess event, Emitter<ChildStepFormState> emit )async {
    // Handle step success logic for step 1
    // This might involve cleanup or additional processing after a successful submission
    // Update the state accordingly
    emit(state.copyWith(
      status: ()=>ChildStepFormStatus.success,
      // Update other properties as needed
    ));
    _mainFormBloc.add(OnStepSuccess(step: state.step,values: state.getCurrentValuesToMap()));
  }
  @visibleForTesting
  Future<void> OnStepSubmitTest() async {

    emit(state.copyWith(
      status: ()=>ChildStepFormStatus.loading,
      // Update other properties as needed
    ));
  }
  @visibleForTesting
  Future<void> OnStepSuccessTest() async{
    emit(state.copyWith(
      status: ()=>ChildStepFormStatus.success,
      // Update other properties as needed
    ));
  }



}
