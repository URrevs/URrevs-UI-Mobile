import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:urrevs_ui_mobile/app/exceptions.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Error messages handled in repository:
/// * add answer to phone question: not owned
/// * add answer to company question: not owned
class ManuallyHandlledErrorMessages {
  static const String notOwned = "not owned";
}

class ServerErrorMessages {
  static const String tooManyRequests = 'too many requests';
  static const String youDoNotExistInTheSystem =
      'you do not exist in the system';
  static const String tokenExpired = 'token expired';
  static const String tokenRevoked = 'token revoked';
  static const String invalidToken = 'invalid token';
  static const String processFailed = 'process failed';
  static const String noUpdateOperationsYet = 'no update operations yet';
  static const String youAreNotAnAdmin = 'you are not admin';
  static const String thereIsARunningUpdateOperationRightNow =
      'there is a running update operation right now';
  static const String badRequest = 'bad request';
  static const String internalServerError = 'internal server error';
  static const String trackInternalServerError = 'track internal server error';
  static const String alreadyLiked = 'already liked';
  static const String alreadyUnliked = 'already unliked';
  static const String noLikes = 'no likes';
  static const String notFound = 'not found';
  static const String notOwned = 'not owned';
  static const String notYet = 'not yet';
  static const String notAccepted = 'not accepted';
  static const String alreadyReviewed = 'already reviewed';
  static const String invalidReferralCode = 'invalid referral code';
  static const String alreadyReported = 'already reported';
  static const String blocked = 'blocked';
  static const String alreadyAccepted = 'already accepted';
  // static const String trackAlreadyHated = 'track already hated';
  // static const String trackAlreadySeemored = 'track already seemored';
  // static const String trackAlreadyFullscreened = 'track already fullscreened';
  // static const String trackQuestionAlreadyHated =
  //     'track question already hated';
  // static const String trackQuestionAlreadyFullscreened =
  //     'track question already fullscreened';

  static Map<String, String> get errorMessagesMap => {
        ServerErrorMessages.tooManyRequests: LocaleKeys.tooManyRequests.tr(),
        ServerErrorMessages.youDoNotExistInTheSystem:
            LocaleKeys.youDoNotExistInTheSystem.tr(),
        ServerErrorMessages.tokenExpired: LocaleKeys.tokenExpired.tr(),
        ServerErrorMessages.tokenRevoked: LocaleKeys.tokenRevoked.tr(),
        ServerErrorMessages.invalidToken: LocaleKeys.invalidToken.tr(),
        ServerErrorMessages.processFailed: LocaleKeys.processFailed.tr(),
        ServerErrorMessages.noUpdateOperationsYet:
            LocaleKeys.noUpdateOperationsYet.tr(),
        ServerErrorMessages.youAreNotAnAdmin: LocaleKeys.youAreNotAdmin.tr(),
        ServerErrorMessages.thereIsARunningUpdateOperationRightNow:
            LocaleKeys.thereIsARunningUpdateOperationRightNow.tr(),
        ServerErrorMessages.badRequest: LocaleKeys.badRequest.tr(),
        ServerErrorMessages.internalServerError:
            LocaleKeys.internalServerError.tr(),
        ServerErrorMessages.trackInternalServerError:
            LocaleKeys.internalServerError.tr(),
        ServerErrorMessages.alreadyLiked: alreadyLiked,
        ServerErrorMessages.alreadyUnliked: alreadyUnliked,
        ServerErrorMessages.noLikes: noLikes,
        ServerErrorMessages.alreadyAccepted: alreadyAccepted,
        ServerErrorMessages.notFound: notFound,
        ServerErrorMessages.notOwned:
            LocaleKeys.youCantAnswerAQuestionMessage.tr(),
        ServerErrorMessages.notYet: notYet,
        ServerErrorMessages.notAccepted: notAccepted,
        ServerErrorMessages.alreadyReviewed:
            LocaleKeys.youHaveAlreadyReviewedThisPhoneBefore.tr(),
        ServerErrorMessages.invalidReferralCode:
            LocaleKeys.theEnteredReferralCodeIsInvalid.tr(),
        ServerErrorMessages.alreadyReported:
            LocaleKeys.youHaveAlreadyReportedThisElement.tr(),
        ServerErrorMessages.blocked:
            LocaleKeys.youAreBlockedCannotTakeThatAction.tr(),
      };

  static List<String> get _noResultFailures => [
        noUpdateOperationsYet,
        // notYet,
      ];

  static List<String> get _retryActionFailures => [
        tooManyRequests,
        processFailed,
        internalServerError,
        badRequest,
      ];

