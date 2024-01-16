import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hometasks/src/core/routes/router.dart';
import 'package:hometasks/src/core/services/bloc_observer.dart';
import 'package:hometasks/src/core/services/dependency_injection_container.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/listTasks/task_list_bloc.dart';
import 'firebase_options.dart';

import 'src/core/services/dependency_injection_container.dart' as di;

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=BlocObserverWrapper();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.initDependencies();
  runApp(await builder());
}

void main() {
  bootstrap(
    () async {
      return const App();
    },
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl.get<TaskListBloc>(),)],
      child: MaterialApp.router(
        title: 'Home Tasks',
        theme: ThemeData.light(useMaterial3: true),
        routerConfig: createRouter(context),
      ),
    );
  }
}
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Clean Architecture')),
//       body: const Column(children: []),
//     );
//   }
// }
