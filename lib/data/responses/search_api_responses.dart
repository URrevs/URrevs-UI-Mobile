import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/domain/models/search_result.dart';

part 'search_api_responses.g.dart';

@JsonSerializable()
class GetMyRecentSearchesResponse extends BaseResponse {
  @JsonKey(name: 'recent')
  List<RecentSearchSubResponse> recentSearchesSubResponses;
  GetMyRecentSearchesResponse({
    required bool success,
    required this.recentSearchesSubResponses,
  }) : super(success: success);

  List<SearchResult> get searchResults =>
      recentSearchesSubResponses.map((s) => s.searchResult).toList();

  factory GetMyRecentSearchesResponse.fromJson(Map<String, Object?> json) =>
      _$GetMyRecentSearchesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetMyRecentSearchesResponseToJson(this);
}

@JsonSerializable()
class AddNewRecentSearchResponse extends BaseResponse {
  String status;
  AddNewRecentSearchResponse({
    required bool success,
    required this.status,
  }) : super(success: success);

  factory AddNewRecentSearchResponse.fromJson(Map<String, Object?> json) =>
      _$AddNewRecentSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AddNewRecentSearchResponseToJson(this);
}

@JsonSerializable()
class DeleteRecentSearchResponse extends BaseResponse {
  String status;
  DeleteRecentSearchResponse({
    required bool success,
    required this.status,
  }) : super(success: success);

  factory DeleteRecentSearchResponse.fromJson(Map<String, Object?> json) =>
      _$DeleteRecentSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteRecentSearchResponseToJson(this);
}

@JsonSerializable()
class SearchProductsAndCompaiesResponse extends BaseResponse {
  @JsonKey(name: 'phones')
  List<PhoneSubResponse> phonesSubResponses;
  @JsonKey(name: 'companies')
  List<CompanySubResponse> companiesSubResponses;
  SearchProductsAndCompaiesResponse({
    required bool success,
    required this.phonesSubResponses,
    required this.companiesSubResponses,
  }) : super(success: success);

  List<Phone> get phonesModels =>
      phonesSubResponses.map((p) => p.phoneModel).toList();
  List<Company> get companiesModels =>
      companiesSubResponses.map((c) => c.companyModel).toList();

  factory SearchProductsAndCompaiesResponse.fromJson(
          Map<String, Object?> json) =>
      _$SearchProductsAndCompaiesResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SearchProductsAndCompaiesResponseToJson(this);
}
