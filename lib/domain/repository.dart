import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:urrevs_ui_mobile/app/exceptions.dart';
import 'package:urrevs_ui_mobile/data/remote_data_source/remote_data_source.dart';
import 'package:urrevs_ui_mobile/data/requests/base_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/leaderboard_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/questions_api_requests.dart';
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

  Future<Either<Failure, T>> _tryAndCatch<T>(Future<T> Function() callBack,
      {Left<Failure, T>? Function(DioError)? onDioError}) async {
    try {
      await _checkConnection();
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

  Future<Either<Failure, AuthReturnedVals>> loginToOurBackend() async {
    return _tryAndCatch(() async {
      // login to our backend
      String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      String authorizationHeader = 'Bearer $idToken';
      AuthenticationResponse response =
          await _remoteDataSource.authenticate(authorizationHeader);

      // save the token
      GetIt.I<Dio>().options.headers[HttpHeaders.authorizationHeader] =
          'bearer ${response.token}';

      final profileRes = await _remoteDataSource.getMyProfile();
      return AuthReturnedVals(
        user: profileRes.userSubResponse.userModel,
        refCode: profileRes.userSubResponse.refCode,
      );
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

      // login to our backend
      String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      String authorizationHeader = 'Bearer $idToken';
      AuthenticationResponse response =
          await _remoteDataSource.authenticate(authorizationHeader);

      // save the token
      GetIt.I<Dio>().options.headers[HttpHeaders.authorizationHeader] =
          'bearer ${response.token}';

      final profileRes = await _remoteDataSource.getMyProfile();
      return AuthReturnedVals(
        user: profileRes.userSubResponse.userModel,
        refCode: profileRes.userSubResponse.refCode,
      );
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

      // login to our backend
      String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      String authorizationHeader = 'Bearer $idToken';
      AuthenticationResponse response =
          await _remoteDataSource.authenticate(authorizationHeader);

      // saving token
      GetIt.I<Dio>().options.headers[HttpHeaders.authorizationHeader] =
          'bearer ${response.token}';

      final profileRes = await _remoteDataSource.getMyProfile();
      return AuthReturnedVals(
        user: profileRes.userSubResponse.userModel,
        refCode: profileRes.userSubResponse.refCode,
      );
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

  Future<Either<Failure, PhoneReview>> addPhoneReview(
      AddPhoneReviewRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addPhoneReview(request);
      return response.phoneReviewSubRespone.phoneReviewModel;
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
    });
  }

  Future<Either<Failure, void>> likeCompanyReviewComment(String commentId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.likeCompanyReviewComment(commentId);
    });
  }

  Future<Either<Failure, void>> unlikeCompanyReviewComment(String commentId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.unlikeCompanyReviewComment(commentId);
    });
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
    });
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
    });
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
    });
  }

  Future<Either<Failure, void>> upvoteCompanyQuestionAnswer(String answerId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.upvoteCompanyQuestionAnswer(answerId);
    });
  }

  Future<Either<Failure, void>> downvoteCompanyQuestionAnswer(String answerId) {
    return _tryAndCatch(() async {
      await _remoteDataSource.downvoteCompanyQuestionAnswer(answerId);
    });
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
    });
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
    });
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
    });
  }

  Future<Either<Failure, String>> markAnswerAsAcceptedForCompany(
      String questionId, String answerId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.markAnswerAsAcceptedForCompany(
          questionId, answerId);
      return response.id;
    });
  }

  Future<Either<Failure, String>> unmarkAnswerAsAcceptedForPhone(
      String questionId, String answerId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.unmarkAnswerAsAcceptedForPhone(
          questionId, answerId);
      return response.id;
    }, onDioError: (e) {
      if (e.statusMessage == ServerErrorMessages.notYet) {
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
      if (e.statusMessage == ServerErrorMessages.notYet) {
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
      if (e.statusMessage == ServerErrorMessages.notYet) {
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
}
