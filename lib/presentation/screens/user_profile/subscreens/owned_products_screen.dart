import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:urrevs_ui_mobile/app/app.dart';
import 'package:urrevs_ui_mobile/domain/failure.dart';

import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/bottom_navigation_bar_container_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_owned_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_list_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/owned_prodcuts_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/error_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
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
  final PagingController<int, Phone> _pagingController =
      PagingController(firstPageKey: 0);

  void _getMyOwnedPhones() {
    String? userId = widget.screenArgs.userId;
    if (userId == null) {
      ref.read(getOwnedPhonesProvider.notifier).getMyOwnedPhones();
    } else {
      ref
          .read(getOwnedPhonesProvider.notifier)
          .getTheOwnedPhonesOfAnotherUser(userId);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    final state = ref.watch(getOwnedPhonesProvider);
    if (state is GetMyOwnedPhonesErrorState &&
        state.failure is! AuthenticateFailure) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  @override
  void didPop() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
    ref.listen(getOwnedPhonesProvider, (previous, next) {
      if (next is GetMyOwnedPhonesLoadedState) {
        if (next.roundsEnded) {
          _pagingController.itemList ??= [];
          return _pagingController.nextPageKey = null;
        }
        _pagingController.itemList = next.phones;
      } else if (next is GetMyOwnedPhonesErrorState) {
        _pagingController.error = next.failure.message;
        bool firstRound = _pagingController.itemList == null;
        late SnackBar snackBar;
        if (firstRound || next.failure is AuthenticateFailure) {
          snackBar = SnackBar(content: Text(next.failure.message));
        } else {
          snackBar = SnackBar(
            content: Text(next.failure.message),
            duration: Duration(days: 1),
            action: SnackBarAction(
              label: 'إعادة المحاولة',
              onPressed: () {
                _pagingController.retryLastFailedRequest();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          );
        }
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (next.failure is AuthenticateFailure) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AuthenticationScreen.routeName,
            (route) => false,
          );
        }
      }
    });
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return true;
      },
      child: ScaffoldWithHidingFab(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.h),
        child: AppBar(),
      ),
        onPressingFab: () {
          Navigator.of(context).pushNamed(
            BottomNavigationBarContainerScreen.routeName,
            arguments: BottomNavigationBarContainerScreenArgs(
              screenIndex: BottomNavBarIndeces.postingSubscreen,
            ),
          );
        },
        fabLabel: LocaleKeys.addOwnedProduct.tr(),
        fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
        body: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          child: PagedListView(
            pagingController: _pagingController,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            builderDelegate: PagedChildBuilderDelegate<Phone>(
              itemBuilder: (context, phone, index) {
                return ItemTile(
                  title: phone.name,
                  subtitle: LocaleKeys.smartphone.tr(),
                  iconData: IconsManager.smartPhone,
                  showDivider: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProductProfileScreen.routeName,
                    );
                  },
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
              newPageProgressIndicatorBuilder: (context) =>
                  OwnedProductsLoading(),
            ),
          ),
        ),
      ),
    );
  }
}
