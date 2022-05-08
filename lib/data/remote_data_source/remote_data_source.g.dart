// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RemoteDataSource implements RemoteDataSource {
  _RemoteDataSource(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://urrevs-api-dev-mobile.herokuapp.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AuthenticationResponse> authenticate(authorizationHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'authorization': authorizationHeader};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/users/authenticate',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GivePointsToUserResponse> givePointsToUser(authorizationHeader) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'authorization': authorizationHeader};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GivePointsToUserResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/users/login/mobile',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GivePointsToUserResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyProfileResponse> getMyProfile() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyProfileResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/users/profile',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyProfileResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetTheProfileOfAnotherUserResponse> getTheProfileOfAnotherUser(
      userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetTheProfileOfAnotherUserResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/users/${userId}/profile',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetTheProfileOfAnotherUserResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyOwnedPhonesResponse> getMyOwnedPhones(round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyOwnedPhonesResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/users/phones',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyOwnedPhonesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyOwnedPhonesResponse> getTheOwnedPhonesOfAnotherUser(
      userId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyOwnedPhonesResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/users/${userId}/phones',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyOwnedPhonesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateTargetFromSourceResponse> updateTargetsFromSource() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpdateTargetFromSourceResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/targets/update',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateTargetFromSourceResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetInfoAboutLatestUpdateResponse> getInfoAboutLatestUpdate() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetInfoAboutLatestUpdateResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/targets/update/latest',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetInfoAboutLatestUpdateResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddNewRecentSearchResponse> addNewRecentSearch(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddNewRecentSearchResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options, '/search/recent',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddNewRecentSearchResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyRecentSearchesResponse> getMyRecentSearches() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyRecentSearchesResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/search/recent',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyRecentSearchesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DeleteRecentSearchResponse> deleteRecentSearch(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeleteRecentSearchResponse>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, '/search/recent',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeleteRecentSearchResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SearchProductsAndCompaiesResponse> searchProductsAndCompanies(
      searchWord) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': searchWord};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchProductsAndCompaiesResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/search/all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchProductsAndCompaiesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllCompaniesResponse> getAllCompanies(round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllCompaniesResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/companies/all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllCompaniesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAllPhonesResponse> getAllPhones(round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAllPhonesResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/phones/all',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetAllPhonesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPhonesFromCertainCompanyResponse> getPhonesFromCertainCompany(
      companyId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPhonesFromCertainCompanyResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/phones/by/${companyId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetPhonesFromCertainCompanyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPhoneSpecsResponse> getPhoneSpecs(phoneId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPhoneSpecsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/phones/${phoneId}/specs',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetPhoneSpecsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPhoneStatisticalInfoResponse> getPhoneStatisticalInfo(
      phoneId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPhoneStatisticalInfoResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/phones/${phoneId}/stats',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetPhoneStatisticalInfoResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<IndicateUserComparedBetweenTwoPhonesResponse>
      indicateUserComparedBetweenTwoPhones(phoneId1, phoneId2) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<IndicateUserComparedBetweenTwoPhonesResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/phones/${phoneId1}/compare/${phoneId2}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        IndicateUserComparedBetweenTwoPhonesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetSimilarPhonesResponse> getSimilarPhones(phoneId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetSimilarPhonesResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/phones/${phoneId}/similar',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetSimilarPhonesResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPhoneReviewResponse> getPhoneReview(reviewId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPhoneReviewResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/phone/${reviewId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetPhoneReviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCompanyReviewResponse> getCompanyReview(reviewId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCompanyReviewResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/company/${reviewId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetCompanyReviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyPhoneReviewsResponse> getMyPhoneReviews(round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyPhoneReviewsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/phone/by/me',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyPhoneReviewsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPhoneReviewsOfAnotherUserResponse> getPhoneReviewsOfAnotherUser(
      userId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPhoneReviewsOfAnotherUserResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/phone/by/${userId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetPhoneReviewsOfAnotherUserResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyCompanyReviewsResponse> getMyCompanyReviews(round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyCompanyReviewsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/company/by/me',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyCompanyReviewsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCompanyReviewsOfAnotherUserResponse> getCompanyReviewsOfAnotherUser(
      userId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCompanyReviewsOfAnotherUserResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/company/by/${userId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        GetCompanyReviewsOfAnotherUserResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetReviewsOnCertainPhoneResponse> getReviewsOnCertainPhone(
      phoneId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetReviewsOnCertainPhoneResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/phone/on/${phoneId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetReviewsOnCertainPhoneResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LikePhoneReviewResponse> likePhoneReview(reviewId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LikePhoneReviewResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/phone/${reviewId}/like',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LikePhoneReviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UnlikePhoneReviewResponse> unlikePhoneReview(reviewId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UnlikePhoneReviewResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/phone/${reviewId}/unlike',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UnlikePhoneReviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LikeCompanyReviewResponse> likeCompanyReview(reviewId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LikeCompanyReviewResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/company/${reviewId}/like',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LikeCompanyReviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UnlikeCompanyReviewResponse> unlikeCompanyReview(reviewId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UnlikeCompanyReviewResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/company/${reviewId}/unlike',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UnlikeCompanyReviewResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
