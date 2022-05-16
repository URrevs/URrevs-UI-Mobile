import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers_parameters.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/authentication_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/question_states/accept_answer_state.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/states/reviews_states/like_state.dart';
import 'package:urrevs_ui_mobile/presentation/utils/states_util.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

enum InteractionFooterFirstButtonText { like, vote, acceptAnswer }

class InteractionFooter extends ConsumerStatefulWidget {
  const InteractionFooter({
    Key? key,
    required this.datePosted,
    required this.maxWidth,
    required this.liked,
    required this.onPressingReply,
    required this.interactionId,
    required this.replyParentId,
    required this.parentPostType,
    required this.interactionType,
    required this.userId,
    required this.accepted,
    required this.getInteractionsProviderParams,
    required this.questionId,
    required this.postUserId,
  })  : assert(
            !(interactionType == InteractionType.answer && accepted == null)),
        assert(
            !(interactionType == InteractionType.answer && questionId == null)),
        super(key: key);

  final DateTime datePosted;
  final double maxWidth;
  final bool liked;
  final VoidCallback onPressingReply;
  final String interactionId;
  final String? replyParentId;
  final PostType parentPostType;
  final InteractionType interactionType;
  final String userId;
  final bool? accepted;
  final GetInteractionsProviderParams? getInteractionsProviderParams;
  final String? questionId;
  final String postUserId;

  @override
  ConsumerState<InteractionFooter> createState() => _InteractionFooterState();
}

class _InteractionFooterState extends ConsumerState<InteractionFooter> {
  late final LikeProviderParams? _likeProviderParams = LikeProviderParams(
    socialItemId: widget.interactionId,
    replyParentId: widget.replyParentId,
    postType: widget.parentPostType,
    interactionType: widget.interactionType,
  );

  late final AcceptAnswerProviderParams? _acceptAnswerProviderParams =
      widget.interactionType == InteractionType.answer
          ? AcceptAnswerProviderParams(
              questionId: widget.questionId!,
              answerId: widget.interactionId,
              targetType: widget.parentPostType.targetType,
              getInteractionsProviderParams:
                  widget.getInteractionsProviderParams,
            )
          : null;

  bool get acceptAnswerMode {
    if (isInteractionUsingLikeText) {
      return false;
    }
    final authState = ref.watch(authenticationProvider);
    final user = (authState as AuthenticationLoadedState).user;
    if (user.id != widget.postUserId) return false;
    return true;
  }

  bool get isInteractionUsingLikeText =>
      widget.interactionType == InteractionType.comment ||
      widget.interactionType == InteractionType.reply;

  String get firstButtonText {
    if (!acceptAnswerMode) {
      if (isInteractionUsingLikeText) {
        final likedState = ref.watch(likeProvider(_likeProviderParams!));
        return likedState.isLiked
            ? LocaleKeys.liked.tr()
            : LocaleKeys.like.tr();
      } else {
        return LocaleKeys.vote.tr();
      }
    } else {
      final acceptedAnswerState =
          ref.watch(acceptAnswerProvider(_acceptAnswerProviderParams!));
      return acceptedAnswerState.isAccepted
          ? LocaleKeys.acceptedAnswer.tr()
          : LocaleKeys.acceptAnswer.tr();
    }
  }

  void _onPressingFirstButton() {
    if (!acceptAnswerMode) {
      final likedState = ref.watch(likeProvider(_likeProviderParams!));
      if (likedState is! LoadingState) {
        ref.read(likeProvider(_likeProviderParams!).notifier).toggleLikeState();
      }
    } else {
      if (_acceptAnswerProviderParams != null) {
        final acceptedAnswerState =
            ref.watch(acceptAnswerProvider(_acceptAnswerProviderParams!));
        if (acceptedAnswerState is! LoadingState) {
          ref
              .read(acceptAnswerProvider(_acceptAnswerProviderParams!).notifier)
              .toggleAcceptedState();
        }
      }
    }
  }

  String footerDate(BuildContext context) =>
      timeago.format(widget.datePosted, locale: context.locale.languageCode);

  bool get hideFirstButton {
    if (acceptAnswerMode) return false;
    final state = ref.watch(authenticationProvider);
    bool isMyInteraction =
        state is AuthenticationLoadedState && state.user.id == widget.userId;
    return isMyInteraction;
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (!acceptAnswerMode) {
        ref
            .read(likeProvider(_likeProviderParams!).notifier)
            .setLoadedState(widget.liked);
      } else {
        ref
            .read(acceptAnswerProvider(_acceptAnswerProviderParams!).notifier)
            .setLoadedState(widget.accepted!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (acceptAnswerMode) {
      ref.addErrorListener(
        provider: acceptAnswerProvider(_acceptAnswerProviderParams!),
        context: context,
      );
      ref.listen(acceptAnswerProvider(_acceptAnswerProviderParams!),
          (previous, next) {
        if (next is AcceptAnswerLoadingState) {
          context.loaderOverlay.show();
        } else {
          if (context.loaderOverlay.visible) {
            context.loaderOverlay.hide();
          }
        }
      });
    } else {
      ref.addErrorListener(
        provider: likeProvider(_likeProviderParams!),
        context: context,
      );
    }

    EdgeInsets footerElementsPadding =
        EdgeInsets.only(top: 6.h, left: 3.w, right: 3.w);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        10.horizontalSpace,
        if (!hideFirstButton) ...[
          _buildLikeButton(),
          20.horizontalSpace,
        ],
        TextButton(
          onPressed: widget.onPressingReply,
          style: TextButtonStyleManager.interactionFooterButton,
          child: Text(LocaleKeys.reply.tr(), style: TextStyleManager.s13w700),
        ),
        20.horizontalSpace,
        Padding(
          padding: footerElementsPadding,
          child: Text(
            footerDate(context),
            style: TextStyleManager.s13w400.copyWith(
              color: ColorManager.grey,
            ),
          ),
        )
      ],
    );
  }

  TextButton _buildLikeButton() {
    bool liked;
    if (acceptAnswerMode) {
      liked = ref
          .watch(acceptAnswerProvider(_acceptAnswerProviderParams!))
          .isAccepted;
    } else {
      liked = ref.watch(likeProvider(_likeProviderParams!)).isLiked;
    }
    Color color = liked ? ColorManager.blue : ColorManager.black;
    return TextButton(
      onPressed: _onPressingFirstButton,
      style: TextButtonStyleManager.interactionFooterButton.copyWith(
        foregroundColor: MaterialStateProperty.all(color),
      ),
      child: Text(firstButtonText, style: TextStyleManager.s13w700),
    );
  }
}
