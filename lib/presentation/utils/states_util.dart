import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';

abstract class RequestState {}

abstract class InitialState {}

abstract class LoadingState {}

abstract class LoadedState {}

abstract class ErrorState {
  Failure get failure;
}

void showSnackBarWithoutActionAtError({
  required RequestState state,
  required BuildContext context,
}) {
  dynamic currentState = state;
  if (currentState is ErrorState) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(currentState.failure.message)),
    );
    if (currentState.failure is AuthenticateFailure) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AuthenticationScreen.routeName,
        (route) => false,
      );
    }
  }
}
