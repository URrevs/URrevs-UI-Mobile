import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:urrevs_ui_mobile/data/remote_data_source/remote_data_source.dart';
import 'package:urrevs_ui_mobile/data/responses/users_api_response.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';

class Repository {
  final RemoteDataSource _remoteDataSource;
  Repository({
    required RemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  Future<Either<Failure, void>> authenticateWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

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
          'Bearer ${response.token}';

      print(response);

      return Right(null);
    } on DioError catch (e) {
      return Left(e.failure);
    }
  }
}
