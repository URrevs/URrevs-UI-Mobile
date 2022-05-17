import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';

abstract class GetOwnedPhonesState extends Equatable {}

class GetOwnedPhonesInitialState extends GetOwnedPhonesState {
  @override
  List<Object?> get props => [];
}

class GetOwnedPhonesLoadingState extends GetOwnedPhonesState {
  @override
  List<Object?> get props => [];
}

class GetOwnedPhonesLoadedState extends GetOwnedPhonesState {
  final List<Phone> phones;
  final bool roundsEnded;
  GetOwnedPhonesLoadedState({
    required this.phones,
    this.roundsEnded = false,
  });
  @override
  List<Object?> get props => [];

  @override
  String toString() =>
      'GetMyOwnedPhonesLoadedState(phones: $phones, roundsEnded: $roundsEnded)';
}

class GetOwnedPhonesErrorState extends GetOwnedPhonesState {
  final Failure failure;
  GetOwnedPhonesErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
