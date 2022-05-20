import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

abstract class AddQuestionState extends Equatable implements RequestState {}

class AddQuestionInitialState extends AddQuestionState implements InitialState {
  @override
  List<Object?> get props => [];
}

class AddQuestionLoadingState extends AddQuestionState implements LoadingState {
  @override
  List<Object?> get props => [];
}

class AddQuestionLoadedState extends AddQuestionState implements LoadedState {
  final Question question;
  AddQuestionLoadedState({
    required this.question,
  });

  @override
  List<Object?> get props => [];
}

class AddQuestionErrorState extends AddQuestionState implements ErrorState {
  @override
  final Failure failure;
  AddQuestionErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
