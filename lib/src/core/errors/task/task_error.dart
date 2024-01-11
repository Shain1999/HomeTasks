import 'package:hometasks/src/core/errors/error.dart';
import 'package:hometasks/src/core/errors/error_type.dart';

// TaskError class extending ServerError
class TaskError extends ServerError {
  TaskError(String message, ServerErrorType type) : super(message, type);

  // Factory method for creating task errors based on task error type
  static TaskError createTaskError(ServerErrorType type) {
    switch (type) {
      case ServerErrorType.notFound:
        return TaskError('Task Not Found', ServerErrorType.notFound);
      case ServerErrorType.empty:
        return TaskError('Empty Task', ServerErrorType.empty);
      case ServerErrorType.emptyList:
        return TaskError('Empty Task List', ServerErrorType.emptyList);
      case ServerErrorType.invalidArguments:
        return TaskError('Invalid Task Arguments', ServerErrorType.invalidArguments);
      case ServerErrorType.internalServerError:
        return TaskError('internalServerError', ServerErrorType.internalServerError);
    //
    // Add more task-specific error cases as needed
    }
  }

  // Generic factory method to create task errors based on a generic error type
  static TaskError create(ServerErrorType type,Exception error) {
    return TaskError('Generic Task Error', type);
  }
}