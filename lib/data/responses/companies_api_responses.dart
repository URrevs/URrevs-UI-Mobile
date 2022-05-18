import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/company_stats.dart';

import 'base_response.dart';

part 'companies_api_responses.g.dart';

@JsonSerializable()
class GetCompanyStatisticalInfoResponse extends BaseResponse {
  @JsonKey(name: 'stats')
  CompanyStatsSubResponse companyStatsSubResponse;
  GetCompanyStatisticalInfoResponse({
    required bool success,
    required this.companyStatsSubResponse,
  }) : super(success: success);

  CompanyStats get companyStatsModel =>
      companyStatsSubResponse.companyStatsModel;

  factory GetCompanyStatisticalInfoResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetCompanyStatisticalInfoResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetCompanyStatisticalInfoResponseToJson(this);
}

@JsonSerializable()
class GetAllCompaniesResponse extends BaseResponse {
  @JsonKey(name: 'companies')
  List<CompanyWithLogoSubResponse> companiesSubResponses;
  GetAllCompaniesResponse({
    required bool success,
    required this.companiesSubResponses,
  }) : super(success: success);

  List<Company> get companeisModels =>
      companiesSubResponses.map((c) => c.companyModel).toList();

  factory GetAllCompaniesResponse.fromJson(Map<String, Object?> json) =>
      _$GetAllCompaniesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllCompaniesResponseToJson(this);
}
