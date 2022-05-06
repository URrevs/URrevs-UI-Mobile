import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class IndicateUserComparedBetweenTwoPhonesState extends Equatable
    implements RequestState {}

class IndicateUserComparedBetweenTwoPhonesInitialState
    extends IndicateUserComparedBetweenTwoPhonesState implements InitialState {
  @override
  List<Object?> get props => [];
}

class IndicateUserComparedBetweenTwoPhonesLoadingState
    extends IndicateUserComparedBetweenTwoPhonesState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class IndicateUserComparedBetweenTwoPhonesLoadedState
    extends IndicateUserComparedBetweenTwoPhonesState implements LoadedState {
  @override
  List<Object?> get props => [];
}

class IndicateUserComparedBetweenTwoPhonesErrorState
    extends IndicateUserComparedBetweenTwoPhonesState implements ErrorState {
  @override
  final Failure failure;
  IndicateUserComparedBetweenTwoPhonesErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
