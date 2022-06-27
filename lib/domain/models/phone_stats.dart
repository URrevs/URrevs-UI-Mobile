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
  });

  @override
  List<Object?> get props => [];
}
