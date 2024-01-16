import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task/task_global_state.dart';

class TaskAddBloc extends TaskBloc{
  TaskAddBloc({
    required AddTaskUseCase addTaskUseCase
  })
      :
        _addTaskUseCase=addTaskUseCase,
        super();


  @override
  Future<void> close() {
    // Close any resources here

    // Close the stream
    return super.close();
  }
  final AddTaskUseCase _addTaskUseCase;

  @override
  Future<void> OnInitFunc(OnInitEvent event,
      Emitter<TaskState> emit)async {
    emit(state.copyWith(status: ()=>TaskStatus.initial));
  }


  @override
  Future<void> OnFormSubmitFunc(OnFormSubmitEvent event, Emitter<TaskState> emit) async {
    emit(state.copyWith(status: ()=>TaskStatus.loading));
    final Task taskToAdd = Task.createTaskFromMap(state.updatedFields);
    final response = await _addTaskUseCase.handle(taskToAdd);
    if(!response.isSuccess)
    {
      emit(state.copyWith(status: ()=>TaskStatus.failure,errorMessage: response.message));
      return;
    }
    emit(state.copyWith(status: ()=>TaskStatus.success));
  }
  @override
  Future<void> OnFieldChangedFunc(OnFieldChangedEvent event, Emitter<TaskState> emit) async {
    // Copy the existing updatedFields map
    final updatedFieldsCopy = Map<String, dynamic>.from(state.updatedFields);

    // Update the specific field with the new value
    updatedFieldsCopy[event.fieldName] = event.value;

    // Emit the updated state
    emit(state.copyWith(updatedFields: () => updatedFieldsCopy));
  }
  // Additional method for testing purposes
  @visibleForTesting
  void setTestUpdateFields(Map<String, dynamic> testFields) {
    emit(state.copyWith(updatedFields: () => testFields));
  }

}
