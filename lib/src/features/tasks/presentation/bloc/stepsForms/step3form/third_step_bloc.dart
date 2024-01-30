import 'package:bloc/src/bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_state.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/stepFormInterface/step_form_interface_state.dart';

class ThirdStepBloc extends Bloc<MainFormEvent,ThirdStepFormState> implements IChildStepFormFunctions{
  final MainFormBloc _mainFormBloc;
  ThirdStepBloc({required MainFormBloc mainFormBloc}):_mainFormBloc=mainFormBloc ,super(ThirdStepFormState()){
    on<OnStepSubmit>(OnStepSubmitFunc);
    on<OnStepFailure>(OnStepFailureFunc);
    on<OnStepSuccess>(OnStepSuccessFunc);
    on<UpdateAssignedUserUidList>(_updateAssignedUserUidList);
    on<UpdateNotesList>(_updateNotesList);
    on<UpdateCommentsList>(_updateCommentsList);
  }
  @override
  Future<void> close() {
    // Close any resources here

    // Close the stream
    return super.close();
  }
  Future<void> _updateAssignedUserUidList(
      UpdateAssignedUserUidList event, Emitter<ThirdStepFormState> emit) async {
    // Handle updating due date logic
    emit(state.copyWith(
      assignedUserUidsField: () => event.newList,
    ));
  }
  Future<void> _updateNotesList(
      UpdateNotesList event, Emitter<ThirdStepFormState> emit) async {
    // Handle updating due date logic
    emit(state.copyWith(
      notesField: () => event.newList,
    ));
  }
  Future<void> _updateCommentsList(
      UpdateCommentsList event, Emitter<ThirdStepFormState> emit) async {
    // Handle updating due date logic
    emit(state.copyWith(
      commentsField: () => event.newList,
    ));
  }
  @override
  Future<void> OnStepFailureFunc(OnStepFailure event, Emitter<ChildStepFormState> emit) async {
    // Handle step failure logic for step 3
    // For example, update the state to indicate failure
    emit(state.copyWith(
      status: ()=>ChildStepFormStatus.failure,
      errorMessage: 'Step 3 submission failed',
    ));
  }

  @override
  Future<void> OnStepSubmitFunc(OnStepSubmit event, Emitter<ChildStepFormState> emit) async {
    // Handle step 3 submission logic
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
  Future<void> OnStepSuccessFunc(OnStepSuccess event, Emitter<ChildStepFormState> emit)  async{
    // Handle step success logic for step 3
    // This might involve cleanup or additional processing after a successful submission
    // Update the state accordingly
    emit(state.copyWith(
      status: ()=>ChildStepFormStatus.success,
      // Update other properties as needed
    ));
    _mainFormBloc.add(OnStepSuccess(step: state.step,values:event.values ));
  }

}
