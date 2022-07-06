import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/comment.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/direct_interaction.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';

import 'package:urrevs_ui_mobile/domain/models/report.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reports_states/get_report_context_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/error_widgets/fullscreen_error_widget.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_answer_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions_for_reports/report_comment_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/post_loading.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';

class ReportContextScreenArgs {
  Report report;
  String? reportedReplyId;
  ReportContextScreenArgs({
    required this.report,
    required this.reportedReplyId,
  });
}

class ReportContextScreen extends ConsumerStatefulWidget {
  const ReportContextScreen({Key? key, required this.screenArgs})
      : super(key: key);

  static const String routeName = 'ReportContextScreen';

  final ReportContextScreenArgs screenArgs;

  @override
  ConsumerState<ReportContextScreen> createState() =>
      _ReportContextScreenState();
}

class _ReportContextScreenState extends ConsumerState<ReportContextScreen> {
  late final GetReportContextProviderParams _providerParams =
      GetReportContextProviderParams(
    reportId: widget.screenArgs.report.id,
    report: widget.screenArgs.report,
  );

  void _getReportContext() {
    ref
        .read(getReportContextProvider(_providerParams).notifier)
        .getReportContext();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _getReportContext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarWithTitle(
        context: context,
        title: '',
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    ref.addErrorListener(
      provider: getReportContextProvider(_providerParams),
      context: context,
    );
    final state = ref.watch(getReportContextProvider(_providerParams));
    Widget? widget = fullScreenErrorWidgetOrNull(
      [StateAndRetry(state: state, onRetry: _getReportContext)],
    );
    if (widget != null) return widget;
    return _buildPostAndInteraction();
  }

  Widget _buildPostAndInteraction() {
    final state = ref.watch(getReportContextProvider(_providerParams));
    if (state is InitialState || state is LoadingState) {
      return PostLoading();
    } else if (state is ErrorState) {
      return FullscreenErrorWidget(onRetry: _getReportContext);
    }
    state as GetReportContextLoadedState;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      children: [
        _buildPost(state.post),
        20.verticalSpace,
        _buildInteraction(state.directInteraction),
      ],
    );
  }

  Widget _buildPost(Post post) {
    if (post is PhoneReview) {
      return ProductReviewCard.fromPhoneReview(
        phoneReview: post,
        fullscreen: true,
        onPressingComment: () {},
        postForReportCard: true,
      );
    } else if (post is CompanyReview) {
      return CompanyReviewCard.fromCompanyReview(
        companyReview: post,
        fullscreen: true,
        onPressingComment: () {},
        postForReportCard: true,
      );
    }
    post as Question;
    return QuestionCard.fromQuestion(
      post,
      cardHeaderTitleType: post.type,
      cardType: post.type == PostType.phoneQuestion
          ? CardType.productQuestion
          : CardType.companyQuestion,
      fullscreen: true,
      onPressingAnswer: () {},
      postForReportCard: true,
    );
  }

  Widget _buildInteraction(DirectInteraction directInteraction) {
    if (directInteraction is Comment) {
      return ReportCommentTree.fromComment(directInteraction);
    }
    directInteraction as Answer;
    return ReportAnswerTree.fromAnswer(directInteraction);
  }
}
