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
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/report_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/send_report_dialog.dart';

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

  late final ReportProviderParams _reportPostProviderParams =
      ReportProviderParams(
    socialItemId: widget.postId,
    postContentType: widget.postContentType,
    targetType: widget.targetType,
    interactionType: null,
    parentDirectInteractionId: null,
    parentPostId: null,
  );

  void _onPressingIDontLikeThis() {
    controller.hideMenu();
    ref
        .read(iDontLikeThisProvider(_iDontLikeThisParams).notifier)
        .iDontLikeThis();
  }

  void _onPressingReport() {
    controller.hideMenu();
    showDialog(
      context: context,
      builder: (context) => SendReportDialog(
        socialItemId: widget.postId,
        postContentType: widget.postContentType,
        targetType: widget.targetType,
        interactionType: null,
        parentDirectInteractionId: null,
        parentPostId: null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: reportProvider(_reportPostProviderParams),
      context: context,
    );
    ref.listen(reportProvider(_reportPostProviderParams), (previous, next) {
      if (next is ReportLoadedState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.successfullyReported.tr()),
          ),
        );
      }
    });
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
        child: Padding(
          padding: EdgeInsets.all(8.sp),
          child: SizedBox(
            width: 170.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  onTap: _onPressingIDontLikeThis,
                  borderRadius: BorderRadius.circular(15.r),
                  child: Text(
                    LocaleKeys.iDontLikeThis.tr(),
                    style: TextStyleManager.s16w700,
                    textAlign: TextAlign.center,
                  ),
                ),
                5.verticalSpace,
                Divider(),
                5.verticalSpace,
                InkWell(
                  onTap: _onPressingReport,
                  borderRadius: BorderRadius.circular(15.r),
                  child: Text(
                    LocaleKeys.report.tr(),
                    style: TextStyleManager.s16w700,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
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
