import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';

part 'phones_api_responses.g.dart';

@JsonSerializable()
class GetAllPhonesResponse extends BaseResponse {
  @JsonKey(name: 'phones')
  List<PhoneWithCompanyLogogSubResponse> phonesSubResponses;
  GetAllPhonesResponse({
    required bool success,
    required this.phonesSubResponses,
  }) : super(success: success);

  List<Phone> get phonesModels {
    return phonesSubResponses.map((p) => p.phoneModel).toList();
  }

  factory GetAllPhonesResponse.fromJson(Map<String, Object?> json) =>
      _$GetAllPhonesResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetAllPhonesResponseToJson(this);
}

@JsonSerializable()
class GetPhonesFromCertainCompanyResponse extends BaseResponse {
  @JsonKey(name: 'phones')
  List<PhoneWithCompanyLogogSubResponse> phonesSubResponses;
  GetPhonesFromCertainCompanyResponse({
    required bool success,
    required this.phonesSubResponses,
  }) : super(success: success);

  List<Phone> get phonesModels =>
      phonesSubResponses.map((p) => p.phoneModel).toList();

  factory GetPhonesFromCertainCompanyResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetPhonesFromCertainCompanyResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetPhonesFromCertainCompanyResponseToJson(this);
}

@JsonSerializable()
class GetPhoneManufacturingCompanyResponse extends BaseResponse {
  @JsonKey(name: 'company')
  CompanySubResponse companySubResponse;
  GetPhoneManufacturingCompanyResponse({
    required bool success,
    required this.companySubResponse,
  }) : super(success: success);

  factory GetPhoneManufacturingCompanyResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetPhoneManufacturingCompanyResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetPhoneManufacturingCompanyResponseToJson(this);
}

@JsonSerializable()
class GetPhoneSpecsResponse extends BaseResponse {
  @JsonKey(name: 'specs')
  SpecsSubResponse specsSubResponse;
  GetPhoneSpecsResponse({
    required bool success,
    required this.specsSubResponse,
  }) : super(success: success);

  factory GetPhoneSpecsResponse.fromJson(Map<String, Object?> json) =>
      _$GetPhoneSpecsResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetPhoneSpecsResponseToJson(this);
}

@JsonSerializable()
class GetPhoneStatisticalInfoResponse extends BaseResponse {
  @JsonKey(name: 'stats')
  PhoneStatsSubResponse infoSubResponse;
  GetPhoneStatisticalInfoResponse({
    required bool success,
    required this.infoSubResponse,
  }) : super(success: success);

  factory GetPhoneStatisticalInfoResponse.fromJson(Map<String, Object?> json) =>
      _$GetPhoneStatisticalInfoResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetPhoneStatisticalInfoResponseToJson(this);
}

@JsonSerializable()
class IndicateUserComparedBetweenTwoPhonesResponse extends BaseResponse {
  String status;
  IndicateUserComparedBetweenTwoPhonesResponse({
    required bool success,
    required this.status,
  }) : super(success: success);

  factory IndicateUserComparedBetweenTwoPhonesResponse.fromJson(
          Map<String, Object?> json) =>
      _$IndicateUserComparedBetweenTwoPhonesResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$IndicateUserComparedBetweenTwoPhonesResponseToJson(this);
}

@JsonSerializable()
class GetSimilarPhonesResponse extends BaseResponse {
  @JsonKey(name: 'phones')
  List<PhoneWithPictureSubResponse> phonesSubResponses;
  GetSimilarPhonesResponse({
    required bool success,
    required this.phonesSubResponses,
  }) : super(success: success);

  List<Phone> get phonesModels =>
      phonesSubResponses.map((p) => p.phoneModel).toList();

  factory GetSimilarPhonesResponse.fromJson(Map<String, Object?> json) =>
      _$GetSimilarPhonesResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetSimilarPhonesResponseToJson(this);
}
