import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel/subscreens.dart/update_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_info_about_latest_update_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/admin_panel_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AdminPanelScreen extends ConsumerStatefulWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  static const String routeName = 'AdminPanelScreen';

  @override
  ConsumerState<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen> {
  final GetInfoAboutLatestUpdateProviderParams _providerParams =
      GetInfoAboutLatestUpdateProviderParams();

  void _getInfoAboutLatestUpdate() {
    ref
        .read(getInfoAboutLatestUpdateProvider(_providerParams).notifier)
        .getInfoAboutLatestUpdate();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _getInfoAboutLatestUpdate);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<GetInfoAboutLatestUpdateState>(
        getInfoAboutLatestUpdateProvider(_providerParams), (previous, next) {
      showSnackBarWithoutActionAtError(state: next, context: context);
    });

    return RefreshIndicator(
      onRefresh: () async {
        _getInfoAboutLatestUpdate();
      },
      child: Scaffold(
        appBar: AppBars.appBarWithTitle(
          context: context,
          title: LocaleKeys.adminPanel.tr(),
        ),
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: NoGlowingScrollBehaviour(),
            child: _buildBody(context),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final state = ref.watch(getInfoAboutLatestUpdateProvider(_providerParams));
    if (state is GetInfoAboutLatestUpdateLoadingState ||
        state is GetInfoAboutLatestUpdateInitialState) {
      return AdminPanelLoading();
    } else if (state is GetInfoAboutLatestUpdateErrorState) {
      return FullscreenErrorWidget(
        onRetry: _getInfoAboutLatestUpdate,
        retryLastRequest: state.failure is RetryFailure,
      );
    } else {
      final loadedState = state as GetInfoAboutLatestUpdateLoadedState;
      final String updateCompletedDate =
          DateFormat.yMMMMd(context.locale.languageCode)
              .format(loadedState.date);
      return ListView(
        children: [
          ItemTile(
            title: LocaleKeys.updateProductsList.tr(),
            subtitle: LocaleKeys.lastUpdatedIn.tr() + ' ' + updateCompletedDate,
            iconData: Icons.emoji_events,
            onTap: () {
              Navigator.of(context).pushNamed(
                UpdateProductsScreen.routeName,
              );
            },
          ),
          ItemTile(
            title: LocaleKeys.addACompetition.tr(),
            subtitle: 'آخر مسابقة تمت في 20 أغسطس 2020',
            iconData: Icons.update,
            onTap: () {},
          ),
        ],
      );
    }
  }
}
