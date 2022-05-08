import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/partial_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/vertical_list_error_widget.dart';

import '../widgets/error_widgets/fullscreen_error_widget.dart';

abstract class RequestState {}

abstract class InitialState {}

abstract class LoadingState {}

abstract class LoadedState {}

abstract class ErrorState {
  Failure get failure;
}

abstract class GeneralErrorWidget {
  set setOnRetry(VoidCallback func);
  set setRetryLastRequest(bool value);
}

abstract class InfiniteScrollingState<T> {
  List<T> get infiniteScrollingItems;
  bool get roundsEnded;
}

void showSnackBarWithoutActionAtError({
  required RequestState state,
  required BuildContext context,
}) {
  dynamic currentState = state;
  if (currentState is ErrorState) {
    ScaffoldMessenger.of(context).clearSnackBars();
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

/// A method that takes and returns the given loading widget when
/// the given state is [InitialState] or [LoadingState] and returns
/// null otherwise.
///
/// It also takes optionally an error widget an onRetry callback to be shown
/// in case of [ErrorState], if they are not passed, [PartialErrorWidget] is
/// shown with no retry button instead.
///
/// Default behavious if no error widgets are passed is used in widgets that
/// do not need to show error widgets as fullscreen error widget is shown
/// instead. While this is said, an error widget is returned so that we
/// return a widget at every state (initial, loading and error) and the one
/// that is remaining would be the loaded state and we would show the widget
/// itself containing the data in that state.
Widget? loadingOrErrorWidgetOrNull({
  required RequestState state,
  required Widget loadingWidget,
  Widget? errorWidget,
  VoidCallback? onRetry,
}) {
  assert(errorWidget == null || onRetry != null,
      'if errorWidget is not null, onRetry should be also not null');
  if (state is InitialState || state is LoadingState) {
    return loadingWidget;
  } else if (state is ErrorState) {
    if (errorWidget == null) {
      return PartialErrorWidget(
        onRetry: () {},
        retryLastRequest: false,
      );
    } else {
      return PartialErrorWidget(
        onRetry: onRetry!,
        retryLastRequest: (state as ErrorState).failure is RetryFailure,
      );
    }
  }
}

// Widget? erroWidgetOrNull({
//   required RequestState state,
//   required GeneralErrorWidget errorWidget,
//   required VoidCallback onRetry,
// }) {
//   assert(errorWidget is Widget);
//   if (state is! ErrorState) return null;
//   errorWidget.retryLastRequest = (state as ErrorState).failure is RetryFailure;
//   errorWidget.onRetry = onRetry;
//   return errorWidget as Widget;
// }

/// A method which takes a list of providers and list of callback functions.
/// For each provider, if it emitted an [ErrorState], a
/// [FullscreenErrorWidget] is returned with the corresponding callback to be
/// invoked by the button in the fullscreen error widget.
///
/// If no provider is emitting an [ErrorState] at the current moment, null is
/// returned.
Widget? fullScreenErrorWidgetOrNull(List<StateAndRetry> list,
    {bool retryOtherFailedRequests = true}) {
  for (var stateAndRetry in list) {
    if (stateAndRetry.controller?.itemList != null) {
      return null;
    }
    if (stateAndRetry.state is ErrorState) {
      return FullscreenErrorWidget(
        onRetry: () {
          if (retryOtherFailedRequests) {
            for (var sar in list) {
              if (sar.state is ErrorState) {
                sar.onRetry();
              }
            }
          } else {
            stateAndRetry.onRetry();
          }
        },
        retryLastRequest:
            (stateAndRetry.state as ErrorState).failure is RetryFailure,
      );
    }
  }
}

/// A provider and its corresponding callback function to be invoked by the
/// button of [FullscreenErrorWidget] that is shown as a result of [ErrorState]
/// emitted by that provider.
///
/// Used to pass parameters to the [WidgetRef] method
/// fullScreenErrorWidgetOrNull.
class StateAndRetry {
  RequestState state;
  VoidCallback onRetry;
  PagingController? controller;
  StateAndRetry({
    required this.state,
    required this.onRetry,
    this.controller,
  });
}

Widget fullscreenErrorWidget({
  required RequestState state,
  required VoidCallback onRetry,
  required PagingController? controller,
}) {
  if (state is ErrorState) {
    return FullscreenErrorWidget(
      onRetry: () {
        onRetry();
        controller?.retryLastFailedRequest();
      },
      retryLastRequest: (state as ErrorState).failure is RetryFailure,
    );
  } else {
    return SizedBox();
  }
}

Widget verticalListErrorWidget({
  required RequestState state,
  required VoidCallback onRetry,
  required PagingController? controller,
}) {
  if (state is ErrorState) {
    return VerticalListErrorWidget(
      onRetry: () {
        onRetry();
        controller?.retryLastFailedRequest();
      },
      retryLastRequest: (state as ErrorState).failure is RetryFailure,
    );
  } else {
    return SizedBox();
  }
}
