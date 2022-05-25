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
}

enum TargetType { phone, company }

enum InteractionType { comment, answer, reply }

enum SearchMode { productsAndCompanies, phones }

enum PostContentType { review, question }

enum PostsListType { user, target, home }
