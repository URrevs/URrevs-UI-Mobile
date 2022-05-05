import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';

part 'phones_api_responses.g.dart';

@JsonSerializable()
class GetAllPhonesResponse extends BaseResponse {
  @JsonKey(name: 'phones')
  List<PhoneSubResponse> phonesSubResponses;
  GetAllPhonesResponse({
    required bool success,
    required this.phonesSubResponses,
  }) : super(success: success);

  List<Phone> get phonesModels =>
      phonesSubResponses.map((p) => p.phoneModel).toList();

  factory GetAllPhonesResponse.fromJson(Map<String, Object?> json) =>
      _$GetAllPhonesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllPhonesResponseToJson(this);
}

@JsonSerializable()
class GetPhonesFromCertainCompanyResponse extends BaseResponse {
  @JsonKey(name: 'phones')
  List<PhoneWithCompanyIdAndNameSubResponse> phonesSubResponses;
  GetPhonesFromCertainCompanyResponse({
    required bool success,
    required this.phonesSubResponses,
  }) : super(success: success);

  List<Phone> get phonesModels =>
      phonesSubResponses.map((p) => p.phoneModel).toList();

  factory GetPhonesFromCertainCompanyResponse.fromJson(
          Map<String, Object?> json) =>
      _$GetPhonesFromCertainCompanyResponseFromJson(json);
  Map<String, dynamic> toJson() =>
      _$GetPhonesFromCertainCompanyResponseToJson(this);
}
