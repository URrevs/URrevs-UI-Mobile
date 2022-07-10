import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetOwnedPhonesState extends Equatable implements RequestState {}

class GetOwnedPhonesInitialState extends GetOwnedPhonesState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetOwnedPhonesLoadingState extends GetOwnedPhonesState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetOwnedPhonesLoadedState extends GetOwnedPhonesState
    implements InfiniteScrollingState<Phone>, LoadedState {
  @override
  final List<Phone> infiniteScrollingItems;
  @override
  final bool roundsEnded;
  GetOwnedPhonesLoadedState({
    required this.infiniteScrollingItems,
    this.roundsEnded = false,
  });
  @override
  List<Object?> get props => [];

  @override
  String toString() =>
      'GetMyOwnedPhonesLoadedState(phones: $infiniteScrollingItems, roundsEnded: $roundsEnded)';
}

class GetOwnedPhonesErrorState extends GetOwnedPhonesState
    implements ErrorState {
  @override
  final Failure failure;
  GetOwnedPhonesErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
