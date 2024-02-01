import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hometasks/src/core/services/dependency_injection_container.dart';
import 'package:hometasks/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/addTask/stepper_container_page.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/editTask/edit_task_page.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/home_page.dart';


// GoRouter configuration
GoRouter createRouter(BuildContext context) {
  final currentUser = FirebaseAuth.instance.currentUser;

  return GoRouter(
    initialLocation: '/home',
    navigatorKey: GlobalKey<NavigatorState>(),

    routes: [
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => HomeScreen(),

      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
          name: 'addTask',
          path: '/addTask',
          builder: (context, state) =>
              BlocProvider(create: (context) =>
                  sl.get<MainFormBloc>(),
                child: const AddTaskStepper(),),
     ),
      GoRoute(
        name: 'task',
        path: '/task',
        builder: (context, state) {
          final task =state.extra as Task;
          return BlocProvider(create: (context) =>
              sl.get<TaskEditBloc>(),
            child: EditTaskScreen(task: task,),);

        }
      )

    ],
    redirect: (context, state) {
      // You can still access currentUser here if needed
      if (currentUser == null) {
        // Redirect to login if user is not signed in
        return '/login';
      }
    },

  );
}
