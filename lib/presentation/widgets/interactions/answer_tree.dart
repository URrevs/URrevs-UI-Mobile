import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_footer.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AnswerTree extends StatefulWidget {
  const AnswerTree({
    Key? key,
    required this.answerId,
    required this.userId,
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
    this.onTappingAnswerInCard,
    this.expandReplies = false,
  })  : assert(
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
        super(key: key);

  final String answerId;
  final String userId;
  final PostType parentPostType;
  final String? imageUrl;
  final String authorName;
  final DateTime usedSinceDate;
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

  static AnswerTree get dummyInstance => AnswerTree(
        key: UniqueKey(),
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
      );

  static AnswerTree get dummyInstanceInQuestionCard => AnswerTree(
        key: UniqueKey(),
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
      );

  AnswerTree copyWith({
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
  }) {
    return AnswerTree(
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
    );
  }

  @override
  State<AnswerTree> createState() => _AnswerTreeState();
}

class _AnswerTreeState extends State<AnswerTree> {
  late bool _expandReplies = widget.expandReplies;

  void _onPressingShowReplies() {
    setState(() {
      _expandReplies = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.accepted) ...[
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
              arguments:
                  UserProfileScreenArgs(userId: '626b29227fe7587a42e3e9f6'),
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
                  likeCount: widget.likeCount,
                  maxWidth: constraints.maxWidth - 16.w,
                  usedSinceDate: widget.usedSinceDate,
                  inQuestionCard: widget.inQuestionCard,
                  onTappingAnswerInCard: widget.onTappingAnswerInCard,
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
                    Reply(
                      imageUrl: widget.replies[i].photo,
                      authorName: widget.replies[i].userName,
                      replyText: widget.replies[i].content,
                      likeCount: widget.replies[i].likes,
                      datePosted: widget.replies[i].createdAt,
                      liked: widget.replies[i].liked,
                      onPressingReply: widget.onPressingReply,
                      interactionId: widget.replies[i].id,
                      parentPostType: widget.parentPostType,
                      userId: widget.replies[i].userId,
                      // comment id cannot be null if there is a reply passed to the comment
                      replyParentId: widget.answerId,
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
