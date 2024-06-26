import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';
import 'package:urrevs_ui_mobile/domain/models/company.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_info_about_latest_update_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/update_targets_from_source_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/no_updates_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/update_products_expansion_card_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/updated_list_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class UpdateProductsScreen extends ConsumerStatefulWidget {
  const UpdateProductsScreen({Key? key}) : super(key: key);

  static const String routeName = 'UpdateProductsScreen';

  @override
  ConsumerState<UpdateProductsScreen> createState() =>
      _UpdateProductsScreenState();
}

class _UpdateProductsScreenState extends ConsumerState<UpdateProductsScreen> {
  final GetInfoAboutLatestUpdateProviderParams _providerParams =
      GetInfoAboutLatestUpdateProviderParams();

  void _getInfoAboutLatestUpdate() {
    ref
        .read(getInfoAboutLatestUpdateProvider(_providerParams).notifier)
        .getInfoAboutLatestUpdate();
  }

  void _updateTargetsFromSource() {
    ref
        .read(updateTargetsFromSourceProvider.notifier)
        .updateTargetsFromSource();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _getInfoAboutLatestUpdate);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getInfoAboutLatestUpdateProvider(_providerParams),
        (previous, next) {
      if (next is GetInfoAboutLatestUpdateErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.failure.message),
            margin: EdgeInsets.symmetric(vertical: 90.h, horizontal: 15),
          ),
        );
        if (next.failure is AuthenticateFailure) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AuthenticationScreen.routeName,
            (route) => false,
            arguments: AuthenticationScreenArgs(initialLink: null),
          );
        }
      }
    });
    return RefreshIndicator(
      onRefresh: () async => _getInfoAboutLatestUpdate(),
      child: Scaffold(
        appBar: AppBars.appBarWithTitle(
          context: context,
          title: LocaleKeys.updateProductsList.tr(),
        ),
        body: SafeArea(
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: _buildUpdatedItemsList(),
        ),
        Padding(
          padding: EdgeInsets.all(25.sp),
          child: _buildUpdateButton(),
        ),
      ],
    );
  }

  Widget _buildUpdatedItemsList() {
    final state = ref.watch(getInfoAboutLatestUpdateProvider(_providerParams));
    if (state is GetInfoAboutLatestUpdateErrorState) {
      return FullscreenErrorWidget(
        onRetry: _getInfoAboutLatestUpdate,
        retryLastRequest: state.failure is RetryFailure,
      );
    } else if (state is GetInfoAboutLatestUpdateInitialState ||
        state is GetInfoAboutLatestUpdateLoadingState) {
      return UpdateProductsExpansionCardLoading();
    } else if (state is GetInfoAboutLatestUpdateNoUpdateState) {
      return NoUpdatesErrorWidget();
    } else {
      final loadedState = state as GetInfoAboutLatestUpdateLoadedState;
      final String updateCompletedDate =
          DateFormat.yMMMMd(context.locale.languageCode)
              .format(loadedState.date);
      return ListView(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 18.w),
        children: [
          Text(
            LocaleKeys.lastUpdateWasDone.tr() +
                ' ' +
                loadedState.updateMethod +
                ' ' +
                LocaleKeys.inPreposition.tr() +
                ' ' +
                updateCompletedDate,
            style: TextStyleManager.s18w700,
          ),
          Text(
            loadedState.updateStatus,
            style: TextStyleManager.s16w400.copyWith(
              color: ColorManager.grey,
            ),
          ),
          5.verticalSpace,
          UpdatedListTile(
            title: LocaleKeys.listOfNewlyAddedProducts.tr(),
            listType: ItemDescription.smartphone,
            items: [
              for (Phone phone in loadedState.phones)
                Item(
                  itemId: phone.id,
                  itemName: phone.name,
                  type: ItemDescription.smartphone,
                ),
            ],
          ),
          UpdatedListTile(
            title: LocaleKeys.listOfNewlyAddedCompanies.tr(),
            listType: ItemDescription.company,
            items: [
              for (Company company in loadedState.companies)
                Item(
                  itemId: company.id,
                  itemName: company.name,
                  type: ItemDescription.company,
                ),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildUpdateButton() {
    ref.listen(updateTargetsFromSourceProvider, (previous, next) {
      if (next is UpdateTargetsFromSourceErrorState) {
        late SnackBar snackBar;
        if (next.failure is RetryFailure) {
          snackBar = SnackBar(
            content: Text(next.failure.message),
            margin: EdgeInsets.symmetric(vertical: 90.h, horizontal: 15),
            action: SnackBarAction(
              label: 'إعادة المحاولة',
              onPressed: _updateTargetsFromSource,
            ),
          );
        } else {
          snackBar = SnackBar(
            content: Text(next.failure.message),
            margin: EdgeInsets.symmetric(vertical: 90.h, horizontal: 15),
          );
        }
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (next.failure is AuthenticateFailure) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AuthenticationScreen.routeName,
            (route) => false,
            arguments: AuthenticationScreenArgs(initialLink: null),
          );
        }
      }
    });

    final gettingState =
        ref.watch(getInfoAboutLatestUpdateProvider(_providerParams));
    late bool isEnabled;
    if (gettingState is GetInfoAboutLatestUpdateLoadingState ||
        gettingState is GetInfoAboutLatestUpdateInitialState) {
      isEnabled = false;
    } else if (gettingState is GetInfoAboutLatestUpdateLoadedState &&
        gettingState.isUpdating == true) {
      isEnabled = false;
    } else {
      isEnabled = true;
    }

    final updateState = ref.watch(updateTargetsFromSourceProvider);
    if (updateState is UpdateTargetsFromSourceLoadingState ||
        updateState is UpdateTargetsFromSourceLoadedState) {
      isEnabled = false;
    } else if (updateState is UpdateTargetsFromSourceErrorState) {
      isEnabled = true;
    }

    String text =
        isEnabled ? LocaleKeys.updateProducts.tr() : LocaleKeys.updating.tr();

    return GradButton(
      text: Text(text),
      icon: Icon(Icons.update, size: 21.sp),
      width: double.infinity,
      reverseIcon: true,
      onPressed: _updateTargetsFromSource,
      isEnabled: isEnabled,
    );
  }
}
