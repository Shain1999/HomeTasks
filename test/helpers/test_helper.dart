
import 'package:hometasks/src/features/tasks/data/data_sources/firesbase_task_data_source.dart';
import 'package:hometasks/src/features/tasks/data/repositories/task_remote_data_source.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_task_by_id_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_tasks_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/tasks_use_cases.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository_domain.dart';
import 'package:mockito/mockito.dart';

import 'test_helper.mocks.dart';
@GenerateMocks([DomainFirebaseTaskRepository,TaskDataSource,FirebaseTaskDataSource,GetTasksUseCase,UpdateTaskUseCase,DeleteTaskUseCase,AddTaskUseCase,GetTaskByIdUseCase,TaskUseCases])

void run(){
}