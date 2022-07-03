import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/send_and_forget_requests.dart';
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
    required this.postForReportCard,
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
  final bool postForReportCard;

  @override
  ConsumerState<CardFooterButtonBar> createState() =>
      _CardFooterButtonBarState();
}

class _CardFooterButtonBarState extends ConsumerState<CardFooterButtonBar> {
  late final LikeProviderParams _likeProviderParams = LikeProviderParams(
    socialItemId: widget.postId,
    postType: widget.postType,
    interactionType: null,
    replyParentId: null,
    getInteractionsProviderParams: null,
  );

  late final PostProviderParams _postProviderParams = PostProviderParams(
    postId: widget.postId,
    postType: widget.postType,
    post: null,
  );

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      ref
          .read(likeProvider(_likeProviderParams).notifier)
          .setLoadedState(widget.liked);
    });
  }

  String _getWebPath(PostType postType) {
    switch (postType) {
      case PostType.phoneReview:
        return 'phone-review';
      case PostType.companyReview:
        return 'company-review';
      case PostType.phoneQuestion:
        return 'phone-question';
      case PostType.companyQuestion:
        return 'company-question';
    }
  }

  void _sharePost() async {
    Uri androidLink = Uri.https(
      StringsManager.webDomain,
      _getWebPath(widget.postType),
      <String, String>{
        'id': widget.postId,
        'linkType': LinkType.post.name,
        'postId': widget.postId,
        'userId': widget.userId,
        'postType': widget.postType.name,
      },
    );

    Uri webLink = Uri.https(
      StringsManager.webDomain,
      _getWebPath(widget.postType),
      <String, String>{'id': widget.postId},
    );

    final dynamicLinkParams = DynamicLinkParameters(
      link: androidLink,
      uriPrefix: StringsManager.uriPrefix,
      androidParameters: AndroidParameters(
        packageName: StringsManager.packageName,
        fallbackUrl: webLink,
      ),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    final result = await Share.shareWithResult(dynamicLink.shortUrl.toString());
    print(dynamicLink.shortUrl.toString());

    if (result.status == ShareResultStatus.success) {
      SendAndForgetRequests.increaseShareCount(
        postId: widget.postId,
        targetType: widget.postType.targetType,
        postContentType: widget.postType.postContentType,
      );
      ref.read(postProvider(_postProviderParams).notifier).incrementShares();
      FirebaseAnalytics.instance.logShare(
        contentType: widget.postType.name,
        itemId: widget.postId,
        method: 'unknown',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.addErrorListener(
      provider: likeProvider(_likeProviderParams),
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
            onPressed: _sharePost,
          ),
        ),
      ],
    );
  }

  Widget _buildLikeButton() {
    final state = ref.watch(likeProvider(_likeProviderParams));
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
      onPressed: widget.postForReportCard
          ? null
          : () {
              final state = ref.watch(likeProvider(_likeProviderParams));
              if (state is! LoadingState) {
                ref
                    .read(likeProvider(_likeProviderParams).notifier)
                    .toggleLikeState();
              }
            },
    );
  }
}
