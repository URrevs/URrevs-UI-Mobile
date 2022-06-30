import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/company_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answer_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/question_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_header/card_header_title.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// A card showing a question.
class QuestionCard extends ConsumerWidget {
  final String questionId;

  /// Profile image url of the current logged in user.
  final String? imageUrl;

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

  final Answer? answer;

  final CardType cardType;

  final bool fullscreen;

  final VoidCallback onPressingAnswer;

  final String userId;

  final String targetId;

  final TargetType cardHeaderTitleType;

  QuestionCard({
    Key? key,
    required this.questionId,
    required this.userId,
    required this.targetId,
    required this.cardHeaderTitleType,
    required this.imageUrl,
    required this.authorName,
    required this.targetName,
    required this.postedDate,
    required this.questionText,
    required this.upvoteCount,
    required this.answerCount,
    required this.shareCount,
    required this.upvoted,
    required this.cardType,
    required this.fullscreen,
    required this.onPressingAnswer,
    this.answer,
  })  : _postProviderParams = PostProviderParams(
          postId: questionId,
          postType: PostType.phoneQuestion,
          post: Question.dummyInstance,
        ),
        _iDontLikeThisParams = IDontLikeThisProviderParams(
          postId: 'dummy',
          postContentType: PostContentType.question,
          targetType: TargetType.phone,
        ),
        super(key: key);

  QuestionCard.fromQuestion(
    Question question, {
    Key? key,
    required this.cardHeaderTitleType,
    required this.cardType,
    required this.fullscreen,
    required this.onPressingAnswer,
  })  : questionId = question.id,
        userId = question.userId,
        targetId = question.targetId,
        targetName = question.targetName,
        imageUrl = question.photo,
        authorName = question.userName,
        postedDate = question.createdAt,
        questionText = question.content,
        upvoteCount = question.upvotes,
        answerCount = question.ansCount,
        shareCount = question.shares,
        upvoted = question.upvoted,
        answer = question.acceptedAns,
        _postProviderParams = PostProviderParams(
          postId: question.id,
          postType: question.type == TargetType.phone
              ? PostType.phoneQuestion
              : PostType.companyQuestion,
          post: question,
        ),
        _iDontLikeThisParams = IDontLikeThisProviderParams(
          postId: question.id,
          postContentType: PostContentType.question,
          targetType: question.type,
        ),
        super(key: key);

  /// An instance of [QuestionCard] filled with dummy data.
  static QuestionCard dummyInstance(
    BuildContext context, {
    bool fullscreen = false,
  }) =>
      QuestionCard(
        questionId: DummyDataManager.randomInt.toString(),
        userId: DummyDataManager.randomInt.toString(),
        targetId: DummyDataManager.randomInt.toString(),
        cardHeaderTitleType: TargetType.phone,
        postedDate: DummyDataManager.postedDate,
        authorName: DummyDataManager.authorName,
        imageUrl: DummyDataManager.imageUrl,
        targetName: DummyDataManager.targetName,
        questionText: StringsManager.lorem,
        upvoteCount: DummyDataManager.randomInt,
        answerCount: DummyDataManager.randomInt,
        shareCount: DummyDataManager.randomInt,
        upvoted: DummyDataManager.randomBool,
        cardType: DummyDataManager.randomBool
            ? CardType.productReview
            : CardType.companyReview,
        fullscreen: fullscreen,
        onPressingAnswer: () {},
      );

  QuestionCard copyWith({
    String? questionId,
    String? userId,
    String? targetId,
    TargetType? cardHeaderTitleType,
    String? imageUrl,
    String? authorName,
    String? targetName,
    DateTime? postedDate,
    int? generalRating,
    String? questionText,
    bool? upvoted,
    int? upvoteCount,
    int? answerCount,
    int? shareCount,
    bool? fullscreen,
    CardType? cardType,
    AnswerTree? answer,
    VoidCallback? onPressingAnswer,
  }) {
    return QuestionCard(
      questionId: questionId ?? this.questionId,
      userId: userId ?? this.userId,
      targetId: targetId ?? this.targetId,
      cardHeaderTitleType: cardHeaderTitleType ?? this.cardHeaderTitleType,
      postedDate: postedDate ?? this.postedDate,
      authorName: authorName ?? this.authorName,
      imageUrl: imageUrl ?? this.imageUrl,
      targetName: targetName ?? this.targetName,
      questionText: questionText ?? this.questionText,
      upvoteCount: upvoteCount ?? this.upvoteCount,
      answerCount: answerCount ?? this.answerCount,
      shareCount: shareCount ?? this.shareCount,
      upvoted: upvoted ?? this.upvoted,
      fullscreen: fullscreen ?? this.fullscreen,
      cardType: cardType ?? this.cardType,
      onPressingAnswer: onPressingAnswer ?? this.onPressingAnswer,
    );
  }

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

