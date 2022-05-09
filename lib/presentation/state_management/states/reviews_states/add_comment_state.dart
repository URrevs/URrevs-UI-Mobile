import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class AddCommentState extends Equatable implements RequestState {}

class AddCommentInitialState extends AddCommentState implements InitialState {
  @override
  List<Object?> get props => [];
}

class AddCommentLoadingState extends AddCommentState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class AddCommentLoadedState extends AddCommentState implements LoadedState {
  final String commentId;
  AddCommentLoadedState({
    required this.commentId,
  });

  @override
  List<Object?> get props => [];
}

class AddCommentErrorState extends AddCommentState implements ErrorState {
  @override
  final Failure failure;
  AddCommentErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
