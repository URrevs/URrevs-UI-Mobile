import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetReportContextState extends Equatable implements RequestState {
}

class GetReportContextInitialState extends GetReportContextState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetReportContextLoadingState extends GetReportContextState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetReportContextLoadedState extends GetReportContextState
    implements LoadedState {
  final Post post;
  final DirectInteraction directInteraction;

  GetReportContextLoadedState({
    required this.post,
    required this.directInteraction,
  });
  @override
  List<Object?> get props => [];
}

class GetReportContextErrorState extends GetReportContextState
    implements ErrorState {
  @override
  final Failure failure;
  GetReportContextErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
