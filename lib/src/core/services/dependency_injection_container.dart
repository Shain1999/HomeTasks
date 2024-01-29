import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:hometasks/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:hometasks/src/features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'package:hometasks/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hometasks/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:hometasks/src/features/auth/domain/use_cases/sream_get_users_use_case.dart';
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
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_bloc.dart';
import 'package:hometasks/src/features/users/data/local/data_sources/user_local_data_source.dart';
import 'package:hometasks/src/features/users/data/remote/data_sources/firebase_users_data_source.dart';
import 'package:hometasks/src/features/users/data/remote/data_sources/firebase_users_data_source_impl.dart';
import 'package:hometasks/src/features/users/data/repositories/user_repository_impl.dart';
import 'package:hometasks/src/features/users/domain/repositories/user_repository.dart';
import 'package:hometasks/src/features/users/domain/use_cases/get_users_use_case.dart';
import 'package:hometasks/src/features/users/presentation/bloc/getUsers/get_users_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(remoteDataSource: AuthRemoteDataSourceFirebase(),
          localDataSource: AuthLocalDataSource()));
  sl.registerLazySingleton<UserRepository>(() =>
      UserRepositoryImpl(remoteDataSource: FirebaseUserDataSourceImpl(firestore: FirebaseFirestore.instance),
          localDataSource: UserLocalDataSource()));

  sl.registerLazySingleton<StreamUsersUseCase>(() =>
      StreamUsersUseCase(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<TaskDataSource>(() =>
      FirebaseTaskDataSource(firestore: FirebaseFirestore.instance));
  sl.registerLazySingleton<DomainFirebaseTaskRepository>(() =>
      DataFirebaseTaskRepositoryImpl(sl<TaskDataSource>()));
  sl.registerLazySingleton<GetTaskByIdUseCase>(() =>
      GetTaskByIdUseCase(repository: sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton<AddTaskUseCase>(() =>
      AddTaskUseCase(repository: sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton<DeleteTaskUseCase>(() =>
      DeleteTaskUseCase(repository: sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton<GetTasksUseCase>(() =>
      GetTasksUseCase(repository: sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton<UpdateTaskUseCase>(() =>
      UpdateTaskUseCase(repository: sl<DomainFirebaseTaskRepository>()));
  sl.registerLazySingleton<GetUsersUseCase>(() =>
      GetUsersUseCase(userRepository: sl<UserRepository>()));
  sl.registerLazySingleton<TaskUseCases>(() =>
      TaskUseCases(updateTask: sl<UpdateTaskUseCase>(),
          getTaskById: sl<GetTaskByIdUseCase>(),
          deleteTask: sl<DeleteTaskUseCase>(),
          getTasks: sl<GetTasksUseCase>(),
          addTask: sl<AddTaskUseCase>()));
  sl.registerFactory<TaskListBloc>(() =>
      TaskListBloc(
        taskUseCases: sl<TaskUseCases>(),
      ));
  sl.registerLazySingleton<MainFormBloc>(() =>
      MainFormBloc(addTaskUseCase: sl<AddTaskUseCase>()));
  sl.registerFactory<GetUsersBloc>(() =>
      GetUsersBloc(getUsersUseCase: sl<GetUsersUseCase>()));
  sl.registerFactory<FirstStepBloc>(() =>
      FirstStepBloc(mainFormBloc: sl<MainFormBloc>()));
  sl.registerFactory<SecondStepBloc>(() =>
      SecondStepBloc(mainFormBloc: sl<MainFormBloc>()));
  sl.registerFactory<ThirdStepBloc>(() =>
      ThirdStepBloc(mainFormBloc: sl<MainFormBloc>()));

  sl.registerFactory<TaskEditBloc>(() =>
      TaskEditBloc(
        updateTaskUseCase: sl<UpdateTaskUseCase>(),
      ));
  sl.registerFactory<TaskAddBloc>(() =>
      TaskAddBloc(
        addTaskUseCase: sl<AddTaskUseCase>(),
      ));
}
