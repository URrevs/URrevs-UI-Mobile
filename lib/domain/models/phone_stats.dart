import 'package:equatable/equatable.dart';

class PhoneStats extends Equatable {
  final int views;
  final double generalRating;
  final double companyRating;
  final int uiRating;
  final int manufacturingQuality;
  final int valueForMoney;
  final int camera;
  final int callQuality;
  final int battery;
  final bool owned;
  final double verificationRatio;
  const PhoneStats({
    required this.views,
    required this.generalRating,
    required this.companyRating,
    required this.uiRating,
    required this.manufacturingQuality,
    required this.valueForMoney,
    required this.camera,
    required this.callQuality,
    required this.battery,
    required this.owned,
    required this.verificationRatio,
  });

  @override
  List<Object?> get props => [];

  PhoneStats copyWith({
    int? views,
    double? generalRating,
    double? companyRating,
    int? uiRating,
    int? manufacturingQuality,
    int? valueForMoney,
    int? camera,
    int? callQuality,
    int? battery,
    bool? owned,
    double? verificationRatio,
  }) {
    return PhoneStats(
      views: views ?? this.views,
      generalRating: generalRating ?? this.generalRating,
      companyRating: companyRating ?? this.companyRating,
      uiRating: uiRating ?? this.uiRating,
      manufacturingQuality: manufacturingQuality ?? this.manufacturingQuality,
      valueForMoney: valueForMoney ?? this.valueForMoney,
      camera: camera ?? this.camera,
      callQuality: callQuality ?? this.callQuality,
      battery: battery ?? this.battery,
      owned: owned ?? this.owned,
      verificationRatio: verificationRatio ?? this.verificationRatio,
    );
  }
}
