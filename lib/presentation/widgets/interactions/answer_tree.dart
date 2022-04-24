import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/interaction_footer.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AnswerTree extends StatefulWidget {
  const AnswerTree({
    Key? key,
    required this.imageUrl,
    required this.authorName,
    required this.usedSinceDate,
    required this.commentText,
    required this.likeCount,
    required this.datePosted,
    required this.replies,
    required this.liked,
    required this.accepted,
    required this.isQuestionAuthor,
    required this.inQuestionCard,
    this.onTappingAnswerInCard,
  })  : assert(
          !inQuestionCard || onTappingAnswerInCard != null,
          'onTappingAnswerInCard cannot be null if inQuestionCard is true.',
        ),
        super(key: key);

  final String imageUrl;
  final String authorName;
  final DateTime usedSinceDate;
  final String commentText;
  final int likeCount;
  final DateTime datePosted;
  final bool liked;
  final bool accepted;
  final bool isQuestionAuthor;
  final bool inQuestionCard;
  final List<Reply> replies;
  final VoidCallback? onTappingAnswerInCard;

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
        isQuestionAuthor: DummyDataManager.randomBool,
        inQuestionCard: false,
        replies: DummyDataManager.replies,
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
        isQuestionAuthor: DummyDataManager.randomBool,
        inQuestionCard: true,
        replies: DummyDataManager.replies,
        onTappingAnswerInCard: () {},
      );

  @override
  State<AnswerTree> createState() => _AnswerTreeState();
}

class _AnswerTreeState extends State<AnswerTree> {
  bool _expandReplies = false;

  void _onPressingShowReplies() {
    setState(() {
      _expandReplies = true;
    });
  }

  InteractionFooterFirstButtonText get firstButtonType {
    if (widget.isQuestionAuthor) {
      return InteractionFooterFirstButtonText.acceptAnswer;
    } else {
      return InteractionFooterFirstButtonText.vote;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.accepted) ...[
          FaIcon(
            FontAwesomeIcons.check,
            size: 30.sp,
            color: ColorManager.blue,
          ),
          12.horizontalSpace,
        ],
        Avatar(
            imageUrl: widget.imageUrl,
            radius: AppRadius.commentTreeAvatarRadius),
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
                  datePosted: widget.datePosted,
                  maxWidth: constraints.maxWidth - 16.w,
                  liked: widget.liked,
                  firstButtonType: firstButtonType,
                ),
                VerticalSpacesBetween.replies,
                if (!widget.inQuestionCard && !_expandReplies)
                  TextButton(
                    onPressed: _onPressingShowReplies,
                    style: TextButtonStyleManager.showReplies,
                    child: Text(
                        '${widget.replies.length} ${LocaleKeys.reply.tr()}'),
                  ),
                if (_expandReplies)
                  for (int i = 0; i < widget.replies.length; i++) ...[
                    widget.replies[i],
                    if (i != widget.replies.length - 1)
                      VerticalSpacesBetween.replies,
                  ],
              ],
            );
          }),
        )
      ],
    );
  }
}
