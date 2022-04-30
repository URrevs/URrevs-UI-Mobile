import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urrevs_ui_mobile/app/exceptions.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

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

enum FailureMode {
  /// The normal failure mode. This modes indicates that an error has occurred
  /// and an error message should be shown to the user.
  error,

  /// Indicates that a process has been cancelled by the user. Used in the
  /// authentication process, when user cancels the sign in flow.
  cancel,
}

class Failure {
  String message;
  FailureMode mode;

  Failure(this.message, {this.mode = FailureMode.error});

  @override
  String toString() {
    return 'Failure: $message\nFailure mode: ${mode.name}';
  }
}

extension DioErrorFailure on DioError {
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

extension NoInternetConnectionExceptionFailure on NoInternetConnection {
  Failure get failure => Failure(LocaleKeys.thereIsNoInternetConnection.tr());
}

extension FirebaseAuthExceptionFailure on FirebaseAuthException {
  String get friendlyErrorMessage {
    switch (code) {
      case 'account-exists-with-different-credential':
        return LocaleKeys.accountExistsWithDifferentCredential.tr();
      case 'invalid-credential':
        return LocaleKeys.invalidCredential.tr();
      case 'operation-not-allowed':
        return LocaleKeys.operationNotAllowed.tr();
      case 'user-disabled':
        return LocaleKeys.userDisabled.tr();
      case 'user-not-found':
        return LocaleKeys.userNotFound.tr();
      case 'wrong-password':
        return LocaleKeys.wrongPassword.tr();
      case 'invalid-verification-code':
        return LocaleKeys.invalidVerificationCode.tr();
      case 'invalid-verification-id':
        return LocaleKeys.invalidVerificationId.tr();
      default:
        return LocaleKeys.unknownFirebaseError.tr();
    }
  }

  Failure get failure => Failure(friendlyErrorMessage);
}

extension AuthenticationCancelledFailure on AuthenticationCancelled {
  Failure get failure => Failure('', mode: FailureMode.cancel);
}
