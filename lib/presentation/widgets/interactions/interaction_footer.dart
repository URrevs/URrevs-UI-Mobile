import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/like_state.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

enum InteractionFooterFirstButtonText { like, vote, acceptAnswer }

class InteractionFooter extends ConsumerStatefulWidget {
  const InteractionFooter({
    Key? key,
    required this.datePosted,
    required this.maxWidth,
    required this.liked,
    required this.firstButtonType,
    required this.onPressingReply,
    required this.interactionId,
    required this.replyParentId,
    required this.parentPostType,
    required this.interactionType,
    required this.userId,
    this.posting = false,
  }) : super(key: key);

  final DateTime datePosted;
  final double maxWidth;
  final bool liked;
  final InteractionFooterFirstButtonText firstButtonType;
  final bool posting;
  final VoidCallback onPressingReply;
  final String? interactionId;
  final String? replyParentId;
  final PostType parentPostType;
  final InteractionType interactionType;
  final String userId;

  @override
  ConsumerState<InteractionFooter> createState() => _InteractionFooterState();
}

class _InteractionFooterState extends ConsumerState<InteractionFooter> {
  late final LikeProviderParams? _likeProviderParams =
      widget.interactionId != null
          ? LikeProviderParams(
              socialItemId: widget.interactionId!,
              replyParentId: widget.replyParentId,
              postType: widget.parentPostType,
              interactionType: widget.interactionType,
            )
          : null;

  String get firstButtonText {
    final state = ref.watch(likeProvider(_likeProviderParams!));
    bool liked = state is LikeLoadedState && state.liked;
    switch (widget.firstButtonType) {
      case InteractionFooterFirstButtonText.like:
        return liked ? LocaleKeys.liked.tr() : LocaleKeys.like.tr();
      case InteractionFooterFirstButtonText.vote:
        return LocaleKeys.vote.tr();
      case InteractionFooterFirstButtonText.acceptAnswer:
        return liked
            ? LocaleKeys.acceptedAnswer.tr()
            : LocaleKeys.acceptAnswer.tr();
    }
  }

  String footerText(BuildContext context) => widget.posting
      ? LocaleKeys.posting.tr() + '...'
      : timeago.format(widget.datePosted, locale: context.locale.languageCode);

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (_likeProviderParams != null) {
        ref
            .read(likeProvider(_likeProviderParams!).notifier)
            .setLikedState(widget.liked);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_likeProviderParams != null) {
      ref.addErrorListener(
        provider: likeProvider(_likeProviderParams!),
        context: context,
      );
    }

    final state = ref.watch(authenticationProvider);
    bool isMyInteraction =
        state is AuthenticationLoadedState && state.user.id == widget.userId;

    EdgeInsets footerElementsPadding =
        EdgeInsets.only(top: 6.h, left: 3.w, right: 3.w);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        10.horizontalSpace,
        if (!widget.posting) ...[
          if (!isMyInteraction) ...[
            _buildLikeButton(),
            20.horizontalSpace,
          ],
          TextButton(
            onPressed: widget.onPressingReply,
            style: TextButtonStyleManager.interactionFooterButton,
            child: Text(LocaleKeys.reply.tr(), style: TextStyleManager.s13w700),
          ),
          20.horizontalSpace,
        ],
        Padding(
          padding: footerElementsPadding,
          child: Text(
            footerText(context),
            style: TextStyleManager.s13w400.copyWith(
              color: ColorManager.grey,
            ),
          ),
        )
      ],
    );
  }

  TextButton _buildLikeButton() {
    final state = ref.watch(likeProvider(_likeProviderParams!));
    bool liked = state is LikeLoadedState && state.liked;
    Color color = liked ? ColorManager.blue : ColorManager.black;
    return TextButton(
      onPressed: () {
        ref.read(likeProvider(_likeProviderParams!).notifier).toggleLikeState();
      },
      style: TextButtonStyleManager.interactionFooterButton.copyWith(
        foregroundColor: MaterialStateProperty.all(color),
      ),
      child: Text(firstButtonText, style: TextStyleManager.s13w700),
    );
  }
}
