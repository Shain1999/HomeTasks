import 'package:equatable/equatable.dart';

enum MainFormStatus { initial, loading, success, failure, error }
enum CurrentStep{step1,step2,step3}
class MainFormState extends Equatable {
  const MainFormState({
    this.status = MainFormStatus.initial,
    this.currentStep=CurrentStep.step1,
    this.step1Data=const {},
    this.step2Data=const {},
    this.step3Data=const {},
    this.errorMessage,
  });

  final MainFormStatus status;
  final Map<String,dynamic> step1Data;
  final Map<String,dynamic> step2Data;
  final Map<String,dynamic> step3Data;
  final CurrentStep? currentStep;
  final String? errorMessage;


  MainFormState copyWith({
    CurrentStep Function()? currentStep,
    MainFormStatus Function()? status,
    Map<String,dynamic> Function()? step1Data,
    Map<String,dynamic> Function()? step2Data,
    Map<String,dynamic> Function()? step3Data,
    String? errorMessage,
  }) {
    return MainFormState(
      status: status !=null ? status(): this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentStep: currentStep != null ? currentStep():this.currentStep,
        step1Data: step1Data !=null ?step1Data() : this.step1Data,
        step2Data: step2Data !=null ?step2Data() : this.step2Data,
        step3Data: step3Data !=null ?step3Data() : this.step3Data
    );
  }

  List<Object?> get props => [status,  errorMessage,currentStep,step1Data,step3Data,step2Data];
}
