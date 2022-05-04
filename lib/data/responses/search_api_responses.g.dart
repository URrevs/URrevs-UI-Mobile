// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMyRecentSearchesResponse _$GetMyRecentSearchesResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyRecentSearchesResponse(
      success: json['success'] as bool,
      recentSearchesSubResponses: (json['recent'] as List<dynamic>)
          .map((e) =>
              RecentSearchSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyRecentSearchesResponseToJson(
        GetMyRecentSearchesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'recent': instance.recentSearchesSubResponses,
    };
