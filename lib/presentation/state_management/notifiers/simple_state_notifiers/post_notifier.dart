import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/quesiton.dart';

class PostNotifier extends StateNotifier<Post> {
  /// Post would not be null as postProvider is first invoked by widgets showing
  /// posts which have the post itself and have to pass the post to the provider
  /// and thus to the notifier.
  ///
  /// The other cases where null is passed is when notifiers as likeNotifier
  /// wants to invoke a method in PostNotifier, so they pass null into post
  /// we don't want them to set the post - the post is already set by the
  /// widgets showing the post (ProductReviewCard - CompanyReviewCard -
  /// QuestionCard).
  PostNotifier({required Post? post}) : super(post!);

  void incrementLikes() {
    final post = state;
    if (post is PhoneReview) {
      state = post.copyWith(likes: post.likes + 1);
    } else if (post is CompanyReview) {
      state = post.copyWith(likes: post.likes + 1);
    } else if (post is Question) {
      state = post.copyWith(upvotes: post.upvotes + 1);
    }
  }

  void decrementLikes() {
    final post = state;
    if (post is PhoneReview) {
      if (post.likes > 0) state = post.copyWith(likes: post.likes - 1);
    } else if (post is CompanyReview) {
      if (post.likes > 0) state = post.copyWith(likes: post.likes - 1);
    } else if (post is Question) {
      if (post.upvotes > 0) state = post.copyWith(upvotes: post.upvotes - 1);
    }
  }

  void incrementComments() {
    final post = state;
    if (post is PhoneReview) {
      state = post.copyWith(commentsCount: post.commentsCount + 1);
    } else if (post is CompanyReview) {
      state = post.copyWith(commentsCount: post.commentsCount + 1);
    } else if (post is Question) {
      print('incremented answer count');
      state = post.copyWith(ansCount: post.ansCount + 1);
    }
  }

  void decrementComments() {
    final post = state;
    if (post is PhoneReview) {
      if (post.commentsCount > 0) {
        state = post.copyWith(commentsCount: post.commentsCount - 1);
      }
    } else if (post is CompanyReview) {
      if (post.commentsCount > 0) {
        state = post.copyWith(commentsCount: post.commentsCount - 1);
      }
    } else if (post is Question) {
      if (post.ansCount > 0) {
        state = post.copyWith(ansCount: post.ansCount - 1);
      }
    }
  }
}