import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/like_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_footer/card_footer_button.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// The three bottom buttons of the card footer.
class CardFooterButtonBar extends ConsumerStatefulWidget {
  const CardFooterButtonBar({
    Key? key,
    required this.liked,
    required this.useInReviewCard,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.postId,
    required this.postType,
    required this.userId,
  }) : super(key: key);

  /// Is the review liked by the current logged in user or not.
  final bool liked;

  /// Whether the [CardFooterButtonBar] would be used in a review card or
  /// not.
  final bool useInReviewCard;

  /// Callback invoked when like (or upvote) buttons are pressed.
  final VoidCallback onLike;

  /// Callback invoked when comment (or answer) buttons are pressed.
  final VoidCallback onComment;

  /// Callback invoked when share button is pressed.
  final VoidCallback onShare;

  final String postId;

  final PostType postType;

  final String userId;

  @override
  ConsumerState<CardFooterButtonBar> createState() =>
      _CardFooterButtonBarState();
}

class _CardFooterButtonBarState extends ConsumerState<CardFooterButtonBar> {
  late final LikeProviderParams _providerParams = LikeProviderParams(
    socialItemId: widget.postId,
    postType: widget.postType,
    interactionType: null,
    replyParentId: null,
  );

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      ref
          .read(likeProvider(_providerParams).notifier)
          .setLoadedState(widget.liked);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: likeProvider(_providerParams),
      context: context,
    );

    final authState =
        ref.watch(authenticationProvider) as AuthenticationLoadedState;
    bool myCard = authState.user.id == widget.userId;

    String secondText = widget.useInReviewCard
        ? LocaleKeys.comment.tr()
        : LocaleKeys.answer.tr();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!myCard) Expanded(child: _buildLikeButton()),
        Expanded(
          child: CardFooterButton(
            icon: Icon(IconsManager.comment, size: 24.sp),
            text: secondText,
            onPressed: widget.onComment,
          ),
        ),
        Expanded(
          child: CardFooterButton(
            icon: Icon(IconsManager.share, size: 24.sp),
            text: LocaleKeys.share.tr(),
            onPressed: widget.onShare,
          ),
        ),
      ],
    );
  }

  Widget _buildLikeButton() {
    final state = ref.watch(likeProvider(_providerParams));
    bool liked = (state is LikeLoadedState && state.liked) ||
        (state is LikeLoadingState && state.liked);

    String likedText = liked ? LocaleKeys.liked.tr() : LocaleKeys.like.tr();

    Color buttonColor = (liked) ? ColorManager.blue : ColorManager.buttonGrey;

    Widget firstIcon = widget.useInReviewCard
        ? Icon(
            liked ? IconsManager.likeFilled : IconsManager.likeEmpty,
            size: 24.sp,
            color: buttonColor,
          )
        : FaIcon(
            IconsManager.upvote,
            size: 24.sp,
            color: buttonColor,
          );

    String firstText =
        widget.useInReviewCard ? likedText : LocaleKeys.vote.tr();
    return CardFooterButton(
      icon: firstIcon,
      text: firstText,
      liked: liked,
      onPressed: () {
        final state = ref.watch(likeProvider(_providerParams));
        if (state is! LoadingState) {
          ref.read(likeProvider(_providerParams).notifier).toggleLikeState();
        }
      },
    );
  }
}
