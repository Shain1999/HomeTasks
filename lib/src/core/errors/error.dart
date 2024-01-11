import 'package:hometasks/src/core/errors/error_type.dart';


class ServerError {
  final String message;
  final ServerErrorType type;

  ServerError(this.message, this.type);

  // Factory method for creating instances based on error type
  static ServerError create(ServerErrorType type) {
    switch (type) {
      case ServerErrorType.notFound:
        return ServerError('Not Found', ServerErrorType.notFound);
      case ServerErrorType.empty:
        return ServerError('Empty', ServerErrorType.empty);
      case ServerErrorType.emptyList:
        return ServerError('Empty Task List', ServerErrorType.emptyList);
      case ServerErrorType.invalidArguments:
        return ServerError('Invalid Arguments', ServerErrorType.invalidArguments);
      case ServerErrorType.internalServerError:
        return ServerError('internalServerError', ServerErrorType.internalServerError);

    }
  }
}
