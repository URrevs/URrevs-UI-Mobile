import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel/subscreens.dart/reports_screen/subscreens/report_context_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/block_user_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/close_report_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/get_report_interaction_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/get_reports_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/hide_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/get_interactions_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/partial_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comment_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_answer_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_comment_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/interaction_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ReportCard extends ConsumerStatefulWidget {
  const ReportCard({
    Key? key,
    required this.report,
    required this.reportStatus,
  }) : super(key: key);

  final Report report;
  final ReportStatus reportStatus;

  @override
  ConsumerState<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends ConsumerState<ReportCard> {
  late final HideProviderParams _hideProviderParams =
      HideProviderParams(reportId: widget.report.id, report: widget.report);

  late final GetReportInteractionProviderParams _getRepIntProvParams =
      GetReportInteractionProviderParams(
          reportId: widget.report.id, report: widget.report);

  late final BlockUserProviderParamss _blockUserProvParams =
      BlockUserProviderParamss(
          reportId: widget.report.id, report: widget.report);

  late final CloseReportProviderParams _closeReportProvParams =
      CloseReportProviderParams(
          reportId: widget.report.id, report: widget.report);

  void _getReportInteraction() {
    ref
        .read(getReportInteractionProvider(_getRepIntProvParams).notifier)
        .toggleReportInteractionVisibility();
  }

  Widget _buildElevatedButton({
    required VoidCallback? onPressed,
    required Color color,
    required String text,
  }) {
    return Flexible(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          textStyle: TextStyleManager.s14w700.copyWith(
            fontFamily: FontConstants.tajawal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final closeReportState =
        ref.watch(closeReportProvider(_closeReportProvParams));
    if (closeReportState is CloseReportLoadedState) return SizedBox();
    return Card(
      elevation: AppElevations.ev3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppRadius.interactionBodyRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 8.h, 0, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardHeader(
              imageUrl: widget.report.reporterPicture,
              authorName: widget.report.reporterName,
              targetName: widget.report.reporteeName,
              postedDate: widget.report.createdAt,
              userId: widget.report.reporterId,
              targetId: widget.report.reporteeId,
              targetType: null,
              postContentType: null,
              postId: null,
              views: null,
              usedSinceDate: null,
              usedInReportCard: true,
            ),
            20.verticalSpace,
            _buildReportBodyText(),
            _buildReportInteraction(),
            8.verticalSpace,
            _buildReportButtons(ref),
          ],
        ),
      ),
    );
  }

  Widget _buildReportBodyText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${LocaleKeys.postType.tr()}: ',
                  style: TextStyleManager.s16w500,
                ),
                TextSpan(
                  text: '${widget.report.type.translatedName}\n',
                  style: TextStyleManager.s16w400,
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${LocaleKeys.reason.tr()}: ',
                  style: TextStyleManager.s16w500,
                ),
                TextSpan(
                  text: '${widget.report.reason.translatedName}\n',
                  style: TextStyleManager.s16w400,
                ),
              ],
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${LocaleKeys.complaintContent.tr()}: ',
                  style: TextStyleManager.s16w500,
                ),
                TextSpan(
                  text: '\n${widget.report.info ?? '-'}',
                  style: TextStyleManager.s16w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportButtons(WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildShowContentButton(),
              if (widget.reportStatus == ReportStatus.open) ...[
                10.horizontalSpace,
                _buildElevatedButton(
                  onPressed: () {
                    ref
                        .read(closeReportProvider(_closeReportProvParams)
                            .notifier)
                        .closeReport();
                  },
                  color: ColorManager.blue,
                  text: LocaleKeys.closeComplaint.tr(),
                ),
              ],
            ],
          ),
          8.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHideButton(),
              10.horizontalSpace,
              _buildBlockButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBlockButton() {
    ref.addErrorListener(
      provider: blockUserProvider(_blockUserProvParams),
      context: context,
    );
    final state = ref.watch(blockUserProvider(_blockUserProvParams));
    bool loading = state is BlockUserLoadingState;
    bool blocked = state is BlockUserInitialState && state.blocked ||
        state is BlockUserLoadingState && state.blocked ||
        state is BlockUserLoadedState && state.blocked;
    return _buildElevatedButton(
      onPressed: loading
          ? null
          : () {
              ref
                  .read(blockUserProvider(_blockUserProvParams).notifier)
                  .toggleBlockState();
            },
      color: ColorManager.red,
      text: !blocked
          ? LocaleKeys.blockThisUsersAccount.tr()
          : LocaleKeys.unblockThisUsersAccount.tr(),
    );
  }

  Widget _buildShowContentButton() {
    ReportType reportType = widget.report.type;
    final state = widget.report.type.isPost
        ? null
        : ref.watch(getReportInteractionProvider(_getRepIntProvParams));
    bool textIsShow = state is! GetReportInteractionLoadedState;
    return _buildElevatedButton(
      onPressed: () {
        if (reportType.isPost) {
          Navigator.of(context).pushNamed(
            FullscreenPostScreen.routeName,
            arguments: FullscreenPostScreenArgs(
              cardType: widget.report.type.cardType,
              postId: widget.report.postId,
              postUserId: widget.report.reporteeId,
              postType: reportType.postType!,
              getPostForReport: true,
            ),
          );
        } else {
          _getReportInteraction();
        }
      },
      color: ColorManager.blue,
      text: textIsShow
          ? LocaleKeys.showContent.tr()
          : LocaleKeys.hideContent.tr(),
    );
  }

  Widget _buildHideButton() {
    ref.addErrorListener(
      provider: hideProvider(_hideProviderParams),
      context: context,
    );
    final state = ref.watch(hideProvider(_hideProviderParams));
    bool loading = state is HideLoadingState;
    bool hidden = state is HideInitialState && state.hidden ||
        state is HideLoadingState && state.hidden ||
        state is HideLoadedState && state.hidden;
    return _buildElevatedButton(
      onPressed: loading
          ? null
          : () {
              final state = ref.watch(hideProvider(_hideProviderParams));
              if (state is! HideLoadingState) {
                ref.read(hideProvider(_hideProviderParams).notifier).toggle();
              }
            },
      color: ColorManager.red,
      text: !hidden
          ? LocaleKeys.preventViewingThisContent.tr()
          : LocaleKeys.permitViewingThisContent.tr(),
    );
  }

  Widget _buildReportInteraction() {
    if (widget.report.type.isPost) return SizedBox();
    ref.addErrorListener(
      provider: getReportInteractionProvider(_getRepIntProvParams),
      context: context,
    );
    final state = ref.watch(getReportInteractionProvider(_getRepIntProvParams));
    if (state is GetReportInteractionInitialState ||
        state is GetReportInteractionHiddenState) return SizedBox();
    if (state is GetReportInteractionLoadingState) return InteractionLoading();
    if (state is GetReportInteractionErrorState) {
      return PartialErrorWidget(onRetry: _getReportInteraction);
    }
    state as GetReportInteractionLoadedState;
    Interaction interaction = state.interaction;
    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ReportContextScreen.routeName,
              arguments: ReportContextScreenArgs(
                report: widget.report,
                reportedReplyId:
                    interaction is ReplyModel ? interaction.id : null,
              ),
            );
          },
          child: Builder(builder: (context) {
            if (interaction is Comment) {
              return ReportCommentTree.fromComment(interaction);
            } else if (interaction is Answer) {
              return ReportAnswerTree.fromAnswer(interaction);
            } else {
              return ReportReply.fromReplyModel(interaction as ReplyModel);
            }
          }),
        ),
      ),
    );
  }
}
