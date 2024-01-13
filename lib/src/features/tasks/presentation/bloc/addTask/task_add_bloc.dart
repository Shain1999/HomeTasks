import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/update_task_params.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/addTask/task_add_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/addTask/task_add_state.dart';

class TaskAddBloc extends Bloc<TaskAddEvent,TaskAddState> {
  TaskAddBloc({
    required AddTaskUseCase addTaskUseCase
  })
      :
        _addTaskUseCase=addTaskUseCase,
        super(TaskAddState()) {
    on<OnInit>(_onInit);
    on<OnFormSubmit>(_onFormSubmit);

  }

  @override
  Future<void> close() {
    // Close any resources here

    // Close the stream
    return super.close();
  }
  final AddTaskUseCase _addTaskUseCase;

  Future<void> _onInit(OnInit event,
      Emitter<TaskAddState> emit)async {
    emit(state.copyWith(status: ()=>TaskAddStatus.initial,task: ()=>Task.initial()));
  }

  Future<void> _onFormSubmit(OnFormSubmit event,
      Emitter<TaskAddState> emit) async{
    emit(state.copyWith(status: ()=>TaskAddStatus.loading));

    final response = await _addTaskUseCase.handle(state.task!);
    if(!response.isSuccess)
    {
      emit(state.copyWith(status: ()=>TaskAddStatus.failure,errorMessage: response.message));
      return;
    }
    emit(state.copyWith(status: ()=>TaskAddStatus.success));
  }

}
