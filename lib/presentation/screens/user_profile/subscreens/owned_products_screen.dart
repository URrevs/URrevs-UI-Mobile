import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/app/app.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';

import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/bottom_navigation_bar_container_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/posting_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_owned_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/verify_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/circular_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/owned_prodcuts_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/error_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/verified_mark.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class OwnedProductsScreenArgs {
  String? userId;
  OwnedProductsScreenArgs({
    this.userId,
  });
}

class OwnedProductsScreen extends ConsumerStatefulWidget {
  const OwnedProductsScreen(this.screenArgs, {Key? key}) : super(key: key);

  final OwnedProductsScreenArgs screenArgs;

  static const String routeName = 'OwnedProductsScreen';

  @override
  ConsumerState<OwnedProductsScreen> createState() =>
      _OwnedProductsScreenState();
}

class _OwnedProductsScreenState extends ConsumerState<OwnedProductsScreen>
    with RouteAware {
  late final GetOwnedPhonesProviderParams _ownedPhonesProviderParams =
      GetOwnedPhonesProviderParams(userId: widget.screenArgs.userId);

  final PagingController<int, Phone> _pagingController =
      PagingController(firstPageKey: 0);

  void _getMyOwnedPhones() {
    ref
        .read(getOwnedPhonesProvider(_ownedPhonesProviderParams).notifier)
        .getOwnedProducts();
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((_) {
      Future.delayed(Duration.zero, _getMyOwnedPhones);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: getOwnedPhonesProvider(_ownedPhonesProviderParams),
      context: context,
    );
    ref.addInfiniteScrollingListener(
      getOwnedPhonesProvider(_ownedPhonesProviderParams),
      _pagingController,
    );
    return ScaffoldWithHidingFab(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: LocaleKeys.ownedProducts.tr(),
      ),
      hideFab: widget.screenArgs.userId != null,
      onPressingFab: () {
        Navigator.of(context).pushNamed(
          PostingScreen.routeName,
          arguments: PostingScreenArgs(
            postContentType: PostContentType.review,
          ),
        );
      },
      fabLabel: LocaleKeys.addOwnedProduct.tr(),
      fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      body: PagedListView(
        pagingController: _pagingController,
        padding: AppEdgeInsets.screenPadding,
        builderDelegate: PagedChildBuilderDelegate<Phone>(
          itemBuilder: (context, phone, index) {
            return OwnedPhoneTile(
              key: ValueKey<String>(phone.toString()),
              phone: phone,
              userId: widget.screenArgs.userId,
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return FullscreenErrorWidget(
              onRetry: _pagingController.retryLastFailedRequest,
            );
          },
          newPageErrorIndicatorBuilder: (context) => SizedBox(),
          noItemsFoundIndicatorBuilder: (context) => EmptyListWidget(),
          noMoreItemsIndicatorBuilder: null,
          firstPageProgressIndicatorBuilder: (context) =>
              OwnedProductsLoading(),
          newPageProgressIndicatorBuilder: (context) => OwnedProductsLoading(),
        ),
      ),
    );
  }
}

class OwnedPhoneTile extends ConsumerStatefulWidget {
  const OwnedPhoneTile({
    Key? key,
    required this.userId,
    required this.phone,
  }) : super(key: key);

  final Phone phone;
  final String? userId;

  @override
  ConsumerState<OwnedPhoneTile> createState() => _OwnedPhoneTileState();
}

class _OwnedPhoneTileState extends ConsumerState<OwnedPhoneTile> {
  final CustomPopupMenuController _popupController =
      CustomPopupMenuController();

  late final VerifyProviderParams _verifyProviderParams = VerifyProviderParams(
    userId: widget.userId ?? ref.currentUser!.id,
    phoneId: widget.phone.id,
  );

  late bool verified =
      widget.phone.verificationStatus != VerificationStatus.unverified;

  Widget? get trailer {
    if ((widget.userId == null || widget.userId == ref.currentUser?.id) &&
        widget.phone.verificationRatio == 0) {
      return CustomPopupMenu(
        controller: _popupController,
        pressType: PressType.singleClick,
        verticalMargin: -6.h,
        barrierColor: ColorManager.transparent,
        showArrow: false,
        menuBuilder: () => Card(
          elevation: AppElevations.ev3,
          shadowColor: ColorManager.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: SizedBox(
              width: 170.w,
              child: InkWell(
                onTap: () {
                  _popupController.hideMenu();
                  ref
                      .read(verifyProvider(_verifyProviderParams).notifier)
                      .verifyPhone();
                },
                borderRadius: BorderRadius.circular(15.r),
                child: Text(
                  LocaleKeys.verifyPhone.tr(),
                  style: TextStyleManager.s16w700,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
        child: Icon(IconsManager.more, size: 26.sp),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: verifyProvider(_verifyProviderParams),
      context: context,
    );
    ref.listen(verifyProvider(_verifyProviderParams), (previous, next) {
      if (next is VerifyLoadedState &&
          next.verificationRatio == 0 &&
          ModalRoute.of(context)!.isCurrent) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys
                .youMustOpenTheApplicationFromTheDeviceYouWantToVerifyYourReviewOnIt
                .tr()),
            duration: Duration(seconds: 6),
          ),
        );
      }
    });
    print(
        'from owned products screen: ${widget.phone.name} - ${widget.phone.verificationRatio}');
    return ItemTile(
      titleWidget: Row(
        children: [
          Flexible(
            child: Text(
              widget.phone.name,
              style: TextStyleManager.s20w700,
            ),
          ),
          if (widget.phone.verificationRatio != 0) ...[
            5.horizontalSpace,
            VerifiedMark(
              verificationRatio: widget.phone.verificationRatio!,
              isPhone: true,
              size: 20.sp,
            ),
          ]
        ],
      ),
      subtitle: LocaleKeys.smartphone.tr(),
      trailing: trailer,
      iconData: IconsManager.smartPhone,
      showDivider: true,
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductProfileScreen.routeName,
          arguments: ProductProfileScreenArgs(
            phoneId: widget.phone.id,
            phoneName: widget.phone.name,
          ),
        );
      },
    );
  }
}
