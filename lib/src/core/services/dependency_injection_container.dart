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
import 'package:hometasks/src/features/tasks/domain/usecases/update_task_use_case.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async{
  sl.registerLazySingleton<AuthRepository>(()=>AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceFirebase(), localDataSource: AuthLocalDataSource()));
  sl.registerLazySingleton<TaskDataSource>(() => FirebaseTaskDataSource(firestore: FirebaseFirestore.instance));
  sl.registerLazySingleton<DomainFirebaseTaskRepository>(() => DataFirebaseTaskRepositoryImpl(sl<TaskDataSource>()));
  sl.registerLazySingleton(() => GetTaskByIdUseCase( repository:sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton(() => AddTaskUseCase( repository:sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton(() => DeleteTaskUseCase( repository:sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton(() => GetTasksUseCase( repository:sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton(() => UpdateTaskUseCase( repository:sl<DomainFirebaseTaskRepository>()));
}
