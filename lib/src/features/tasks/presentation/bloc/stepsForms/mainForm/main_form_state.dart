import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';
import 'package:hometasks/src/features/tasks/domain/validators/title_validator.dart';
import 'package:hometasks/src/features/tasks/domain/valueObjects/title/title.dart';

enum MainFormStatus { initial, loading, success, failure, error }
enum CurrentStep{step1,step2,step3}
class MainFormState extends Equatable {
  const MainFormState({
    this.status = MainFormStatus.initial,
    this.currentStep=CurrentStep.step1,
    this.errorMessage,
  });

  final MainFormStatus status;
  final CurrentStep? currentStep;
  final String? errorMessage;


  MainFormState copyWith({
    CurrentStep Function()? currentStep,
    MainFormStatus Function()? status,
    String? errorMessage,
  }) {
    return MainFormState(
      status: status !=null ? status(): this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentStep: currentStep != null ? currentStep():this.currentStep
    );
  }

  List<Object?> get props => [status,  errorMessage,currentStep];
}
