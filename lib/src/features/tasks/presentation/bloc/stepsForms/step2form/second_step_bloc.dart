import 'package:bloc/src/bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

class SecondStepBloc extends Bloc<MainFormEvent,SecondStepFormState> implements IChildStepFormFunctions{
  final MainFormBloc _mainFormBloc;

  SecondStepBloc({required MainFormBloc mainFormBloc}):_mainFormBloc=mainFormBloc, super(SecondStepFormState()){
    on<OnStepSubmit>(OnStepSubmitFunc);
    on<OnStepFailure>(OnStepFailureFunc);
    on<OnStepSuccess>(OnStepSuccessFunc);
    on<UpdateDueDateEvent>(_updateDueDate);
    on<UpdateEstimatedTimeEvent>(_updateEstimatedTime);
    on<UpdateTaskReminderEvent>(_updateTaskReminder);
    on<UpdateTaskReccuringEvent>(_updateTaskRecurring);
  }
  @override
  Future<void> close() {
    // Close any resources here

    // Close the stream
    return super.close();
  }

  Future<void> _updateDueDate(
      UpdateDueDateEvent event, Emitter<SecondStepFormState> emit) async {
    // Handle updating due date logic
    emit(state.copyWith(
      dueDateField: () => event.newDate,
    ));
  }

  Future<void> _updateEstimatedTime(
      UpdateEstimatedTimeEvent event, Emitter<SecondStepFormState> emit) async {
    // Handle updating estimated time logic
    emit(state.copyWith(
      estimatedTimeField: () => event.newTimeRange,
    ));
  }

  Future<void> _updateTaskReminder(
      UpdateTaskReminderEvent event, Emitter<SecondStepFormState> emit) async {
    // Handle updating task reminder logic
    emit(state.copyWith(
      reminderField: () => event.newReminder,
    ));
  }

  Future<void> _updateTaskRecurring(
      UpdateTaskReccuringEvent event, Emitter<SecondStepFormState> emit) async {
    // Handle updating task recurring logic
    emit(state.copyWith(
      reccuringField: () => event.newReccuring,
    ));
  }

  @override
  Future<void> OnStepFailureFunc(OnStepFailure event, Emitter<ChildStepFormState> emit) async{
    // Handle step failure logic for step 2
    // For example, update the state to indicate failure
    emit(state.copyWith(
      status: ()=>ChildStepFormStatus.failure,
      errorMessage: 'Step 2 submission failed',
    ));
  }

  @override
  Future<void> OnStepSubmitFunc(OnStepSubmit event, Emitter<ChildStepFormState> emit) async {
    // Handle step 2 submission logic
    // For example, validate the form fields and update the state accordingly
    // You might want to dispatch events to the main form bloc or other blocs
    // to notify about the submission or handle other business logic.
    // Replace the following with your logic
    emit(state.copyWith(
      status: ()=>ChildStepFormStatus.loading,
      // Update other properties as needed
    ));
    add(OnStepSuccess(step: state.step, values: state.getCurrentValuesToMap()));


  }

  @override
  Future<void> OnStepSuccessFunc(OnStepSuccess event, Emitter<ChildStepFormState> emit) async {
    // Handle step success logic for step 3
    // This might involve cleanup or additional processing after a successful submission
    // Update the state accordingly
    emit(state.copyWith(
      status: ()=>ChildStepFormStatus.success,
      // Update other properties as needed
    ));
    _mainFormBloc.add(OnStepSuccess(step: state.step,values: state.getCurrentValuesToMap()));
  }

}
