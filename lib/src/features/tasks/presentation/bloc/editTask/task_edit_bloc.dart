import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_state.dart';

class TaskEditBloc extends Bloc<TaskEditEvent,TaskEditState> {
  TaskEditBloc({
    required UpdateTaskUseCase updateTaskUseCase,
    required AddTaskUseCase addTaskUseCase
  })
      :
        _addTaskUseCase = addTaskUseCase,
        _updateTaskUseCase=updateTaskUseCase,
        super(TaskEditState()) {
    on<OnInitAdd>(_onInitAdd);
    on<OnFormSubmitUpdate>(_onFormSubmitUpdate);
    on<OnFormSubmitAdd>(_onFormSubmitAdd);
    on<OnFieldChanged>(_onFieldChanged);

  }

  @override
  Future<void> close() {
    // Close any resources here

    // Close the stream
    return super.close();
  }
  final UpdateTaskUseCase _updateTaskUseCase;
  final AddTaskUseCase _addTaskUseCase;

  Future<void> _onInitAdd(OnInitAdd event,
      Emitter<TaskEditState> emit)async {
  emit(state.copyWith(status: ()=>TaskEditStatus.initial,task: ()=>Task.initial()));
  }

  Future<void> _onFormSubmitUpdate(OnFormSubmitUpdate event,
      Emitter<TaskEditState> emit) async{
    emit(state.copyWith(status: ()=>TaskEditStatus.loading));
    UpdateTaskParams updateTaskParams =UpdateTaskParams.createUpdateTaskParams(state.task!, state.updatedFields);
    final response = await _updateTaskUseCase.handle(updateTaskParams);
    if(!response.isSuccess)
      {
        emit(state.copyWith(status: ()=>TaskEditStatus.failure,errorMessage: response.message));
        return;
      }
    emit(state.copyWith(status: ()=>TaskEditStatus.success));
  }
  Future<void> _onFormSubmitAdd(OnFormSubmitAdd event,
      Emitter<TaskEditState> emit) async{
    emit(state.copyWith(status: ()=>TaskEditStatus.loading));
    Task taskToAdd =Task.createTaskFromMap(state.updatedFields, state.task!);
    final response = await _addTaskUseCase.handle(taskToAdd);
    if(!response.isSuccess)
    {
      emit(state.copyWith(status: ()=>TaskEditStatus.failure,errorMessage: response.message));
      return;
    }
    emit(state.copyWith(status: ()=>TaskEditStatus.success));
  }
  Future<void> _onFieldChanged(OnFieldChanged event, Emitter<TaskEditState> emit) async {
    // Copy the existing updatedFields map
    final updatedFieldsCopy = Map<String, dynamic>.from(state.updatedFields);

    // Update the specific field with the new value
    updatedFieldsCopy[event.fieldName] = event.value;

    // Emit the updated state
    emit(state.copyWith(updatedFields: () => updatedFieldsCopy));
  }
}
