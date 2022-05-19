import 'package:equatable/equatable.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';

class Post extends Equatable {
  final String id;
  const Post({
    required this.id,
  });

  PostType get postType {
    if (this is PhoneReview) return PostType.phoneReview;
    if (this is CompanyReview) return PostType.companyReview;
    Question question = this as Question;
    if (question.type == TargetType.phone) return PostType.phoneQuestion;
    return PostType.companyQuestion;
  }

  @override
  List<Object?> get props => [id];
}
