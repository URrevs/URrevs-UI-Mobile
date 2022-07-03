import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/domain/models/answer.dart';
import 'package:urrevs_ui_mobile/domain/models/reply_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/question_states/accept_answer_state.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_footer.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AnswerTree extends ConsumerStatefulWidget {
  AnswerTree({
    Key? key,
    required this.answerId,
    required this.questionId,
    required this.userId,
    required this.postUserId,
    required this.parentPostType,
    required this.imageUrl,
    required this.authorName,
    required this.usedSinceDate,
    required this.commentText,
    required this.likeCount,
    required this.datePosted,
    required this.replies,
    required this.liked,
    required this.accepted,
    required this.inQuestionCard,
    required this.onPressingReply,
    required this.getInteractionsProviderParams,
    this.onTappingAnswerInCard,
    this.expandReplies = false,
  })  : _directInteractionProviderParams = DirectInteractionProviderParams(
          interactionId: 'dummy',
          interactionType: InteractionType.answer,
          interaction: Answer.dummyInstance,
        ),
        assert(
          !inQuestionCard || onTappingAnswerInCard != null,
          'onTappingAnswerInCard cannot be null if inQuestionCard is true.',
        ),
        super(key: key);

  AnswerTree.fromAnswer(
    Answer answer, {
    Key? key,
    required this.parentPostType,
    required this.inQuestionCard,
    required this.onTappingAnswerInCard,
    required this.onPressingReply,
    required this.getInteractionsProviderParams,
    required this.questionId,
    required this.postUserId,
    this.expandReplies = false,
  })  : answerId = answer.id,
        userId = answer.userId,
        imageUrl = answer.photo,
        authorName = answer.userName,
        usedSinceDate = answer.ownedAt,
        commentText = answer.content,
        likeCount = answer.upvotes,
        datePosted = answer.createdAt,
        replies = answer.replies,
        liked = answer.upvoted,
        accepted = answer.accepted,
        _directInteractionProviderParams = DirectInteractionProviderParams(
          interactionId: answer.id,
          interactionType: InteractionType.answer,
          interaction: answer,
        ),
        super(key: key);

  final String answerId;
  final String questionId;
  final String userId;
  final String postUserId;
  final PostType parentPostType;
  final String? imageUrl;
  final String authorName;
  final DateTime? usedSinceDate;
  final String commentText;
  final int likeCount;
  final DateTime datePosted;
  final bool liked;
  final bool accepted;
  final bool inQuestionCard;
  final List<ReplyModel> replies;
  final VoidCallback? onTappingAnswerInCard;
  final VoidCallback onPressingReply;
  final bool expandReplies;
  final GetInteractionsProviderParams? getInteractionsProviderParams;

  late final DirectInteractionProviderParams _directInteractionProviderParams;

  static AnswerTree get dummyInstance => AnswerTree(
        key: UniqueKey(),
        questionId: 'quesiton id',
        postUserId: 'post user id',
        imageUrl: DummyDataManager.imageUrl,
        authorName: DummyDataManager.authorName,
        usedSinceDate: DummyDataManager.usedSinceDate,
        commentText: DummyDataManager.sentenceOrMore,
        likeCount: DummyDataManager.randomInt,
        datePosted: DummyDataManager.postedDate,
        liked: DummyDataManager.randomBool,
        accepted: DummyDataManager.randomBool,
        inQuestionCard: false,
        replies: [],
        answerId: DummyDataManager.randomInt.toString(),
        userId: DummyDataManager.randomInt.toString(),
        parentPostType: PostType.phoneQuestion,
        onPressingReply: () {},
        getInteractionsProviderParams: GetInteractionsProviderParams(
            postId: '', postType: PostType.phoneQuestion),
      );

  static AnswerTree get dummyInstanceInQuestionCard => AnswerTree(
        key: UniqueKey(),
        questionId: 'quesiton id',
        postUserId: 'post user id',
        imageUrl: DummyDataManager.imageUrl,
        authorName: DummyDataManager.authorName,
        usedSinceDate: DummyDataManager.usedSinceDate,
        commentText: DummyDataManager.sentenceOrMore,
        likeCount: DummyDataManager.randomInt,
        datePosted: DummyDataManager.postedDate,
        liked: DummyDataManager.randomBool,
        accepted: true,
        inQuestionCard: true,
        replies: [],
        onTappingAnswerInCard: () {},
        onPressingReply: () {},
        answerId: DummyDataManager.randomInt.toString(),
        userId: DummyDataManager.randomInt.toString(),
        parentPostType: PostType.phoneQuestion,
        getInteractionsProviderParams: GetInteractionsProviderParams(
            postId: '', postType: PostType.phoneQuestion),
      );

  AnswerTree copyWith({
    String? postUserId,
    String? questionId,
    String? imageUrl,
    String? authorName,
    DateTime? usedSinceDate,
    String? commentText,
    int? likeCount,
    DateTime? datePosted,
    bool? liked,
    bool? accepted,
    bool? isQuestionAuthor,
    bool? inQuestionCard,
    List<ReplyModel>? replies,
    VoidCallback? onTappingAnswerInCard,
    VoidCallback? onPressingReply,
    PostType? parentPostType,
    String? answerId,
    String? userId,
    GetInteractionsProviderParams? getInteractionsProviderParams,
  }) {
    return AnswerTree(
      postUserId: postUserId ?? this.postUserId,
      questionId: questionId ?? this.questionId,
      imageUrl: imageUrl ?? this.imageUrl,
      authorName: authorName ?? this.authorName,
      usedSinceDate: usedSinceDate ?? this.usedSinceDate,
      commentText: commentText ?? this.commentText,
      likeCount: likeCount ?? this.likeCount,
      datePosted: datePosted ?? this.datePosted,
      liked: liked ?? this.liked,
      accepted: accepted ?? this.accepted,
      inQuestionCard: inQuestionCard ?? this.inQuestionCard,
      replies: replies ?? this.replies,
      onTappingAnswerInCard:
          onTappingAnswerInCard ?? this.onTappingAnswerInCard,
      parentPostType: parentPostType ?? this.parentPostType,
      answerId: answerId ?? this.answerId,
      userId: userId ?? this.userId,
      onPressingReply: onPressingReply ?? this.onPressingReply,
      getInteractionsProviderParams:
          getInteractionsProviderParams ?? this.getInteractionsProviderParams,
    );
  }

  @override
  ConsumerState<AnswerTree> createState() => _AnswerTreeState();
}

