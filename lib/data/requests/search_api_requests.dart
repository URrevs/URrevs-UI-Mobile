import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/domain/models/search_result.dart';

part 'search_api_requests.g.dart';

@JsonSerializable()
class AddNewRecentSearchRequest {
  @JsonKey(name: '_id')
  String id;
  SearchType type;
  AddNewRecentSearchRequest({
    required this.id,
    required this.type,
  });

  factory AddNewRecentSearchRequest.fromJson(Map<String, Object?> json) =>
      _$AddNewRecentSearchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddNewRecentSearchRequestToJson(this);
}

class GetMyRecentSearchesRequest {}

@JsonSerializable()
class DeleteRecentSearchRequest {
  @JsonKey(name: '_id')
  String id;
  DeleteRecentSearchRequest({
    required this.id,
  });

  factory DeleteRecentSearchRequest.fromJson(Map<String, Object?> json) =>
      _$DeleteRecentSearchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteRecentSearchRequestToJson(this);
}

class SearchProductsAndCompaiesRequest {}
