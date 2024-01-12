import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hometasks/src/core/services/dependency_injection_container.dart';
import 'package:hometasks/src/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/home_page.dart';


// GoRouter configuration
GoRouter createRouter(BuildContext context) {
  final currentUser = FirebaseAuth.instance.currentUser;

  return GoRouter(
    initialLocation: '/',
    navigatorKey: GlobalKey<NavigatorState>(),
    routes: [
      GoRoute(
        name: 'home',
        path: '/home',
        builder: (context, state) => BlocProvider(create: (context) => sl.get<TaskViewBloc>(),child: HomeScreen(),) ,
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const SignInScreen(),
      ),
    ],
    redirect: (context, state) {
      // You can still access currentUser here if needed
      if (currentUser == null) {
        // Redirect to login if user is not signed in
        return '/login';
      } else {
        // Redirect to home if user is signed in
        return '/home';
      }
    },
  );
}
