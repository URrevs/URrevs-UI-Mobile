import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:urrevs_ui_mobile/domain/models/phone.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/get_my_owned_phones_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/error_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
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

class _OwnedProductsScreenState extends ConsumerState<OwnedProductsScreen> {
  final PagingController<int, Phone> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((_) {
      Future.delayed(
        Duration.zero,
        () {
          String? userId = widget.screenArgs.userId;
          if (userId == null) {
            ref.read(getOwnedPhonesProvider.notifier).getMyOwnedPhones();
          } else {
            ref
                .read(getOwnedPhonesProvider.notifier)
                .getTheOwnedPhonesOfAnotherUser(userId);
          }
        },
      );
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
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(failure: next.failure),
        );
      }
    });
    return ScaffoldWithHidingFab(
      appBar: AppBar(),
      onPressingFab: () {},
      fabLabel: LocaleKeys.addOwnedProduct.tr(),
      fabIcon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      body: PagedListView(
        pagingController: _pagingController,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        builderDelegate: PagedChildBuilderDelegate<Phone>(
          itemBuilder: (context, phone, index) {
            return MenyItem(
              title: phone.name,
              subtitle: LocaleKeys.smartphone.tr(),
              iconData: IconsManager.smartPhone,
              onTap: () {},
            );
          },
          // TODO: make error widgets
          firstPageErrorIndicatorBuilder: (context) => SizedBox(),
          newPageErrorIndicatorBuilder: (context) => SizedBox(),
          noItemsFoundIndicatorBuilder: null,
          noMoreItemsIndicatorBuilder: null,
          firstPageProgressIndicatorBuilder: (context) => CircularLoading(),
          newPageProgressIndicatorBuilder: (context) => CircularLoading(),
        ),
      ),
    );
  }
}
