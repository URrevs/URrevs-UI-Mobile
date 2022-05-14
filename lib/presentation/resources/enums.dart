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

enum PostType {
  phoneReview,
  companyReview,
  phoneQuestion,
  companyQuestion
} //phone question - company question

enum TargetType { phone, company }

enum InteractionType { comment, answer, reply }

enum SearchMode { productsAndCompanies, phones }

enum PostContentType { review, question }
