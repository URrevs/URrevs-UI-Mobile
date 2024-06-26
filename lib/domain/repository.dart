import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_user_agentx/flutter_user_agent.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:urrevs_ui_mobile/app/exceptions.dart';
import 'package:urrevs_ui_mobile/app/globals.dart';
import 'package:urrevs_ui_mobile/data/remote_data_source/remote_data_source.dart';
import 'package:urrevs_ui_mobile/data/requests/base_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/leaderboard_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/questions_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/reports_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/search_api_requests.dart';
import 'package:urrevs_ui_mobile/data/responses/phones_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/questions_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/reviews_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/search_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/update_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/users_api_response.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/company_stats.dart';
import 'package:urrevs_ui_mobile/domain/models/competition.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_stats.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/domain/models/specs.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';
import 'package:urrevs_ui_mobile/domain/repository_returned_models.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class Repository {
  final RemoteDataSource _remoteDataSource;
  Repository({
    required RemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  Future<void> _checkConnection() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection) throw NoInternetConnection();
  }

  // Future<void> _renewTokenIfEnded() async {
  //   if (tokenExpiryDate != null &&
  //       tokenExpiryDate! < DateTime.now().millisecondsSinceEpoch) {
  //         final response = await _remoteDataSource.
  //       }
  // }

  Future<Either<Failure, T>> _tryAndCatch<T>(Future<T> Function() callBack,
      {Left<Failure, T>? Function(DioError)? onDioError}) async {
    try {
      await _checkConnection();
      await _checkTokenExpiryDate();
      print(
          'request is sent @${DateTime.now()}, tokenExpiryDate: $tokenExpiryDate');
      T data = await callBack();
      return Right(data);
    } on AuthenticationCancelled catch (e) {
      return Left(e.failure);
    } on NoInternetConnection catch (e) {
      return Left(e.failure);
    } on DioError catch (e) {
      if (onDioError != null) {
        final Left<Failure, T>? left = onDioError(e);
        if (left != null) return left;
      }
      return Left(e.failure);
    } on FirebaseAuthException catch (e) {
      return Left(e.failure);
    }
  }

  Future<void> _checkTokenExpiryDate() async {
    DateTime? expiryDate = tokenExpiryDate?.subtract(Duration(minutes: 1));
    if (expiryDate == null) return; // first authentication request
    if (DateTime.now().isAfter(expiryDate)) {
      print('updating expired token');
      await _loginToBackendWithoutChecking();
      print('token updated, new expiry date: $tokenExpiryDate');
    }
  }

  Future<AuthReturnedVals> _loginToBackendWithoutChecking() async {
    // login to our backend
    String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    String authorizationHeader = 'Bearer $idToken';
    AuthenticationResponse response =
        await _remoteDataSource.authenticate(authorizationHeader);

    // save the token and expiry date
    GetIt.I<Dio>().options.headers[HttpHeaders.authorizationHeader] =
        'bearer ${response.token}';
    tokenExpiryDate = DateTime.fromMillisecondsSinceEpoch(response.exp * 1000);

    return response.authReturnedVals;
  }

  Left<Failure, T>? _handleAlreadyUnlikedError<T>(DioError e) {
    if (e.statusMessage == ManuallyHandlledErrorMessages.notFound) {
      return Left(IgnoredFailure());
    }
    return null;
  }

  Future<String> get _webUserAgent async {
    try {
      await FlutterUserAgent.init();
      final userAgent = FlutterUserAgent.webViewUserAgent;
      if (userAgent == null) throw Exception();
      return userAgent;
    } catch (e) {
      return '';
    }
  }

  Future<Either<Failure, AuthReturnedVals>> loginToOurBackend() async {
    return _tryAndCatch(() async {
      return _loginToBackendWithoutChecking();
    });
  }

  Future<Either<Failure, AuthReturnedVals>> authenticateWithGoogle() async {
    return _tryAndCatch(() async {
      // login to google auth provider
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw AuthenticationCancelled();

      // login to firebase auth provider
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      return _loginToBackendWithoutChecking();
    });
  }

  Future<Either<Failure, AuthReturnedVals>> authenticateWithFacebook() async {
    return _tryAndCatch(() async {
      // login to facebook auth provider
      await FacebookAuth.instance.logOut();
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken == null) throw AuthenticationCancelled();

      // login to firebase auth provider
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      return _loginToBackendWithoutChecking();
    });
  }

  Future<Either<Failure, void>> givePointsToUser() async {
    return _tryAndCatch(() async {
      await _remoteDataSource.givePointsToUser();
    });
  }

  Future<Either<Failure, void>> logoutFromAllDevices() async {
    return _tryAndCatch(() async {
      await _remoteDataSource.logoutFromAllDevices();
    });
  }

  Future<Either<Failure, GetMyProfileResponse>> getMyProfile() async {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getMyProfile();
      return response;
    });
  }

  Future<Either<Failure, User>> getTheProfileOfAnotherUser(
      String userId) async {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getTheProfileOfAnotherUser(userId);
      return response.anotherUserSubResponse.userModel;
    });
  }

  Future<Either<Failure, List<Phone>>> getMyOwnedPhones(int round) async {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getMyOwnedPhones(round);
      return response.phonesModels;
    });
  }

  Future<Either<Failure, List<Phone>>> getTheOwnedPhonesOfAnotherUser(
      String userId, int round) async {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getTheOwnedPhonesOfAnotherUser(userId, round);
      return response.phonesModels;
    });
  }

  Future<Either<Failure, void>> updateTargetsFromSource() async {
    return _tryAndCatch(() async {
      await _remoteDataSource.updateTargetsFromSource();
    });
  }

  Future<Either<Failure, GetInfoAboutLatestUpdateResponse>>
      getInfoAboutLatestUpdate() async {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getInfoAboutLatestUpdate();
      return response;
    });
  }

  Future<Either<Failure, List<SearchResult>>> getMyRecentSearches() async {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getMyRecentSearches();
      return response.searchResults;
    });
  }

  Future<Either<Failure, void>> addNewRecentSearch(
      AddNewRecentSearchRequest request) async {
    return _tryAndCatch(() async {
      await _remoteDataSource.addNewRecentSearch(request);
    });
  }

  Future<Either<Failure, void>> deleteRecentSearch(
      DeleteRecentSearchRequest request) async {
    return _tryAndCatch(() async {
      await _remoteDataSource.deleteRecentSearch(request);
    });
  }

  Future<Either<Failure, List<SearchResult>>> searchProductsAndCompanies(
      String searchWord) async {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.searchProductsAndCompanies(searchWord);
      return response.searchResults;
    });
  }

  Future<Either<Failure, List<SearchResult>>> searchProducts(
      String searchWord) async {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.searchProducts(searchWord);
      return response.searchResults;
    });
  }

  Future<Either<Failure, List<SearchResult>>> searchPhones(
      String searchWord) async {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.searchPhones(searchWord);
      return response.searchResults;
    });
  }

  Future<Either<Failure, CompanyStats>> getCompanyStatisticalInfo(
      String companyId) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getCompanyStatisticalInfo(companyId);
      return response.companyStatsModel;
    });
  }

  Future<Either<Failure, List<Company>>> getAllCompanies(int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getAllCompanies(round);
      return response.companeisModels;
    });
  }

  Future<Either<Failure, List<Phone>>> getAllPhones(int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getAllPhones(round);
      return response.phonesModels;
    });
  }

  Future<Either<Failure, List<Phone>>> getPhonesFromCertainCompany(
      String companyId, int round) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getPhonesFromCertainCompany(companyId, round);
      return response.phonesModels;
    });
  }

  Future<Either<Failure, Company>> getPhoneManufacturingCompany(
      String phoneId) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getPhoneManufacturingCompany(phoneId);
      return response.companySubResponse.companyModel;
    });
  }

  Future<Either<Failure, Specs>> getPhoneSpecs(String phoneId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getPhoneSpecs(phoneId);
      return response.specsSubResponse.specsModel;
    });
  }

  Future<Either<Failure, List<Specs>>> getTwoPhonesSpecs(
    String firstPhoneId,
    String secondPhoneId,
  ) {
    return _tryAndCatch(() async {
      final List<GetPhoneSpecsResponse> responses = await Future.wait([
        _remoteDataSource.getPhoneSpecs(firstPhoneId),
        _remoteDataSource.getPhoneSpecs(secondPhoneId),
      ]);
      return responses.map((r) => r.specsSubResponse.specsModel).toList();
    });
  }

  Future<Either<Failure, PhoneStats>> getPhoneStatisticalInfo(String phoneId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getPhoneStatisticalInfo(phoneId);
      return response.infoSubResponse.phoneStatsModel;
    });
  }

  Future<Either<Failure, void>> indicateUserComparedBetweenTwoPhones(
      String phoneId1, phoneId2) {
    return _tryAndCatch(() async {
      await _remoteDataSource.indicateUserComparedBetweenTwoPhones(
          phoneId1, phoneId2);
    });
  }

  Future<Either<Failure, List<Phone>>> getSimilarPhones(String phoneId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getSimilarPhones(phoneId);
      return response.phonesModels;
    });
  }

  Future<Either<Failure, double>> verifyPhone(String phoneId) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.verifyPhone(phoneId, await _webUserAgent);
      return response.verificationRatio;
    });
  }

  Future<Either<Failure, AddPhoneReviewReturnedVals>> addPhoneReview(
      AddPhoneReviewRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addPhoneReview(
          request, await _webUserAgent);
      return response.addPhoneReviewReturnedVals;
    });
  }

  Future<Either<Failure, PhoneReview>> getPhoneReview(String reviewId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getPhoneReview(reviewId);
      return response.phoneReviewSubRespone.phoneReviewModel;
    });
  }

  Future<Either<Failure, CompanyReview>> getCompanyReview(String reviewId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getCompanyReview(reviewId);
      return response.companyReviewSubResponses.companyReviewModel;
    });
  }

  Future<Either<Failure, List<PhoneReview>>> getMyPhoneReviews(int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getMyPhoneReviews(round);
      return response.phoneReviewsModels;
    });
  }

  Future<Either<Failure, List<PhoneReview>>> getPhoneReviewsOfAnotherUser(
      String userId, int round) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getPhoneReviewsOfAnotherUser(userId, round);
      return response.phoneReviewsModels;
    });
  }

  Future<Either<Failure, List<CompanyReview>>> getMyCompanyReviews(int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getMyCompanyReviews(round);
      return response.companyReviewsModels;
    });
  }

  Future<Either<Failure, List<CompanyReview>>> getCompanyReviewsOfAnotherUser(
      String userId, int round) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getCompanyReviewsOfAnotherUser(userId, round);
      return response.companyReviewsModels;
    });
  }

  Future<Either<Failure, List<PhoneReview>>> getReviewsOnCertainPhone(
      String phoneId, int round) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getReviewsOnCertainPhone(phoneId, round);
      return response.phoneReviewsModels;
    });
  }

  Future<Either<Failure, List<CompanyReview>>> getReviewsOnCertainCompany(
      String companyId, int round) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getReviewsOnCertainCompany(companyId, round);
      return response.companyReviewsModels;
    });
  }

  Future<Either<Failure, void>> likePhoneReview(String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.likePhoneReview(reviewId);
    });
  }

  Future<Either<Failure, void>> unlikePhoneReview(String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unlikePhoneReview(reviewId);
    });
  }

  Future<Either<Failure, void>> likeCompanyReview(String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.likeCompanyReview(reviewId);
    });
  }

  Future<Either<Failure, void>> unlikeCompanyReview(String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unlikeCompanyReview(reviewId);
    });
  }

  Future<Either<Failure, List<Comment>>> getCommentsAndRepliesForPhoneReview(
      String reviewId, int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .getCommentsAndRepliesForPhoneReview(reviewId, round);
      return response.commentsModels;
    });
  }

  Future<Either<Failure, List<Comment>>> getCommentsAndRepliesForCompanyReview(
      String reviewId, int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .getCommentsAndRepliesForCompanyReview(reviewId, round);
      return response.commentsModels;
    });
  }

  Future<Either<Failure, String>> addCommentToPhoneReview(
      String reviewId, AddInteractionRequest request) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.addCommentToPhoneReview(reviewId, request);
      return response.commentId;
    });
  }

  Future<Either<Failure, String>> addCommentToCompanyReview(
      String reviewId, AddInteractionRequest request) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.addCommentToCompanyReview(reviewId, request);
      return response.commentId;
    });
  }

  Future<Either<Failure, String>> addReplyToPhoneReviewComment(
      String commentId, AddInteractionRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addReplyToPhoneReviewComment(
          commentId, request);
      return response.replyId;
    });
  }

  Future<Either<Failure, String>> addReplyToCompanyReviewComment(
      String commentId, AddInteractionRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addReplyToCompanyReviewComment(
          commentId, request);
      return response.replyId;
    });
  }

  Future<Either<Failure, void>> likePhoneReviewComment(String commentId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.likePhoneReviewComment(commentId);
    });
  }

  Future<Either<Failure, void>> unlikePhoneReviewComment(String commentId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unlikePhoneReviewComment(commentId);
    }, onDioError: _handleAlreadyUnlikedError);
  }

  Future<Either<Failure, void>> likeCompanyReviewComment(String commentId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.likeCompanyReviewComment(commentId);
    });
  }

  Future<Either<Failure, void>> unlikeCompanyReviewComment(String commentId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unlikeCompanyReviewComment(commentId);
    }, onDioError: _handleAlreadyUnlikedError);
  }

  Future<Either<Failure, void>> likePhoneReviewReply(
      String commentId, String replyId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.likePhoneReviewReply(commentId, replyId);
    });
  }

  Future<Either<Failure, void>> unlikePhoneReviewReply(
      String commentId, String replyId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unlikePhoneReviewReply(commentId, replyId);
    }, onDioError: _handleAlreadyUnlikedError);
  }

  Future<Either<Failure, void>> likeCompanyReviewReply(
      String commentId, String replyId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.likeCompanyReviewReply(commentId, replyId);
    });
  }

  Future<Either<Failure, void>> unlikeCompanyReviewReply(
      String commentId, String replyId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unlikeCompanyReviewReply(commentId, replyId);
    }, onDioError: _handleAlreadyUnlikedError);
  }

  Future<Either<Failure, void>> iDontLikeThisForPhoneReview(String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.iDontLikeThisForPhoneReview(reviewId);
    });
  }

  Future<Either<Failure, void>> iDontLikeThisForCompanyReview(String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.iDontLikeThisForCompanyReview(reviewId);
    });
  }

  Future<Either<Failure, void>> increaseViewCountForPhoneReview(
      String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.increaseViewCountForPhoneReview(reviewId);
    });
  }

  Future<Either<Failure, void>> increaseViewCountForCompanyReview(
      String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.increaseViewCountForCompanyReview(reviewId);
    });
  }

  Future<Either<Failure, void>> increaseShareCountForPhoneReview(
      String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.increaseShareCountForPhoneReview(reviewId);
    });
  }

  Future<Either<Failure, void>> increaseShareCountForCompanyReview(
      String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.increaseShareCountForCompanyReview(reviewId);
    });
  }

  Future<Either<Failure, void>> userPressesSeeMoreInPhoneReview(
      String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.userPressesSeeMoreInPhoneReview(reviewId);
    });
  }

  Future<Either<Failure, void>> userPressesSeeMoreInCompanyReview(
      String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.userPressesSeeMoreInCompanyReview(reviewId);
    });
  }

  Future<Either<Failure, void>> userPressesFullscreenInPhoneReview(
      String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.userPressesFullscreenInPhoneReview(reviewId);
    });
  }

  Future<Either<Failure, void>> userPressesFullscreenInCompanyReview(
      String reviewId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.userPressesFullscreenInCompanyReview(reviewId);
    });
  }

  Future<Either<Failure, double>> verifyPhoneReview(String reviewId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.verifyPhoneReview(
          reviewId, await _webUserAgent);
      return response.verificationRatio;
    });
  }

  Future<Either<Failure, Question>> addPhoneQuestion(
      AddPhoneQuestionRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addPhoneQuestion(request);
      return response.questionSubResponse.questionModel;
    });
  }

  Future<Either<Failure, Question>> addCompanyQuestion(
      AddCompanyQuestionRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addCompanyQuestion(request);
      return response.questionSubResponse.questionModel;
    });
  }

  Future<Either<Failure, Question>> getPhoneQuestion(String questionId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getPhoneQuestion(questionId);
      return response.questionSubResponse.questionModel;
    });
  }

  Future<Either<Failure, Question>> getCompanyQuestion(String questionId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getCompanyQuestion(questionId);
      return response.questionSubResponse.questionModel;
    });
  }

  Future<Either<Failure, List<Question>>> getMyPhoneQuestions(int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getMyPhoneQuestions(round);
      return response.questionsModels;
    });
  }

  Future<Either<Failure, List<Question>>> getMyCompanyQuestions(int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getMyCompanyQuestions(round);
      return response.questionsModels;
    });
  }

  Future<Either<Failure, List<Question>>> getPhoneQuestionsOfAnotherUser(
      String userId, int round) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getPhoneQuestionsOfAnotherUser(userId, round);
      return response.questionsModels;
    });
  }

  Future<Either<Failure, List<Question>>> getCompanyQuestionsOfAnotherUser(
      String userId, int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getCompanyQuestionsOfAnotherUser(
          userId, round);
      return response.questionsModels;
    });
  }

  Future<Either<Failure, List<Question>>> getQuestionsAboutMyOwnedPhones(
      int round) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getQuestionsAboutMyOwnedPhones(round);
      return response.questionsModels;
    });
  }

  Future<Either<Failure, List<Question>>> getQuestionsOnCertainPhone(
      String phoneId, int round) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.getQuestionsOnCertainPhone(phoneId, round);
      return response.questionsModels;
    });
  }

  Future<Either<Failure, List<Question>>> getQuestionsOnCertainCompany(
      String companyId, int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getQuestionsOnCertainCompany(
          companyId, round);
      return response.questionsModels;
    });
  }

  Future<Either<Failure, void>> upvotePhoneQuestion(String questionId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.upvotePhoneQuestion(questionId);
    });
  }

  Future<Either<Failure, void>> downvotePhoneQuestion(String questionId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.downvotePhoneQuestion(questionId);
    });
  }

  Future<Either<Failure, void>> upvoteCompanyQuestion(String questionId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.upvoteCompanyQuestion(questionId);
    });
  }

  Future<Either<Failure, void>> downvoteCompanyQuestion(String questionId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.downvoteCompanyQuestion(questionId);
    });
  }

  Future<Either<Failure, List<Answer>>> getAnswersAndRepliesForPhoneQuestion(
      String questionId, int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .getAnswersAndRepliesForPhoneQuestion(questionId, round);
      return response.answersModels;
    });
  }

  Future<Either<Failure, List<Answer>>> getAnswersAndRepliesForCompanyQuestion(
      String questionId, int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .getAnswersAndRepliesForCompanyQuestion(questionId, round);
      return response.answersModels;
    });
  }

  Future<Either<Failure, AddAnswerReturnedVals>> addAnswerToPhoneQuestion(
      String questionId, AddInteractionRequest request) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.addAnswerToPhoneQuestion(questionId, request);
      return AddAnswerReturnedVals(
        answerId: response.answerId,
        ownedAt: response.ownedAt,
      );
    }, onDioError: (e) {
      final status = e.response?.data['status'];
      if (status != null && status == ManuallyHandlledErrorMessages.notOwned) {
        return Left(Failure(LocaleKeys.youHaventReviewedThatPhone.tr()));
      }
      return Left(e.failure);
    });
  }

  Future<Either<Failure, String>> addAnswerToCompanyQuestion(
      String questionId, AddInteractionRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addAnswerToCompanyQuestion(
          questionId, request);
      return response.answerId;
    }, onDioError: (e) {
      final status = e.response?.data['status'];
      if (status != null && status == ManuallyHandlledErrorMessages.notOwned) {
        return Left(Failure(LocaleKeys.youCantAnswerAQuestionMessage.tr()));
      }
      return Left(e.failure);
    });
  }

  Future<Either<Failure, String>> addReplyToPhoneQuestionAnswer(
      String answerId, AddInteractionRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addReplyToPhoneQuestionAnswer(
          answerId, request);
      return response.replyId;
    });
  }

  Future<Either<Failure, String>> addReplyToCompanyQuestionAnswer(
      String answerId, AddInteractionRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addReplyToCompanyQuestionAnswer(
          answerId, request);
      return response.replyId;
    });
  }

  Future<Either<Failure, void>> upvotePhoneQuestionAnswer(String answerId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.upvotePhoneQuestionAnswer(answerId);
    });
  }

  Future<Either<Failure, void>> downvotePhoneQuestionAnswer(String answerId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.downvotePhoneQuestionAnswer(answerId);
    }, onDioError: _handleAlreadyUnlikedError);
  }

  Future<Either<Failure, void>> upvoteCompanyQuestionAnswer(String answerId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.upvoteCompanyQuestionAnswer(answerId);
    });
  }

  Future<Either<Failure, void>> downvoteCompanyQuestionAnswer(String answerId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.downvoteCompanyQuestionAnswer(answerId);
    }, onDioError: _handleAlreadyUnlikedError);
  }

  Future<Either<Failure, void>> likePhoneQuestionReply(
      String answerId, String replyId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.likePhoneQuestionReply(answerId, replyId);
    });
  }

  Future<Either<Failure, void>> unlikePhoneQuestionReply(
      String answerId, String replyId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unlikePhoneQuestionReply(answerId, replyId);
    }, onDioError: _handleAlreadyUnlikedError);
  }

  Future<Either<Failure, void>> likeCompanyQuestionReply(
      String answerId, String replyId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.likeCompanyQuestionReply(answerId, replyId);
    });
  }

  Future<Either<Failure, void>> unlikeCompanyQuestionReply(
      String answerId, String replyId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unlikeCompanyQuestionReply(answerId, replyId);
    }, onDioError: _handleAlreadyUnlikedError);
  }

  Future<Either<Failure, void>> iDontLikeThisForPhoneQuestion(
      String questionId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.iDontLikeThisForPhoneQuestion(questionId);
    });
  }

  Future<Either<Failure, void>> iDontLikeThisForCompanyQuestion(
      String questionId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.iDontLikeThisForCompanyQuestion(questionId);
    });
  }

  Future<Either<Failure, String>> markAnswerAsAcceptedForPhone(
      String questionId, String answerId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.markAnswerAsAcceptedForPhone(
          questionId, answerId);
      return response.id;
    }, onDioError: (e) {
      if (e.statusMessage == ManuallyHandlledErrorMessages.notFound) {
        return Left(IgnoredFailure());
      }
      return null;
    });
  }

  Future<Either<Failure, String>> markAnswerAsAcceptedForCompany(
      String questionId, String answerId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.markAnswerAsAcceptedForCompany(
          questionId, answerId);
      return response.id;
    }, onDioError: (e) {
      if (e.statusMessage == ManuallyHandlledErrorMessages.notFound) {
        return Left(IgnoredFailure());
      }
      return null;
    });
  }

  Future<Either<Failure, String>> unmarkAnswerAsAcceptedForPhone(
      String questionId, String answerId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.unmarkAnswerAsAcceptedForPhone(
          questionId, answerId);
      return response.id;
    }, onDioError: (e) {
      if (e.statusMessage == ManuallyHandlledErrorMessages.notYet ||
          e.statusMessage == ManuallyHandlledErrorMessages.notFound) {
        return Left(IgnoredFailure());
      }
      return null;
    });
  }

  Future<Either<Failure, String>> unmarkAnswerAsAcceptedForCompany(
      String questionId, String answerId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.unmarkAnswerAsAcceptedForCompany(
          questionId, answerId);
      return response.id;
    }, onDioError: (e) {
      if (e.statusMessage == ManuallyHandlledErrorMessages.notYet ||
          e.statusMessage == ManuallyHandlledErrorMessages.notFound) {
        return Left(IgnoredFailure());
      }
      return null;
    });
  }

  Future<Either<Failure, void>> increaseShareCountForPhoneQuestion(
      String questionId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.increaseShareCountForPhoneQuestion(questionId);
    });
  }

  Future<Either<Failure, void>> increaseShareCountForCompanyQuestion(
      String questionId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.increaseShareCountForCompanyQuestion(questionId);
    });
  }

  Future<Either<Failure, void>> userPressesFullscreenInPhoneQuestion(
      String questionId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.userPressesFullscreenInPhoneQuestion(questionId);
    });
  }

  Future<Either<Failure, void>> userPressesFullscreenInCompanyQuestion(
      String questionId) {
    return _tryAndCatch(() async {
      await _remoteDataSource
          .userPressesFullscreenInCompanyQuestion(questionId);
    });
  }

  Future<Either<Failure, String>> addCompetition(
      AddCompetitionRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addCompetition(request);
      return response.id;
    });
  }

  Future<Either<Failure, Competition>> getLatestCompetition() {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getLatestCompetition();
      return response.competitionSubResponse.competitionModel;
    }, onDioError: (e) {
      if (e.statusMessage == ManuallyHandlledErrorMessages.notYet) {
        return Left(NoResultFailure());
      }
      return null;
    });
  }

  Future<Either<Failure, List<User>>> getTopUsersInCompetition() {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getTopUsersInCompetition();
      return response.usersModels;
    });
  }

  Future<Either<Failure, User>> getMyRankInCompetition() {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getMyRankInCompetition();
      return response.userSubResponse.userModel;
    });
  }

  Future<Either<Failure, List<Post>>> getPostsForHomeScreen(int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getPostsForHomeScreen();
      return response.postsModels;
    });
  }

  Future<Either<Failure, void>> undoDeleteData() {
    return _tryAndCatch(() async {
      await _remoteDataSource.undoDeleteData();
    });
  }

  Future<Either<Failure, void>> deleteData() {
    return _tryAndCatch(() async {
      await _remoteDataSource.deleteData();
    });
  }

  Future<Either<Failure, void>> reportPhoneReview(
      String reviewId, ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportPhoneReview(reviewId, request);
    });
  }

  Future<Either<Failure, void>> reportCompanyReview(
      String reviewId, ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportCompanyReview(reviewId, request);
    });
  }

  Future<Either<Failure, void>> reportPhoneQuestion(
      String questionId, ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportPhoneQuestion(questionId, request);
    });
  }

  Future<Either<Failure, void>> reportCompanyQuestion(
      String questionId, ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportCompanyQuestion(questionId, request);
    });
  }

  Future<Either<Failure, void>> reportPhoneReviewComment(
      String reviewId, String commentId, ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportPhoneReviewComment(
          reviewId, commentId, request);
    });
  }

  Future<Either<Failure, void>> reportCompanyReviewComment(
      String reviewId, String commentId, ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportCompanyReviewComment(
          reviewId, commentId, request);
    });
  }

  Future<Either<Failure, void>> reportPhoneQuestionAnswer(
      String questionId, String answerId, ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportPhoneQuestionAnswer(
          questionId, answerId, request);
    });
  }

  Future<Either<Failure, void>> reportCompanyQuestionAnswer(
      String questionId, String answerId, ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportCompanyQuestionAnswer(
          questionId, answerId, request);
    });
  }

  Future<Either<Failure, void>> reportPhoneReviewCommentReply(String reviewId,
      String commentId, String replyId, ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportPhoneReviewCommentReply(
          reviewId, commentId, replyId, request);
    });
  }

  Future<Either<Failure, void>> reportCompanyReviewCommentReply(String reviewId,
      String commentId, String replyId, ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportCompanyReviewCommentReply(
          reviewId, commentId, replyId, request);
    });
  }

  Future<Either<Failure, void>> reportPhoneQuestionAnswerReply(
      String questionId,
      String answerId,
      String replyId,
      ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportPhoneQuestionAnswerReply(
          questionId, answerId, replyId, request);
    });
  }

  Future<Either<Failure, void>> reportCompanyQuestionAnswerReply(
      String questionId,
      String answerId,
      String replyId,
      ReportSocialItemRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.reportCompanyQuestionAnswerReply(
          questionId, answerId, replyId, request);
    });
  }

  Future<Either<Failure, void>> hidePhoneReview(
      String reviewId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hidePhoneReview(reviewId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> blockUser(
      String userId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.blockUser(userId);
      await _remoteDataSource.updateReportState(reportId, request);
    }, onDioError: (e) {
      if (e.statusMessage == ManuallyHandlledErrorMessages.notFound) {
        return Left(Failure(LocaleKeys.userIsAdminOrDoesntExist.tr()));
      }
      return null;
    });
  }

  Future<Either<Failure, void>> unblockUser(
      String userId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unblockUser(userId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hideCompanyReview(
      String reviewId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hideCompanyReview(reviewId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhidePhoneReview(
      String reviewId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhidePhoneReview(reviewId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhideCompanyReview(
      String reviewId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhideCompanyReview(reviewId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hidePhoneQuestion(
      String questionId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hidePhoneQuestion(questionId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hideCompanyQuestion(
      String questionId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hideCompanyQuestion(questionId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhidePhoneQuestion(
      String questionId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhidePhoneQuestion(questionId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhideCompanyQuestion(
      String questionId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhideCompanyQuestion(questionId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hidePhoneReviewComment(
      String commentId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hidePhoneReviewComment(commentId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hideCompanyReviewComment(
      String commentId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hideCompanyReviewComment(commentId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhidePhoneReviewComment(
      String commentId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhidePhoneReviewComment(commentId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhideCompanyReviewComment(
      String commentId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhideCompanyReviewComment(commentId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hidePhoneQuestionAnswer(
      String answerId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hidePhoneQuestionAnswer(answerId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hideCompanyQuestionAnswer(
      String answerId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hideCompanyQuestionAnswer(answerId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhidePhoneQuestionAnswer(
      String answerId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhidePhoneQuestionAnswer(answerId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhideCompanyQuestionAnswer(
      String answerId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhideCompanyQuestionAnswer(answerId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hidePhoneReviewReply(String commentId,
      String replyId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hidePhoneReviewReply(commentId, replyId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hideCompanyReviewReply(String commentId,
      String replyId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hideCompanyReviewReply(commentId, replyId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hidePhoneQuestionReply(String answerId,
      String replyId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hidePhoneQuestionReply(answerId, replyId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> hideCompanyQuestionReply(String answerId,
      String replyId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.hideCompanyQuestionReply(answerId, replyId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhidePhoneReviewReply(String commentId,
      String replyId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhidePhoneReviewReply(commentId, replyId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhideCompanyReviewReply(String commentId,
      String replyId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhideCompanyReviewReply(commentId, replyId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhidePhoneQuestionReply(String answerId,
      String replyId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhidePhoneQuestionReply(answerId, replyId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> unhideCompanyQuestionReply(String answerId,
      String replyId, String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unhideCompanyQuestionReply(answerId, replyId);
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, List<Report>>> getOpenReports(int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getOpenReports(round);
      return response.reportsModels;
    });
  }

  Future<Either<Failure, List<Report>>> getClosedReports(int round) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getClosedReports(round);
      return response.reportsModels;
    });
  }

  Future<Either<Failure, void>> updateReportState(
      String reportId, UpdateReportStateRequest request) {
    return _tryAndCatch(() async {
      await _remoteDataSource.updateReportState(reportId, request);
    });
  }

  Future<Either<Failure, void>> closeReport(String reportId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.closeReport(reportId);
    });
  }

  Future<Either<Failure, PhoneReview>> showReportPhoneReview(String reviewId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.showReportPhoneReview(reviewId);
      return response.phoneReviewSubRespone.phoneReviewModel;
    });
  }

  Future<Either<Failure, CompanyReview>> showReportCompanyReview(
      String reviewId) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.showReportCompanyReview(reviewId);
      return response.companyReviewSubResponses.companyReviewModel;
    });
  }

  Future<Either<Failure, Comment>> showReportPhoneReviewComment(
      String commentId) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.showReportPhoneReviewComment(commentId);
      return response.commentModel;
    });
  }

  Future<Either<Failure, Comment>> showReportCompanyReviewComment(
      String commentId) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.showReportCompanyReviewComment(commentId);
      return response.commentModel;
    });
  }

  Future<Either<Failure, ReplyModel>> showReportPhoneReviewCommentReply(
      String commentId, String replyId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .showReportPhoneReviewCommentReply(commentId, replyId);
      return response.replyModel;
    });
  }

  Future<Either<Failure, ReplyModel>> showReportCompanyReviewCommentReply(
      String commentId, String replyId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .showReportCompanyReviewCommentReply(commentId, replyId);
      return response.replyModel;
    });
  }

  Future<Either<Failure, Question>> showReportPhoneQuestion(String questionId) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.showReportPhoneQuestion(questionId);
      return response.questionSubResponse.questionModel;
    });
  }

  Future<Either<Failure, Question>> showReportCompanyQuestion(
      String questionId) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.showReportCompanyQuestion(questionId);
      return response.questionSubResponse.questionModel;
    });
  }

  Future<Either<Failure, Answer>> showReportPhoneQuestionAnswer(
      String answerId) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.showReportPhoneQuestionAnswer(answerId);
      return response.answerModel;
    });
  }

  Future<Either<Failure, Answer>> showReportCompanyQuestionAnswer(
      String answerId) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.showReportCompanyQuestionAnswer(answerId);
      return response.answerModel;
    });
  }

  Future<Either<Failure, ReplyModel>> showReportPhoneQuestionAnswerReply(
      String answerId, String replyId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .showReportPhoneQuestionAnswerReply(answerId, replyId);
      return response.replyModel;
    });
  }

  Future<Either<Failure, ReplyModel>> showReportCompanyQuestionAnswerReply(
      String answerId, String replyId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .showReportCompanyQuestionAnswerReply(answerId, replyId);
      return response.replyModel;
    });
  }

  Future<Either<Failure, ShowReportContextReturnedVals>>
      showReportPhoneReviewCommentContext(String reviewId, String commentId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .showReportPhoneReviewCommentContext(reviewId, commentId);
      return response.returnedVals;
    });
  }

  Future<Either<Failure, ShowReportContextReturnedVals>>
      showReportCompanyReviewCommentContext(String reviewId, String commentId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .showReportCompanyReviewCommentContext(reviewId, commentId);
      return response.returnedVals;
    });
  }

  Future<Either<Failure, ShowReportContextReturnedVals>>
      showReportPhoneQuestionAnswerContext(String questionId, String answerId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .showReportPhoneQuestionAnswerContext(questionId, answerId);
      return response.returnedVals;
    });
  }

  Future<Either<Failure, ShowReportContextReturnedVals>>
      showReportCompanyQuestionAnswerContext(
          String questionId, String answerId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource
          .showReportCompanyQuestionAnswerContext(questionId, answerId);
      return response.returnedVals;
    });
  }
}
