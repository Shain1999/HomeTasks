

import 'package:equatable/equatable.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/stepsForms/mainForm/main_form_state.dart';

enum ChildStepFormStatus { initial, loading, success, failure,error,valid }
class ChildStepFormState extends Equatable {
  const ChildStepFormState({
    this.status = ChildStepFormStatus.initial,
    this.step,
    this.errorMessage
  });

  final ChildStepFormStatus status;
  final String? errorMessage;
  final CurrentStep? step;


  ChildStepFormState copyWith({
    ChildStepFormStatus Function()? status,
    String? errorMessage
  }) {
    return ChildStepFormState(
      status: status != null ? status() : this.status,
      errorMessage: errorMessage ?? this.errorMessage,

    );
  }

  @override
  List<Object?> get props =>
      [
        status,
        errorMessage
      ];

}