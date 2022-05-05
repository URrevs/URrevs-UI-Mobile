import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';

import 'base_response.dart';

part 'companies_api_responses.g.dart';

@JsonSerializable()
class GetAllCompaniesResponse extends BaseResponse {
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
