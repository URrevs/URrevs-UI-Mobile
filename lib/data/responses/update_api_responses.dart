import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';

part 'update_api_responses.g.dart';

@JsonSerializable()
class UpdateTargetFromSourceResponse extends BaseResponse {
  String status;
  UpdateTargetFromSourceResponse({
    required bool success,
    required this.status,
  }) : super(success: success);

  factory UpdateTargetFromSourceResponse.fromJson(Map<String, Object?> json) =>
      _$UpdateTargetFromSourceResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$UpdateTargetFromSourceResponseToJson(this);
}

@JsonSerializable()
class GetInfoAboutLatestUpdateResponse extends BaseResponse {
  int numPhones;
  int numCompanies;
  @JsonKey(name: 'phones')
  List<PhoneSubResponse> phonesSubResponses;
  @JsonKey(name: 'companies')
  List<CompanySubResponse> companiesSubResponses;
  DateTime date;
  bool isUpdating;
  bool failed;
  bool automatic;

  List<Phone> get phonesModels =>
      phonesSubResponses.map((p) => p.phoneModel).toList();
  List<Company> get companiesModels =>
      companiesSubResponses.map((c) => c.companyModel).toList();

  GetInfoAboutLatestUpdateResponse({
    required bool success,
    required this.numPhones,
    required this.numCompanies,
    required this.phonesSubResponses,
    required this.companiesSubResponses,
    required this.date,
    required this.isUpdating,
    required this.failed,
    required this.automatic,
  }) : super(success: success);

  factory GetInfoAboutLatestUpdateResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetInfoAboutLatestUpdateResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() =>
      _$GetInfoAboutLatestUpdateResponseToJson(this);
}
