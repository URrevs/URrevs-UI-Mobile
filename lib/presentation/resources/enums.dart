import 'package:easy_localization/easy_localization.dart';

enum CardType {
  productReview,
  companyReview,
  productQuestion,
  companyQuestion,
  comment,
  answer,
  reply
}

enum ReviewsFilter { phones, companies }

enum PostType { phoneReview, companyReview, phoneQuestion, companyQuestion }

extension PostTypeExtension on PostType {
  String get translatedName => name.tr();

  TargetType get targetType {
    switch (this) {
      case PostType.phoneReview:
      case PostType.phoneQuestion:
        return TargetType.phone;
      case PostType.companyReview:
      case PostType.companyQuestion:
        return TargetType.company;
    }
  }

  PostContentType get postContentType {
    switch (this) {
      case PostType.phoneReview:
      case PostType.companyReview:
        return PostContentType.review;
      case PostType.phoneQuestion:
      case PostType.companyQuestion:
        return PostContentType.question;
    }
  }

  CardType get cardType {
    switch (this) {
      case PostType.phoneReview:
        return CardType.productReview;
      case PostType.companyReview:
        return CardType.companyReview;
      case PostType.phoneQuestion:
        return CardType.productQuestion;
      case PostType.companyQuestion:
        return CardType.companyQuestion;
    }
  }

  static PostType? parse(String postTypeStr) {
    switch (postTypeStr) {
      case 'phoneReview':
        return PostType.phoneReview;
      case 'companyReview':
        return PostType.companyReview;
      case 'phoneQuestion':
        return PostType.phoneQuestion;
      case 'companyQuestion':
        return PostType.companyQuestion;
      default:
        return null;
    }
  }
}

enum TargetType { phone, company }

enum InteractionType { comment, answer, reply }

enum SearchMode { productsAndCompanies, products, phones }

enum PostContentType { review, question }

enum PostsListType { user, target, home, questionsOnMyOwnedPhones }

enum LinkType { post, refCode }

extension LinkTypeExtension on LinkType {
  static LinkType? parse(String linkTypeStr) {
    switch (linkTypeStr) {
      case 'post':
        return LinkType.post;
      case 'refCode':
        return LinkType.refCode;
      default:
        return null;
    }
  }
}

enum ComplaintReason {
  spam,
  violentContent,
  harassment,
  hateContent,
  nudity,
  other
}

extension ComplaintReasonExtension on ComplaintReason {
  int get indexForRequest => index + 1;

  String get translatedName => name.tr();
}

enum ReportType {
  phoneReview,
  companyReview,
  phoneQuestion,
  companyQuestion,
  phoneComment,
  companyComment,
  phoneAnswer,
  companyAnswer,
  phoneCommentReply,
  companyCommentReply,
  phoneAnswerReply,
  companyAnswerReply,
}

extension ReportTypeExtension on ReportType {
  String get translatedName => name.tr();
}

enum ReportStatus { open, closed }