class _AnswerTreeState extends ConsumerState<AnswerTree> {
  late bool _expandReplies = widget.expandReplies;

  late final AcceptAnswerProviderParams _acceptAnswerProviderParams =
      AcceptAnswerProviderParams(
    questionId: widget.questionId,
    answerId: widget.answerId,
    targetType: widget.parentPostType.targetType,
    getInteractionsProviderParams: widget.getInteractionsProviderParams,
  );

  void _onPressingShowReplies() {
    setState(() {
      _expandReplies = true;
    });
  }

  bool get isAccepted {
    final state = ref.watch(acceptAnswerProvider(_acceptAnswerProviderParams));
    if (state is AcceptAnswerLoadingState) return state.accepted;
    if (state is AcceptAnswerLoadedState) return state.accepted;
    return widget.accepted;
  }

  @override
  Widget build(BuildContext context) {
    final answer = ref.watch(
            directInteractionsProvider(widget._directInteractionProviderParams))
        as Answer;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isAccepted) ...[
          FaIcon(
            IconsManager.acceptedAnswer,
            size: 30.sp,
            color: ColorManager.blue,
          ),
          12.horizontalSpace,
        ],
        Avatar(
          imageUrl: widget.imageUrl,
          radius: AppRadius.commentTreeAvatarRadius,
          onTap: () {
            Navigator.of(context).pushNamed(
              UserProfileScreen.routeName,
              arguments: UserProfileScreenArgs(userId: widget.userId),
            );
          },
        ),
        6.horizontalSpace,
        Expanded(
          child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InteractionBody(
                  authorName: widget.authorName,
                  replyText: widget.commentText,
                  likeCount: answer.upvotes,
                  maxWidth: constraints.maxWidth - 16.w,
                  usedSinceDate: widget.usedSinceDate,
                  inQuestionCard: widget.inQuestionCard,
                  onTappingAnswerInCard: widget.onTappingAnswerInCard,
                  interactionType: InteractionType.answer,
                  parentDirectInteractionId: null,
                  parentPostId: widget.questionId,
                  postContentType: widget.parentPostType.postContentType,
                  interactionId: widget.answerId,
                  targetType: widget.parentPostType.targetType,
                  authorId: widget.userId,
                ),
                InteractionFooter(
                  onPressingReply: () {
                    widget.onPressingReply();
                    if (!widget.inQuestionCard) {
                      setState(() => _expandReplies = true);
                    }
                  },
                  datePosted: widget.datePosted,
                  maxWidth: constraints.maxWidth - 16.w,
                  liked: widget.liked,
                  interactionId: widget.answerId,
                  replyParentId: null,
                  interactionType: InteractionType.answer,
                  parentPostType: widget.parentPostType,
                  userId: widget.userId,
                  accepted: widget.accepted,
                  getInteractionsProviderParams:
                      widget.getInteractionsProviderParams,
                  questionId: widget.questionId,
                  postUserId: widget.postUserId,
                ),
                if (!widget.inQuestionCard &&
                    !_expandReplies &&
                    widget.replies.isNotEmpty) ...[
                  VerticalSpacesBetween.interactionBodyAndShowRepliesButton,
                  TextButton(
                    onPressed: _onPressingShowReplies,
                    style: TextButtonStyleManager.showReplies,
                    child: Text(
                        '${widget.replies.length} ${LocaleKeys.reply.tr()}'),
                  ),
                ],
                if (_expandReplies) ...[
                  VerticalSpacesBetween.interactionBodyAndReplies,
                  for (int i = 0; i < widget.replies.length; i++) ...[
                    Reply.fromReplyModel(
                      widget.replies[i],
                      key: ValueKey(widget.replies[i].id),
                      onPressingReply: widget.onPressingReply,
                      parentPostType: widget.parentPostType,
                      replyParentId: widget.answerId,
                      postUserId: widget.postUserId,
                      parentDirectInteractionId: widget.answerId,
                      parentPostId: widget.questionId,

                      /// replies would not be shown except at fullscreen post
                      /// screen where get interactions provider params are
                      /// passed to answer tree - the only case where answer
                      /// tree isn't passed the params is when it is viewed in
                      /// question card
                      getInteractionsProviderParams:
                          widget.getInteractionsProviderParams!,
                    ),
                    if (i != widget.replies.length - 1)
                      VerticalSpacesBetween.replies,
                  ],
                ],
              ],
            );
          }),
        )
      ],
    );
  }
}
