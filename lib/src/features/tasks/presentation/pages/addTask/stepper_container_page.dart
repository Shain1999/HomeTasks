import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hometasks/src/core/widgets/app_bar_widget.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/addTask/step_1_form_page.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/addTask/step_2_form_page.dart';
import 'package:hometasks/src/features/tasks/presentation/pages/addTask/steps_page_bloc_wrapper.dart';

class AddTaskStepper extends StatelessWidget  {
  const AddTaskStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBarWidget(),
      body: BlocConsumer<MainFormBloc, MainFormState>(
          builder: (context, state) {
            return Stepper(
              type: StepperType.horizontal,
              currentStep: state.currentStep!.index,
              onStepTapped: context
                  .read<MainFormBloc>()
                  .stepTapped,
              controlsBuilder: (context, controlDetails) {
                return const SizedBox.shrink();
              },
              steps: [
                Step(
                  title: const Text('General Info'),
                  content: const GeneralInfoFormBlocProvider(),
                  isActive: state.currentStep!.index >= 0,
                  state: state.currentStep!.index >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Time'),
                  content: const DateTimeFormBlocProvider(),
                  isActive: state.currentStep!.index  >= 1,
                  state: state.currentStep!.index  >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Additional Info'),
                  content: const AdditionalInfoFormBlocProvider(),
                  isActive: state.currentStep!.index>= 2,
                  state: state.currentStep!.index>= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state.status == MainFormStatus.success) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  const SnackBar(content: Text("Operation Main Bloc Success")));
              context.goNamed('home');
            }
            if (state.status == MainFormStatus.error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(
                  const SnackBar(
                      content: Text("An error accourd check your form")));
            }
          }
      ),
    );
  }
}