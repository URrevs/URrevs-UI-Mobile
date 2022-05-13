import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:urrevs_ui_mobile/app/exceptions.dart';
import 'package:urrevs_ui_mobile/data/remote_data_source/remote_data_source.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/search_api_requests.dart';
import 'package:urrevs_ui_mobile/data/responses/phones_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/questions_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/search_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/update_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/users_api_response.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/info.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/quesiton.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';
import 'package:urrevs_ui_mobile/domain/models/specs.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';

class Repository {
  final RemoteDataSource _remoteDataSource;
  Repository({
    required RemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  Future<void> _checkConnection() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection) throw NoInternetConnection();
  }

  Future<Either<Failure, T>> _tryAndCatch<T>(
      Future<T> Function() callBack) async {
    try {
      await _checkConnection();
      T data = await callBack();
      return Right(data);
    } on AuthenticationCancelled catch (e) {
      return Left(e.failure);
    } on NoInternetConnection catch (e) {
      return Left(e.failure);
    } on DioError catch (e) {
      return Left(e.failure);
    } on FirebaseAuthException catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, User>> authenticateWithGoogle() async {
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

      // login to out backend
      String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      String authorizationHeader = 'Bearer $idToken';
      AuthenticationResponse response =
          await _remoteDataSource.authenticate(authorizationHeader);

      // save the token
      GetIt.I<Dio>().options.headers[HttpHeaders.authorizationHeader] =
          'bearer ${response.token}';

      final profileRes = await _remoteDataSource.getMyProfile();
      return profileRes.userSubResponse.userModel;
    });
  }

  Future<Either<Failure, User>> authenticateWithFacebook() async {
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
      return profileRes.userSubResponse.userModel;
    });
  }

  Future<Either<Failure, void>> givePointsToUser() async {
    return _tryAndCatch(() async {
      String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      await _remoteDataSource.givePointsToUser('bearer $idToken');
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

  Future<Either<Failure, List<SearchResult>>> searchPhones(
      String searchWord) async {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.searchPhones(searchWord);
      return response.searchResults;
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

  Future<Either<Failure, Info>> getPhoneStatisticalInfo(String phoneId) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.getPhoneStatisticalInfo(phoneId);
      return response.infoSubResponse.infoModel;
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
      String reviewId, AddCommentToPhoneReviewRequest request) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.addCommentToPhoneReview(reviewId, request);
      return response.commentId;
    });
  }

  Future<Either<Failure, String>> addCommentToCompanyReview(
      String reviewId, AddCommentToCompanyReviewRequest request) {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.addCommentToCompanyReview(reviewId, request);
      return response.commentId;
    });
  }

  Future<Either<Failure, String>> addReplyToPhoneReviewComment(
      String commentId, AddReplyToPhoneReviewCommentRequest request) {
    return _tryAndCatch(() async {
      final response = await _remoteDataSource.addReplyToPhoneReviewComment(
          commentId, request);
      return response.replyId;
    });
  }

  Future<Either<Failure, String>> addReplyToCompanyReviewComment(
      String commentId, AddReplyToCompanyReviewCommentRequest request) {
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
}