  static List<String> get _authenticateFailures => [
        youDoNotExistInTheSystem,
        tokenExpired,
        invalidToken,
        tokenRevoked,
      ];

  static List<String> get _ignoredFailures => [
        alreadyLiked,
        alreadyUnliked,
        noLikes,
        notFound,
        alreadyAccepted,
        // notYet,
        notAccepted,
        // trackAlreadyHated,
        // trackAlreadySeemored,
        // trackAlreadyFullscreened,
        // trackQuestionAlreadyHated,
        // trackQuestionAlreadyFullscreened,
      ];

  static List<String> get _serverErrorMessages =>
      errorMessagesMap.keys.toList();

  /// Check whether a message has a corresponding friendly error message or not.
  static bool isAServerErrorMessage(String message) =>
      ServerErrorMessages._serverErrorMessages.contains(message);

  /// A method that receives a string representing an error message received
  /// from the server and returns a user friendly error message.
  ///
  /// the received [serverErrorMessage] must be from the static error message
  /// strings in [ServerErrorMessages] class.
  static String getAppErrorMessage(String serverErrorMessage) =>
      ServerErrorMessages.errorMessagesMap[serverErrorMessage] as String;

  static Failure getFailure(String errorMessage) {
    String friendlyErrorMessage = errorMessagesMap[errorMessage] as String;
    if (errorMessage == noUpdateOperationsYet) {
      return NoResultFailure();
    }
    if (_retryActionFailures.contains(errorMessage)) {
      return RetryFailure(friendlyErrorMessage);
    }
    if (_authenticateFailures.contains(errorMessage)) {
      return AuthenticateFailure(friendlyErrorMessage);
    }
    if (_ignoredFailures.contains(errorMessage)) {
      return IgnoredFailure();
    }
    return Failure(friendlyErrorMessage);
  }
}

class Failure {
  String message;

  Failure(this.message);

  @override
  String toString() {
    return 'Failure: $message';
  }
}

/// A special type of [Failure] indicating that a process has been cancelled
/// by the user.
/// Used in the authentication process, when user cancels the sign in flow.
class CancelFailure extends Failure {
  CancelFailure() : super('');

  @override
  String toString() {
    return 'CancelFailure';
  }
}

/// A failure that is used in screens in order to show snackbar with failure
/// message and to show error widgets to retry the failed request.
class RetryFailure extends Failure {
  RetryFailure(String message) : super(message);

  @override
  String toString() {
    return 'RetryFailure: $message';
  }
}

/// A failure that is used in screens in order to show snackbar with failure
/// message and to navigate the user to authentication screen.
class AuthenticateFailure extends Failure {
  AuthenticateFailure(String message) : super(message);

  @override
  String toString() {
    return 'AuthenticateFailure: $message';
  }
}

/// A failure that the ui would not react to.
/// It is dealt with the same way as a successful request.
class IgnoredFailure extends Failure {
  IgnoredFailure() : super('');

  @override
  String toString() {
    return 'IgnoredFailure';
  }
}

/// A failure representing the case where there are not updates made in the
/// system.
class NoResultFailure extends Failure {
  NoResultFailure() : super('');

  @override
  String toString() {
    return 'NoUpdateOperationsFailure';
  }
}

/*
failures requiring retry actions:
  connection timed out
  unknown network error
  too many requests
  process failed
  no internet connection

failures requiring authenticate action:
  you do not exist in the system
  token expired
  invalid token

failures requiring no action:
  account exists with different credentials
  invalid credential
  operation not allowed
  user disabled
  user not found 
*/

extension DioErrorFailure on DioError {
  String? get statusMessage => response?.data['status'];

  Failure get failure {
    switch (type) {
      case DioErrorType.connectTimeout:
        return RetryFailure(LocaleKeys.connectionTimedOut.tr());
      case DioErrorType.sendTimeout:
        return RetryFailure(LocaleKeys.sendingDataTimedout.tr());
      case DioErrorType.receiveTimeout:
        return RetryFailure(LocaleKeys.receivingDataTimedout.tr());
      case DioErrorType.cancel:
        return Failure(LocaleKeys.requestWasCancelled.tr());
      case DioErrorType.other:
        debugPrint(toString());
        return RetryFailure(LocaleKeys.unknownNetworkError.tr());
      case DioErrorType.response:
        String? errorMessage = response?.data['status'];
        if (errorMessage != null &&
            ServerErrorMessages.isAServerErrorMessage(errorMessage)) {
          return ServerErrorMessages.getFailure(errorMessage);
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
  Failure get failure => CancelFailure();
}

// extension NoCurrentUserExceptionExtention on NoCurrentUserException {
//   Failure get failure => Failure('There is no current logged in user');
// }
