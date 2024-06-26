import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';

import '../../../domain/models/user.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationInitialState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationLoadedState extends AuthenticationState {
  final User user;
  final String refCode;
  final bool admin;
  final bool requestedDelete;
  AuthenticationLoadedState({
    required this.user,
    required this.refCode,
    required this.admin,
    required this.requestedDelete,
  });
  @override
  List<Object?> get props => [];
}

class AuthenticationErrorState extends AuthenticationState {
  final Failure failure;
  AuthenticationErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
