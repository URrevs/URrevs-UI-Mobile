import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

abstract class GetInfoAboutLatestUpdateState extends Equatable
    implements RequestState {}

class GetInfoAboutLatestUpdateInitialState extends GetInfoAboutLatestUpdateState
    implements InitialState {
  @override
  List<Object?> get props => [];
}

class GetInfoAboutLatestUpdateLoadingState extends GetInfoAboutLatestUpdateState
    implements LoadingState {
  @override
  List<Object?> get props => [];
}

class GetInfoAboutLatestUpdateLoadedState extends GetInfoAboutLatestUpdateState
    implements LoadedState {
  final List<Phone> phones;
  final List<Company> companies;
  final DateTime date;
  final bool isUpdating;
  final bool failed;
  final bool automatic;

  GetInfoAboutLatestUpdateLoadedState({
    required this.phones,
    required this.companies,
    required this.date,
    required this.isUpdating,
    required this.failed,
    required this.automatic,
  });

  String get updateStatus {
    if (isUpdating) {
      return LocaleKeys.updating.tr();
    } else if (failed) {
      return LocaleKeys.updateHasNotBeenCompleted.tr();
    } else {
      return LocaleKeys.successfullyCompleted.tr();
    }
  }

  String get updateMethod =>
      automatic ? LocaleKeys.automatically.tr() : LocaleKeys.manually.tr();

  @override
  List<Object?> get props => [];
}

class GetInfoAboutLatestUpdateNoUpdateState
    extends GetInfoAboutLatestUpdateState {
  GetInfoAboutLatestUpdateNoUpdateState();

  @override
  List<Object?> get props => [];
}

class GetInfoAboutLatestUpdateErrorState extends GetInfoAboutLatestUpdateState
    implements ErrorState {
  @override
  final Failure failure;
  GetInfoAboutLatestUpdateErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
