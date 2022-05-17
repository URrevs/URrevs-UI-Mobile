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
  Future<GivePointsToUserResponse> givePointsToUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
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
  Future<SearchPhonesResponse> searchPhones(searchWord) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': searchWord};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchPhonesResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/search/products/phones',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchPhonesResponse.fromJson(_result.data!);
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
  Future<GetPhoneManufacturingCompanyResponse> getPhoneManufacturingCompany(
      phoneId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPhoneManufacturingCompanyResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/phones/${phoneId}/company',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetPhoneManufacturingCompanyResponse.fromJson(_result.data!);
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
  Future<AddPhoneReviewResponse> addPhoneReview(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddPhoneReviewResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/phone',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddPhoneReviewResponse.fromJson(_result.data!);
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

  @override
  Future<GetCommentsAndRepliesForPhoneReviewResponse>
      getCommentsAndRepliesForPhoneReview(reviewId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCommentsAndRepliesForPhoneReviewResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/phone/${reviewId}/comments',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        GetCommentsAndRepliesForPhoneReviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCommentsAndRepliesForCompanyReviewResponse>
      getCommentsAndRepliesForCompanyReview(reviewId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCommentsAndRepliesForCompanyReviewResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/company/${reviewId}/comments',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        GetCommentsAndRepliesForCompanyReviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddCommentToPhoneReviewResponse> addCommentToPhoneReview(
      reviewId, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddCommentToPhoneReviewResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/phone/${reviewId}/comments',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddCommentToPhoneReviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddCommentToCompanyReviewResponse> addCommentToCompanyReview(
      reviewId, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddCommentToCompanyReviewResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/reviews/company/${reviewId}/comments',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddCommentToCompanyReviewResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddReplyToPhoneReviewCommentResponse> addReplyToPhoneReviewComment(
      commentId, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddReplyToPhoneReviewCommentResponse>(Options(
                method: 'POST', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/reviews/phone/comments/${commentId}/replies',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddReplyToPhoneReviewCommentResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddReplyToCompanyReviewCommentResponse> addReplyToCompanyReviewComment(
      commentId, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddReplyToCompanyReviewCommentResponse>(Options(
                method: 'POST', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/reviews/company/comments/${commentId}/replies',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        AddReplyToCompanyReviewCommentResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LikePhoneReviewCommentResponse> likePhoneReviewComment(
      commentId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LikePhoneReviewCommentResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/reviews/phone/comments/${commentId}/like',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LikePhoneReviewCommentResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UnlikePhoneReviewCommentResponse> unlikePhoneReviewComment(
      commentId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UnlikePhoneReviewCommentResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/reviews/phone/comments/${commentId}/unlike',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UnlikePhoneReviewCommentResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LikeCompanyReviewCommentResponse> likeCompanyReviewComment(
      commentId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LikeCompanyReviewCommentResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/reviews/company/comments/${commentId}/like',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LikeCompanyReviewCommentResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UnlikeCompanyReviewCommentResponse> unlikeCompanyReviewComment(
      commentId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UnlikeCompanyReviewCommentResponse>(Options(
                method: 'POST', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/reviews/company/comments/${commentId}/unlike',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UnlikeCompanyReviewCommentResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LikePhoneReviewReplyResponse> likePhoneReviewReply(
      commentId, replyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LikePhoneReviewReplyResponse>(Options(
                method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options,
                '/reviews/phone/comments/${commentId}/replies/${replyId}/like',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LikePhoneReviewReplyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UnlikePhoneReviewReplyResponse> unlikePhoneReviewReply(
      commentId, replyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        UnlikePhoneReviewReplyResponse>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/reviews/phone/comments/${commentId}/replies/${replyId}/unlike',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UnlikePhoneReviewReplyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LikeCompanyReviewReplyResponse> likeCompanyReviewReply(
      commentId, replyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        LikeCompanyReviewReplyResponse>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/reviews/company/comments/${commentId}/replies/${replyId}/like',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LikeCompanyReviewReplyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UnlikeCompanyReviewReplyResponse> unlikeCompanyReviewReply(
      commentId, replyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        UnlikeCompanyReviewReplyResponse>(Options(
            method: 'POST', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/reviews/company/comments/${commentId}/replies/${replyId}/unlike',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UnlikeCompanyReviewReplyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPhoneQuestionResponse> getPhoneQuestion(questionId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPhoneQuestionResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/questions/phone/${questionId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetPhoneQuestionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPhoneQuestionResponse> getCompanyQuestion(questionId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPhoneQuestionResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/questions/company/${questionId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetPhoneQuestionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyPhoneQuestionsResponse> getMyPhoneQuestions(round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyPhoneQuestionsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/questions/phone/my',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyPhoneQuestionsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyCompanyQuestionsResponse> getMyCompanyQuestions(round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyCompanyQuestionsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/questions/company/my',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyCompanyQuestionsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetPhoneQuestionsOfAnotherUser> getPhoneQuestionsOfAnotherUser(
      userId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetPhoneQuestionsOfAnotherUser>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/questions/phone/${userId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetPhoneQuestionsOfAnotherUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetCompanyQuestionsOfAnotherUser> getCompanyQuestionsOfAnotherUser(
      userId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetCompanyQuestionsOfAnotherUser>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/questions/company/${userId}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetCompanyQuestionsOfAnotherUser.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpvotePhoneQuestionResponse> upvotePhoneQuestion(questionId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpvotePhoneQuestionResponse>(Options(
                method: 'PUT', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/questions/phone/${questionId}?action=upvote',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpvotePhoneQuestionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DownvotePhoneQuestionResponse> downvotePhoneQuestion(
      questionId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DownvotePhoneQuestionResponse>(Options(
                method: 'PUT', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/questions/phone/${questionId}?action=downvote',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DownvotePhoneQuestionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpvoteCompanyQuestionResponse> upvoteCompanyQuestion(
      questionId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UpvoteCompanyQuestionResponse>(Options(
                method: 'PUT', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/questions/company/${questionId}?action=upvote',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpvoteCompanyQuestionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DownvoteCompanyQuestionResponse> downvoteCompanyQuestion(
      questionId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DownvoteCompanyQuestionResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/questions/company/${questionId}?action=downvote',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DownvoteCompanyQuestionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAnswersAndRepliesForPhoneQuestionResponse>
      getAnswersAndRepliesForPhoneQuestion(questionId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAnswersAndRepliesForPhoneQuestionResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/questions/phone/${questionId}/answers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        GetAnswersAndRepliesForPhoneQuestionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetAnswersAndRepliesForCompanyQuestionResponse>
      getAnswersAndRepliesForCompanyQuestion(questionId, round) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'round': round};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetAnswersAndRepliesForCompanyQuestionResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/questions/company/${questionId}/answers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        GetAnswersAndRepliesForCompanyQuestionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddAnswerToPhoneQuestionResponse> addAnswerToPhoneQuestion(
      questionId, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddAnswerToPhoneQuestionResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/questions/phone/${questionId}/answers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddAnswerToPhoneQuestionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddAnswerToCompanyQuestionResponse> addAnswerToCompanyQuestion(
      questionId, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddAnswerToCompanyQuestionResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/questions/company/${questionId}/answers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddAnswerToCompanyQuestionResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddReplyToPhoneQuestionAnswerResponse> addReplyToPhoneQuestionAnswer(
      answerId, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddReplyToPhoneQuestionAnswerResponse>(Options(
                method: 'POST', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/questions/phone/answers/${answerId}/replies',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddReplyToPhoneQuestionAnswerResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddReplyToCompanyQuestionAnswerResponse>
      addReplyToCompanyQuestionAnswer(answerId, request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddReplyToCompanyQuestionAnswerResponse>(Options(
                method: 'POST', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '/questions/company/answers/${answerId}/replies',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        AddReplyToCompanyQuestionAnswerResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StatusResponse> upvotePhoneQuestionAnswer(answerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StatusResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/questions/phone/answers/${answerId}?action=upvote',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StatusResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StatusResponse> downvotePhoneQuestionAnswer(answerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StatusResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/questions/phone/answers/${answerId}?action=downvote',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StatusResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StatusResponse> upvoteCompanyQuestionAnswer(answerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StatusResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/questions/company/answers/${answerId}?action=upvote',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StatusResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StatusResponse> downvoteCompanyQuestionAnswer(answerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<StatusResponse>(
            Options(method: 'PUT', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    '/questions/phone/answers/${answerId}?action=downvote',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StatusResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StatusResponse> likePhoneQuestionReply(answerId, replyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        StatusResponse>(Options(
            method: 'PUT', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/questions/phone/answers/${answerId}/replies/${replyId}?action=like',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StatusResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StatusResponse> unlikePhoneQuestionReply(answerId, replyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        StatusResponse>(Options(
            method: 'PUT', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/questions/phone/answers/${answerId}/replies/${replyId}?action=unlike',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StatusResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StatusResponse> likeCompanyQuestionReply(answerId, replyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        StatusResponse>(Options(
            method: 'PUT', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/questions/company/answers/${answerId}/replies/${replyId}?action=like',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StatusResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StatusResponse> unlikeCompanyQuestionReply(answerId, replyId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        StatusResponse>(Options(
            method: 'PUT', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/questions/company/answers/${answerId}/replies/${replyId}?action=unlike',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = StatusResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MarkAnswerAsAcceptedForPhoneResponse> markAnswerAsAcceptedForPhone(
      questionId, answerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        MarkAnswerAsAcceptedForPhoneResponse>(Options(
            method: 'PUT', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/questions/phone/${questionId}/answers/${answerId}?action=accept',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = MarkAnswerAsAcceptedForPhoneResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<MarkAnswerAsAcceptedForCompanyResponse> markAnswerAsAcceptedForCompany(
      questionId, answerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        MarkAnswerAsAcceptedForCompanyResponse>(Options(
            method: 'PUT', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/questions/company/${questionId}/answers/${answerId}?action=accept',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        MarkAnswerAsAcceptedForCompanyResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UnmarkAnswerAsAcceptedForPhoneResponse> unmarkAnswerAsAcceptedForPhone(
      questionId, answerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        UnmarkAnswerAsAcceptedForPhoneResponse>(Options(
            method: 'PUT', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/questions/phone/${questionId}/answers/${answerId}?action=reject',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        UnmarkAnswerAsAcceptedForPhoneResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UnmarkAnswerAsAcceptedForCompanyResponse>
      unmarkAnswerAsAcceptedForCompany(questionId, answerId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<
        UnmarkAnswerAsAcceptedForCompanyResponse>(Options(
            method: 'PUT', headers: _headers, extra: _extra)
        .compose(_dio.options,
            '/questions/company/${questionId}/answers/${answerId}?action=reject',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        UnmarkAnswerAsAcceptedForCompanyResponse.fromJson(_result.data!);
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
