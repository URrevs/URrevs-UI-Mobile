import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Builds the trailing part of the header.
/// It contains a [PopupMenuButton] that shows "I don't like this"
class CardHeaderTrailer extends ConsumerStatefulWidget {
  const CardHeaderTrailer({
    Key? key,
    required this.postId,
    required this.targetType,
    required this.postContentType,
    required this.userId,
  }) : super(key: key);

  final String postId;
  final TargetType targetType;
  final PostContentType postContentType;
  final String userId;

  @override
  ConsumerState<CardHeaderTrailer> createState() => _CardHeaderTrailerState();
}

class _CardHeaderTrailerState extends ConsumerState<CardHeaderTrailer> {
  final CustomPopupMenuController controller = CustomPopupMenuController();

  late final IDontLikeThisProviderParams _iDontLikeThisParams =
      IDontLikeThisProviderParams(
    postId: widget.postId,
    postContentType: widget.postContentType,
    targetType: widget.targetType,
  );

  void _onTap() {
    controller.hideMenu();
    ref
        .read(iDontLikeThisProvider(_iDontLikeThisParams).notifier)
        .iDontLikeThis();
  }

  @override
  Widget build(BuildContext context) {
    final authState =
        ref.watch(authenticationProvider) as AuthenticationLoadedState;
    if (authState.user.id == widget.userId) {
      return SizedBox();
    }
    return CustomPopupMenu(
      controller: controller,
      pressType: PressType.singleClick,
      verticalMargin: -6.h,
      barrierColor: ColorManager.transparent,
      showArrow: false,
      menuBuilder: () => Card(
        elevation: AppElevations.ev3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: InkWell(
          onTap: _onTap,
          borderRadius: BorderRadius.circular(15.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
            child: Text(
              LocaleKeys.iDontLikeThis.tr(),
              style: TextStyleManager.s16w700,
            ),
          ),
        ),
      ),
      child: Icon(IconsManager.more, size: 26.sp),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
