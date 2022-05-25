import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/bottom_navigation_bar_container_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel/subscreens.dart/update_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_info_about_latest_update_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/leaderboard_states/get_lastest_competition_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/admin_panel_tile_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/adding_competition_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AdminPanelScreen extends ConsumerStatefulWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  static const String routeName = 'AdminPanelScreen';

  @override
  ConsumerState<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen> {
  final GetInfoAboutLatestUpdateProviderParams _updateProviderParams =
      GetInfoAboutLatestUpdateProviderParams();
  final GetLatestCompetitionProviderParams _competitionProviderParams =
      GetLatestCompetitionProviderParams();

  void _getInfoAboutLatestUpdate() {
    ref
        .read(getInfoAboutLatestUpdateProvider(_updateProviderParams).notifier)
        .getInfoAboutLatestUpdate();
  }

  void _getLatestCompetion() {
    ref
        .read(getLatestCompetitionProvider(_competitionProviderParams).notifier)
        .getLatestCompetition();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getInfoAboutLatestUpdate();
      _getLatestCompetion();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: getInfoAboutLatestUpdateProvider(_updateProviderParams),
      context: context,
    );
    ref.addErrorListener(
      provider: getLatestCompetitionProvider(_competitionProviderParams),
      context: context,
    );
    return RefreshIndicator(
      onRefresh: () async {
        _getInfoAboutLatestUpdate();
        _getLatestCompetion();
      },
      child: Scaffold(
        appBar: AppBars.appBarWithTitle(
          context: context,
          title: LocaleKeys.adminPanel.tr(),
        ),
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: NoGlowingScrollBehaviour(),
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    final updateState =
        ref.watch(getInfoAboutLatestUpdateProvider(_updateProviderParams));
    final competitionState =
        ref.watch(getLatestCompetitionProvider(_competitionProviderParams));
    final fullErr = fullScreenErrorWidgetOrNull([
      StateAndRetry(state: updateState, onRetry: _getInfoAboutLatestUpdate),
      StateAndRetry(state: competitionState, onRetry: _getLatestCompetion),
    ]);
    if (fullErr != null) return fullErr;

    return ListView(
      children: [
        _buildUpdateTile(),
        _buildCompetitionTile(),
      ],
    );
  }

  Widget _buildCompetitionTile() {
    final competitionState =
        ref.watch(getLatestCompetitionProvider(_competitionProviderParams));
    final loadOrErr = loadingOrErrorWidgetOrNull(
      state: competitionState,
      loadingWidget: AdminPanelTileLoading(),
    );
    if (loadOrErr != null) return loadOrErr;

    bool disabled;
    String text;

    if (competitionState is GetLatestCompetitionNoResultState) {
      disabled = false;
      text = LocaleKeys.noCompetitionsYet.tr();
    } else {
      final competition =
          (competitionState as GetLatestCompetitionLoadedState).competition;
      final String lastCompDate = DateFormat.yMMMMd(context.locale.languageCode)
          .format(competition.deadline);
      disabled = competition.deadline.isAfter(DateTime.now());
      text = disabled
          ? LocaleKeys.thereIsAnActiveCompetition.tr()
          : LocaleKeys.theLastCompetitionTookPlaceIn.tr() + lastCompDate;
    }

    return ItemTile(
      title: LocaleKeys.addACompetition.tr(),
      subtitle: text,
      iconData: Icons.update,
      onTap: () {
        if (!disabled) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddingCompetitionDialog();
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                LocaleKeys.youCannotAddACompetitionWhileThereIsARunningOne.tr(),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildUpdateTile() {
    final updateState =
        ref.watch(getInfoAboutLatestUpdateProvider(_updateProviderParams));
    final loadOrErr = loadingOrErrorWidgetOrNull(
      state: updateState,
      loadingWidget: AdminPanelTileLoading(),
    );
    if (loadOrErr != null) return loadOrErr;
    String? updateCompletedDate;
    if (updateState is GetInfoAboutLatestUpdateLoadedState) {
      updateCompletedDate = DateFormat.yMMMMd(context.locale.languageCode)
          .format(updateState.date);
    }
    String lastUpdateStr = updateCompletedDate == null
        ? LocaleKeys.noUpdateOperationsYet.tr()
        : LocaleKeys.lastUpdatedIn.tr() + ' ' + updateCompletedDate;
    return ItemTile(
      title: LocaleKeys.updateProductsList.tr(),
      subtitle: lastUpdateStr,
      iconData: Icons.emoji_events,
      onTap: () {
        Navigator.of(context).pushNamed(
          UpdateProductsScreen.routeName,
        );
      },
    );
  }
}
