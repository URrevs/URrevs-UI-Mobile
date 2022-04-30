import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/user.dart';

abstract class GetMyProfileState extends Equatable {}

class GetMyProfileInitialState extends GetMyProfileState {
  @override
  List<Object?> get props => [];
}

class GetMyProfileLoadingState extends GetMyProfileState {
  @override
  List<Object?> get props => [];
}

class GetMyProfileLoadedState extends GetMyProfileState {
  final User user;
  final String refCode;
  GetMyProfileLoadedState({
    required this.user,
    required this.refCode,
  });
  @override
  List<Object?> get props => [];
}

class GetMyProfileErrorState extends GetMyProfileState {
  final Failure failure;
  GetMyProfileErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}
