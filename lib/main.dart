import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/core/routes/router.dart';
import 'firebase_options.dart';
import 'src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'src/features/auth/data/data_sources/auth_remote_data_source_firebase.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/entities/auth_user.dart';
import 'src/features/auth/domain/repositories/auth_repository.dart';
import 'src/core/services/dependency_injection_container.dart' as di;

typedef AppBuilder = Future<Widget> Function();

Future<void> bootstrap(AppBuilder builder) async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp.router(
      title: 'Home Tasks',
      theme: ThemeData.light(useMaterial3: true),
      routerConfig: createRouter(context),
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
