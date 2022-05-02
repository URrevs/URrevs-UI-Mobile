import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:urrevs_ui_mobile/app/exceptions.dart';
import 'package:urrevs_ui_mobile/data/remote_data_source/remote_data_source.dart';
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

  Future<Either<Failure, void>> authenticateWithGoogle() async {
    try {
      // check connection before connecting to google
      bool hasConnection = await InternetConnectionChecker().hasConnection;
      if (!hasConnection) throw NoInternetConnection();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw AuthenticationCancelled();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

      String authorizationHeader = 'Bearer $idToken';
      AuthenticationResponse response =
          await _remoteDataSource.authenticate(authorizationHeader);
      GetIt.I<Dio>().options.headers[HttpHeaders.authorizationHeader] =
          'bearer ${response.token}';


      return Right(null);
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

  Future<Either<Failure, void>> authenticateWithFacebook() async {
    try {
      // check connection before connecting to google
      bool hasConnection = await InternetConnectionChecker().hasConnection;
      if (!hasConnection) throw NoInternetConnection();

      await FacebookAuth.instance.logOut();
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.accessToken == null) throw AuthenticationCancelled();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

      String authorizationHeader = 'Bearer $idToken';
      AuthenticationResponse response =
          await _remoteDataSource.authenticate(authorizationHeader);
      GetIt.I<Dio>().options.headers[HttpHeaders.authorizationHeader] =
          'bearer ${response.token}';


      return Right(null);
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

  Future<Either<Failure, void>> givePointsToUser() async {
    try {
      String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      await _remoteDataSource.givePointsToUser('bearer $idToken');
      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    } on NoInternetConnection catch (e) {
      return Left(e.failure);
    }
  }

  // Either<Failure, String> getUserImageUrl() {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user == null) throw NoCurrentUserException();
  //     return Right(user.photoURL!);
  //   } on NoCurrentUserException catch (e) {
  //     return Left(e.failure);
  //   }
  // }

  Future<Either<Failure, GetMyProfileResponse>> getMyProfile() async {
    try {
      await _checkConnection();
      final response = await _remoteDataSource.getMyProfile();

      return Right(response);
    } on DioError catch (e) {
      return Left(e.failure);
    } on NoInternetConnection catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, User>> getTheProfileOfAnotherUser(
      String userId) async {
    try {
      await _checkConnection();
      final response =
          await _remoteDataSource.getTheProfileOfAnotherUser(userId);
      return Right(response.anotherUserSubResponse.userModel);
    } on DioError catch (e) {
      return Left(e.failure);
    } on NoInternetConnection catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, List<Phone>>> getMyOwnedPhones(int round) async {
    try {
      await _checkConnection();
      final response = await _remoteDataSource.getMyOwnedPhones(round);
      return Right(response.phonesModels);
    } on DioError catch (e) {
      return Left(e.failure);
    } on NoInternetConnection catch (e) {
      return Left(e.failure);
    }
  }

  Future<Either<Failure, List<Phone>>> getTheOwnedPhonesOfAnotherUser(
      String userId, int round) async {
    try {
      await _checkConnection();
      final response =
          await _remoteDataSource.getTheOwnedPhonesOfAnotherUser(userId, round);
      return Right(response.phonesModels);
    } on DioError catch (e) {
      return Left(e.failure);
    } on NoInternetConnection catch (e) {
      return Left(e.failure);
    }
  }
}
