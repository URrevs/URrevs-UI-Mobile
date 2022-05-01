import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';

abstract class GetTheProfileOfAnotherUserState extends Equatable {}

class GetTheProfileOfAnotherUserInitialState
    extends GetTheProfileOfAnotherUserState {
  @override
  List<Object?> get props => [];
}

class GetTheProfileOfAnotherUserLoadingState
    extends GetTheProfileOfAnotherUserState {
  @override
  List<Object?> get props => [];
}

class GetTheProfileOfAnotherUserLoadedState
    extends GetTheProfileOfAnotherUserState {
  final User user;
  GetTheProfileOfAnotherUserLoadedState({
    required this.user,
  });
  @override
  List<Object?> get props => [user];
}

class GetTheProfileOfAnotherUserErrorState
    extends GetTheProfileOfAnotherUserState {
  final Failure failure;
  GetTheProfileOfAnotherUserErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
