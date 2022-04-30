import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:urrevs_ui_mobile/data/responses/users_api_response.dart';

part 'remote_data_source.g.dart';

@RestApi(baseUrl: 'https://urrevs-api-dev-mobile.herokuapp.com')
abstract class RemoteDataSource {
  factory RemoteDataSource(Dio dio, {String baseUrl}) = _RemoteDataSource;

  @GET('/users/authenticate')
  Future<AuthenticationResponse> authenticate(
    @Header('authorization') String authorizationHeader,
  );

  @GET('/users/profile')
  Future<GetMyProfileResponse> getMyProfile();
}
