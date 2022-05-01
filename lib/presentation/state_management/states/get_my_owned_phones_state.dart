import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';

abstract class GetMyOwnedPhonesState extends Equatable {}

class GetMyOwnedPhonesInitialState extends GetMyOwnedPhonesState {
  @override
  List<Object?> get props => [];
}

class GetMyOwnedPhonesLoadingState extends GetMyOwnedPhonesState {
  @override
  List<Object?> get props => [];
}

class GetMyOwnedPhonesLoadedState extends GetMyOwnedPhonesState {
  final List<Phone> phones;
  final bool roundsEnded;
  GetMyOwnedPhonesLoadedState({
    required this.phones,
    this.roundsEnded = false,
  });
  @override
  List<Object?> get props => [];

  @override
  String toString() =>
      'GetMyOwnedPhonesLoadedState(phones: $phones, roundsEnded: $roundsEnded)';
}

class GetMyOwnedPhonesErrorState extends GetMyOwnedPhonesState {
  final Failure failure;
  GetMyOwnedPhonesErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
