import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:hometasks/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:hometasks/src/features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'package:hometasks/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hometasks/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:hometasks/src/features/tasks/data/data_sources/firesbase_task_data_source.dart';
import 'package:hometasks/src/features/tasks/data/repositories/task_remote_data_source.dart';
import 'package:hometasks/src/features/tasks/data/repositories/firebase_task_repository_data_impl.dart';
import 'package:hometasks/src/features/tasks/domain/repositories/firebase_task_repository_domain.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/delete_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_task_by_id_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/get_tasks_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/tasks_use_cases.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/addTask/task_add_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_list_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async{
  sl.registerLazySingleton<AuthRepository>(()=>AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceFirebase(), localDataSource: AuthLocalDataSource()));
  sl.registerLazySingleton<TaskDataSource>(() => FirebaseTaskDataSource(firestore: FirebaseFirestore.instance));
  sl.registerLazySingleton<DomainFirebaseTaskRepository>(() => DataFirebaseTaskRepositoryImpl(sl<TaskDataSource>()));
  sl.registerLazySingleton<GetTaskByIdUseCase>(() => GetTaskByIdUseCase( repository:sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton<AddTaskUseCase>(() => AddTaskUseCase( repository:sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton<DeleteTaskUseCase>(() => DeleteTaskUseCase( repository:sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton<GetTasksUseCase>(() => GetTasksUseCase( repository:sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton<UpdateTaskUseCase>(() => UpdateTaskUseCase( repository:sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton<TaskUseCases>(() => TaskUseCases( updateTask: sl<UpdateTaskUseCase>(),getTaskById: sl<GetTaskByIdUseCase>(),
      deleteTask: sl<DeleteTaskUseCase>(),getTasks: sl<GetTasksUseCase>(),addTask: sl<AddTaskUseCase>()));
  sl.registerFactory<TaskListBloc>(() => TaskListBloc(
    taskUseCases: sl<TaskUseCases>(),
  ));

  sl.registerFactory(() => TaskEditBloc(
    updateTaskUseCase: sl<UpdateTaskUseCase>(),
  ));
  sl.registerFactory(() => TaskAddBloc(
    addTaskUseCase: sl<AddTaskUseCase>(),
  ));
}
