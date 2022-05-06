import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetAllPhonesState extends Equatable implements RequestState {}

class GetAllPhonesInitialState extends GetAllPhonesState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetAllPhonesLoadingState extends GetAllPhonesState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetAllPhonesLoadedState extends GetAllPhonesState
    implements LoadedState, InfiniteScrollingState<Phone> {
  @override
  final List<Phone> infiniteScrollingItems;
  @override
  final bool roundsEnded;
  GetAllPhonesLoadedState({
    required this.infiniteScrollingItems,
    required this.roundsEnded,
  });
  @override
  List<Object?> get props => [];

  @override
  String toString() {
    return 'GetAllPhonesLoadedState(infiniteScrollingItems: $infiniteScrollingItems, roundsEnded: $roundsEnded)';
  }
}

class GetAllPhonesErrorState extends GetAllPhonesState implements ErrorState {
  @override
  final Failure failure;
  GetAllPhonesErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
