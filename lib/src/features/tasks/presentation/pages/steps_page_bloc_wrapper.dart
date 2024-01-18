import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/core/services/dependency_injection_container.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step1form/first_step_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step2form/second_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/step3form/third_step_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/step_1_form_page.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/step_2_form_page.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/step_3_from_page.dart';

class GeneralInfoFormBlocProvider extends StatelessWidget {
  const GeneralInfoFormBlocProvider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => FirstStepBloc(
          mainFormBloc: sl.get<MainFormBloc>(),
        ),
        child: const GeneralInfoForm(),
      ),
    );
  }
}

class DateTimeFormBlocProvider extends StatelessWidget {
  const DateTimeFormBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SecondStepBloc(
          mainFormBloc:sl.get<MainFormBloc>(),
        ),
        child: const DateTimeForm(),
      ),
    );
  }
}

class AdditionalInfoFormBlocProvider extends StatelessWidget {
  const AdditionalInfoFormBlocProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => ThirdStepBloc(
          mainFormBloc: sl.get<MainFormBloc>() ,
        ),
        child: const AdditionalInfoForm(),
      ),
    );
  }
}