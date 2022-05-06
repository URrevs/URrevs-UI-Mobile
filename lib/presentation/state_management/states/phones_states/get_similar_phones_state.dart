import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetSimilarPhonesState extends Equatable implements RequestState {
}

class GetSimilarPhonesInitialState extends GetSimilarPhonesState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetSimilarPhonesLoadingState extends GetSimilarPhonesState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetSimilarPhonesLoadedState extends GetSimilarPhonesState
    implements LoadedState {
  final List<Phone> phones;

  GetSimilarPhonesLoadedState({required this.phones});
  @override
  List<Object?> get props => [];
}

class GetSimilarPhonesErrorState extends GetSimilarPhonesState
    implements ErrorState {
  @override
  final Failure failure;
  GetSimilarPhonesErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
