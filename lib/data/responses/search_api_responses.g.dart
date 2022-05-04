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

AddNewRecentSearchResponse _$AddNewRecentSearchResponseFromJson(
        Map<String, dynamic> json) =>
    AddNewRecentSearchResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$AddNewRecentSearchResponseToJson(
        AddNewRecentSearchResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

DeleteRecentSearchResponse _$DeleteRecentSearchResponseFromJson(
        Map<String, dynamic> json) =>
    DeleteRecentSearchResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$DeleteRecentSearchResponseToJson(
        DeleteRecentSearchResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

SearchProductsAndCompaiesResponse _$SearchProductsAndCompaiesResponseFromJson(
        Map<String, dynamic> json) =>
    SearchProductsAndCompaiesResponse(
      success: json['success'] as bool,
      phonesSubResponses: (json['phones'] as List<dynamic>)
          .map((e) => PhoneSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      companiesSubResponses: (json['companies'] as List<dynamic>)
          .map((e) => CompanySubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchProductsAndCompaiesResponseToJson(
        SearchProductsAndCompaiesResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'phones': instance.phonesSubResponses,
      'companies': instance.companiesSubResponses,
    };
