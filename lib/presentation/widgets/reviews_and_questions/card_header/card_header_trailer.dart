import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// Builds the trailing part of the header.
/// It contains a [PopupMenuButton] that shows "I don't like this"
class CardHeaderTrailer extends StatefulWidget {
  const CardHeaderTrailer({Key? key, required this.onHatingThis})
      : super(key: key);

  /// A callback executed when the user presses on "I don't like this".
  final VoidCallback onHatingThis;

  @override
  State<CardHeaderTrailer> createState() => _CardHeaderTrailerState();
}

class _CardHeaderTrailerState extends State<CardHeaderTrailer> {
  final CustomPopupMenuController controller = CustomPopupMenuController();

  void _onHatingThis(dynamic _) => widget.onHatingThis();

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      controller: controller,
      pressType: PressType.singleClick,
      verticalMargin: -6.h,
      barrierColor: ColorManager.transparent,
      showArrow: false,
      menuBuilder: () => Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: InkWell(
          onTap: () {
            controller.hideMenu();
          },
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
      child: Icon(Icons.more_vert, size: 26.sp),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