  PostType get postType {
    if (cardHeaderTitleType == TargetType.phone) {
      return PostType.phoneQuestion;
    } else {
      return PostType.companyQuestion;
    }
  }

  Positioned _buildQuestionMark(BuildContext context) {
    return Positioned(
      top: 0,
      left: context.isArabic ? 0 : null,
      right: context.isArabic ? null : 0,
      child: Tooltip(
        message: LocaleKeys.askedQuestion.tr(),
        child: CircleAvatar(
          radius: AppRadius.questionMarkNotchRadius,
          backgroundColor: ColorManager.backgroundGrey,
          child: Transform.rotate(
            angle: 24 / 180 * math.pi * (context.isArabic ? -1 : 1),
            child: FaIcon(
              IconsManager.question,
              color: ColorManager.blue,
              size: 22.sp,
            ),
          ),
        ),
      ),
    );
  }

  late final PostProviderParams _postProviderParams;
  late final IDontLikeThisProviderParams _iDontLikeThisParams;

  @override
  Widget build(BuildContext context, ref) {
    ref.addErrorListener(
        provider: iDontLikeThisProvider(_iDontLikeThisParams),
        context: context);
    final hateState = ref.watch(iDontLikeThisProvider(_iDontLikeThisParams));
    if (!fullscreen &&
        (hateState is LoadingState || hateState is LoadedState)) {
      return SizedBox();
    }

    final question = ref.watch(postProvider(_postProviderParams)) as Question;
    return Stack(
      children: [
        Card(
          elevation: AppElevations.ev3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppRadius.interactionBodyRadius,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CardHeader(
                  imageUrl: imageUrl,
                  authorName: authorName,
                  targetName: targetName,
                  postedDate: postedDate,
                  usedSinceDate: null,
                  views: null,
                  userId: userId,
                  targetId: targetId,
                  targetType: cardHeaderTitleType,
                  postContentType: PostContentType.question,
                  postId: questionId,
                ),
                10.verticalSpace,
                QuestionCardBody(
                  questionText: questionText,
                  fullscreen: fullscreen,
                  cardType: cardType,
                  postId: questionId,
                  userId: userId,
                  postType: question.type == TargetType.phone
                      ? PostType.phoneQuestion
                      : PostType.companyQuestion,
                ),
                8.verticalSpace,
                CardFooter(
                  userId: userId,
                  likeCount: question.upvotes,
                  commentCount: question.ansCount,
                  shareCount: question.shares,
                  liked: upvoted,
                  useInReviewCard: false,
                  onLike: _onUpvote,
                  onComment: onPressingAnswer,
                  onShare: _onShare,
                  cardType: cardType,
                  fullscreen: fullscreen,
                  postType: postType,
                  postId: questionId,
                ),
                if (!fullscreen && answer != null) ...[
                  Divider(
                    height: 10.h,
                    thickness: 1.h,
                    color: ColorManager.dividerGrey,
                  ),
                  // TODO: show accepted answer
                  if (answer != null)
                    Padding(
                      padding:
                          EdgeInsets.only(top: 25.h, right: 12.w, left: 12.w),
                      child: AnswerTree.fromAnswer(
                        answer!,
                        postUserId: userId,
                        parentPostType: postType,
                        inQuestionCard: true,
                        questionId: questionId,
                        onTappingAnswerInCard: () {
                          Navigator.of(context).pushNamed(
                            FullscreenPostScreen.routeName,
                            arguments: FullscreenPostScreenArgs(
                              postUserId: userId,
                              postType: postType,
                              cardType: cardType,
                              postId: questionId,
                            ),
                          );
                        },
                        onPressingReply: () {
                          Navigator.of(context).pushNamed(
                            FullscreenPostScreen.routeName,
                            arguments: FullscreenPostScreenArgs(
                              postUserId: userId,
                              cardType: cardType,
                              postId: questionId,
                              focusOnTextField: true,
                              postType: postType,
                              answerId: answer!.id,
                            ),
                          );
                        },
                        getInteractionsProviderParams: null,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
        _buildQuestionMark(context),
      ],
    );
  }
}
