import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/domain/models/search_result.dart';

part 'search_api_requests.g.dart';

@JsonSerializable()
class AddNewRecentSearchRequest {
  String productId;
  SearchType type;
  AddNewRecentSearchRequest({
    required this.productId,
    required this.type,
  });

  factory AddNewRecentSearchRequest.fromJson(Map<String, Object?> json) =>
      _$AddNewRecentSearchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddNewRecentSearchRequestToJson(this);
}

class GetMyRecentSearchesRequest {}

@JsonSerializable()
class DeleteRecentSearchRequest {
  String id;
  DeleteRecentSearchRequest({
    required this.id,
  });

  factory DeleteRecentSearchRequest.fromJson(Map<String, Object?> json) =>
      _$DeleteRecentSearchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteRecentSearchRequestToJson(this);
}

class SearchProductsAndCompaiesRequest {}
