import 'package:equatable/equatable.dart';

class Info extends Equatable {
  final int views;
  final num generalRating;
  final num companyRating;
  final num uiRating;
  final num manufacturingQuality;
  final num valueForMoney;
  final num camera;
  final num callQuality;
  final num battery;
  const Info({
    required this.views,
    required this.generalRating,
    required this.companyRating,
    required this.uiRating,
    required this.manufacturingQuality,
    required this.valueForMoney,
    required this.camera,
    required this.callQuality,
    required this.battery,
  });

  @override
  List<Object?> get props => [];
}
