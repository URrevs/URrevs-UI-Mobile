// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewRecentSearchRequest _$AddNewRecentSearchRequestFromJson(
        Map<String, dynamic> json) =>
    AddNewRecentSearchRequest(
      id: json['_id'] as String,
      type: $enumDecode(_$SearchTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$AddNewRecentSearchRequestToJson(
        AddNewRecentSearchRequest instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': _$SearchTypeEnumMap[instance.type],
    };

const _$SearchTypeEnumMap = {
  SearchType.phone: 'phone',
  SearchType.company: 'company',
};

DeleteRecentSearchRequest _$DeleteRecentSearchRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteRecentSearchRequest(
      id: json['_id'] as String,
    );

Map<String, dynamic> _$DeleteRecentSearchRequestToJson(
        DeleteRecentSearchRequest instance) =>
    <String, dynamic>{
      '_id': instance.id,
    };
