import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answer_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/question_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header.dart';

/// A card showing a question.
class QuestionCard extends StatelessWidget {
  /// Profile image url of the current logged in user.
  final String imageUrl;

  /// Name of review author.
  final String authorName;

  /// Name of product or company on which the review was posted.
  final String targetName;

  /// The date where the review was posted.
  final DateTime postedDate;

  /// The text of the question.
  final String questionText;

  /// Is the review liked by the current logged in user or not.
  final bool upvoted;

  /// Number of likes given to the review.
  final int upvoteCount;

  /// Number of comments on the review.
  final int answerCount;

  /// Number of shares to the review
  final int shareCount;

  final AnswerTree? answer;

  const QuestionCard({
    Key? key,
    required this.imageUrl,
    required this.authorName,
    required this.targetName,
    required this.postedDate,
    required this.questionText,
    required this.upvoteCount,
    required this.answerCount,
    required this.shareCount,
    required this.upvoted,
    this.answer,
  }) : super(key: key);

  /// An instance of [QuestionCard] filled with dummy data.
  static QuestionCard get dummyInstance => QuestionCard(
        postedDate: DummyDataManager.postedDate,
        authorName: DummyDataManager.authorName,
        imageUrl: DummyDataManager.imageUrl,
        targetName: DummyDataManager.targetName,
        questionText: StringsManager.lorem,
        upvoteCount: DummyDataManager.randomInt,
        answerCount: DummyDataManager.randomInt,
        shareCount: DummyDataManager.randomInt,
        upvoted: DummyDataManager.randomBool,
        answer: AnswerTree.dummyInstanceInQuestionCard,
      );

  /// Callback invoked when upvote button is pressed.
  void _onUpvote() {
    // TODO: implememnt _onUpvote
  }

  /// Callback invoked when answer button is pressed.
  void _onAnswer() {
    // TODO: implememnt _onAnswer
  }

  /// Callback invoked when share button is pressed.
  void _onShare() {
    // TODO: implememnt _onShare
  }

  Positioned _buildQuestionMark(BuildContext context) {
    return Positioned(
      top: 0,
      left: context.isArabic ? 0 : null,
      right: context.isArabic ? null : 0,
      child: CircleAvatar(
        radius: AppRadius.questionMarkNotchRadius,
        backgroundColor: ColorManager.backgroundGrey,
        child: Transform.rotate(
          angle: 24 / 180 * math.pi * (context.isArabic ? -1 : 1),
          child: FaIcon(
            FontAwesomeIcons.circleQuestion,
            color: ColorManager.blue,
            size: 22.sp,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.interactionBodyRadius,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              children: [
                CardHeader(
                  imageUrl: imageUrl,
                  authorName: authorName,
                  targetName: targetName,
                  postedDate: postedDate,
                  usedSinceDate: null,
                  views: null,
                ),
                10.verticalSpace,
                QuestionCardBody(questionText: questionText),
                8.verticalSpace,
                CardFooter(
                  likeCount: upvoteCount,
                  commentCount: answerCount,
                  shareCount: shareCount,
                  liked: upvoted,
                  useInReviewCard: false,
                  onLike: _onUpvote,
                  onComment: _onAnswer,
                  onShare: _onShare,
                ),
                Divider(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(top: 25.h, right: 12.w, left: 12.w),
                  child: answer!,
                ),
              ],
            ),
          ),
        ),
        _buildQuestionMark(context),
      ],
    );
  }
}
