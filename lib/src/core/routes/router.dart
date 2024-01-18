import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hometasks/src/core/services/dependency_injection_container.dart';
import 'package:hometasks/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/add_task_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/usecases/update_task_use_case.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/editTask/task_edit_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_list_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/add_task_page.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/home_page.dart';
import 'package:hometasks/src/core/services/dependency_injection_container.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/step_1_form_page.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/stepper_container_widget.dart';


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
