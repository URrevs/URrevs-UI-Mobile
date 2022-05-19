import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class GetPostState extends Equatable implements RequestState {}

class GetPostInitialState extends GetPostState implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetQuestionLoadingState extends GetPostState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetPostLoadedState extends GetPostState implements LoadedState {
  final Post post;
  GetPostLoadedState({
    required this.post,
  });

  @override
  List<Object?> get props => [];
}

class GetPostErrorState extends GetPostState implements ErrorState {
  @override
  final Failure failure;
  GetPostErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
