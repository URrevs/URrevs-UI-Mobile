import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class AddReviewReplyState extends Equatable implements RequestState {}

class AddReviewReplyInitialState extends AddReviewReplyState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class AddReviewReplyLoadingState extends AddReviewReplyState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class AddReviewReplyLoadedState extends AddReviewReplyState
    implements LoadedState {
  final String replyId;

  AddReviewReplyLoadedState({required this.replyId});
  @override
  List<Object?> get props => [];
}

class AddReviewReplyErrorState extends AddReviewReplyState
    implements ErrorState {
  @override
  final Failure failure;
  AddReviewReplyErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
