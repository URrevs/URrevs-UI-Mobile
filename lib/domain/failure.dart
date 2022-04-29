import 'package:dio/dio.dart';

class ServerErrorMessages {
  static const String tooManyRequests = 'too many requests';
  static const String youDoNotExistInTheSystem =
      'you do not exist in the system';
  static const String tokenExpired = 'token expired';
  static const String tokenRevoked = 'token revoked';
  static const String invalidToken = 'invalid token';
  static const String processFailed = 'process failed';

  static const Map<String, String> _errorMessagesMap = {
    ServerErrorMessages.tooManyRequests: 'You have sent too many requests',
    ServerErrorMessages.youDoNotExistInTheSystem:
        'You do not exist in the system',
    ServerErrorMessages.tokenExpired: 'Your token has expired',
    ServerErrorMessages.tokenRevoked: 'Your token has been revoked',
    ServerErrorMessages.invalidToken: 'Your token is invalid',
    ServerErrorMessages.processFailed: 'Server process failed',
  };

  static List<String> get _serverErrorMessages =>
      _errorMessagesMap.keys.toList();

  /// Check whether a message has a corresponding friendly error message or not.
  static bool isAServerErrorMessage(String message) =>
      ServerErrorMessages._serverErrorMessages.contains(message);

  /// A method that receives a string representing an error message received
  /// from the server and returns a user friendly error message.
  ///
  /// the received [serverErrorMessage] must be from the static error message
  /// strings in [ServerErrorMessages] class.
  static String getAppErrorMessage(String serverErrorMessage) =>
      ServerErrorMessages._errorMessagesMap[serverErrorMessage] as String;
}

class Failure {
  String message;

  Failure(this.message);
}

extension GetFailure on DioError {
  Failure get failure {
    switch (type) {
      case DioErrorType.connectTimeout:
        return Failure('connection timed out');
      case DioErrorType.sendTimeout:
        return Failure('sending data timed out');
      case DioErrorType.receiveTimeout:
        return Failure('receiving data timed out');
      case DioErrorType.cancel:
        return Failure('request was cancelled');
      case DioErrorType.other:
        return Failure('unknown error');
      case DioErrorType.response:
        String? errorMessage = response?.data['status'];
        if (errorMessage != null &&
            ServerErrorMessages.isAServerErrorMessage(errorMessage)) {
          return Failure(ServerErrorMessages.getAppErrorMessage(errorMessage));
        }
        switch (response?.statusCode) {
          case 400:
            return Failure('unknown error');
          case 401:
            return Failure('unauthenticated');
          case 403:
            return Failure('unauthorized');
          case 404:
            return Failure('not found');
          default:
            return Failure('unknown error');
        }
    }
  }
}
