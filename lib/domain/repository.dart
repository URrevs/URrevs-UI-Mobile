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
import 'package:urrevs_ui_mobile/data/responses/update_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/users_api_response.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
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
}
