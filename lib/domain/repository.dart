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
import 'package:urrevs_ui_mobile/data/requests/search_api_requests.dart';
import 'package:urrevs_ui_mobile/data/responses/phones_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/search_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/update_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/users_api_response.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/info.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
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

  Future<Either<Failure, void>> authenticateWithGoogle() async {
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
    });
  }

  Future<Either<Failure, void>> authenticateWithFacebook() async {
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

  Future<Either<Failure, SearchProductsAndCompaiesResponse>>
      searchProductsAndCompanies(String searchWord) async {
    return _tryAndCatch(() async {
      final response =
          await _remoteDataSource.searchProductsAndCompanies(searchWord);
      return response;
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
}
