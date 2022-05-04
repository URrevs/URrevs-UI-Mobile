import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
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
