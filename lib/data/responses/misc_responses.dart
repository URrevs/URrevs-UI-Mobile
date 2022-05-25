import 'package:json_annotation/json_annotation.dart';

import 'package:urrevs_ui_mobile/data/responses/sub_responses.dart';
import 'package:urrevs_ui_mobile/domain/models/company_review.dart';
import 'package:urrevs_ui_mobile/domain/models/phone_review.dart';
import 'package:urrevs_ui_mobile/domain/models/post.dart';
import 'package:urrevs_ui_mobile/domain/models/question.dart';

import 'base_response.dart';

part 'misc_responses.g.dart';

@JsonSerializable()
class GetPostsForHomeScreenResponse extends BaseResponse {
  @JsonKey(name: 'phoneRevs')
  List<PhoneReviewSubResponse> phoneReviewsSubResponses;
  @JsonKey(name: 'companyRevs')
  List<CompanyReviewSubResponse> companyReviewsSubResponses;
  @JsonKey(name: 'phoneQuestions')
  List<QuestionSubResponse> phoneQuestionsSubResponses;
  @JsonKey(name: 'companyQuestions')
  List<QuestionSubResponse> companyQuestionsSubResponses;

  GetPostsForHomeScreenResponse({
    required bool success,
    required this.phoneReviewsSubResponses,
    required this.companyReviewsSubResponses,
    required this.phoneQuestionsSubResponses,
    required this.companyQuestionsSubResponses,
  }) : super(success: success);

  List<Post> get postsModels {
    List<PhoneReview> phoneReviewModels =
        phoneReviewsSubResponses.map((pr) => pr.phoneReviewModel).toList();
    List<CompanyReview> companyReviewModels =
        companyReviewsSubResponses.map((cr) => cr.companyReviewModel).toList();
    List<Question> phoneQuestionsModels =
        phoneQuestionsSubResponses.map((pq) => pq.questionModel).toList();
    List<Question> companyQuestionModels =
        companyQuestionsSubResponses.map((cq) => cq.questionModel).toList();

    return [
      ...phoneReviewModels,
      ...companyReviewModels,
      ...phoneQuestionsModels,
      ...companyQuestionModels
    ];
  }

  factory GetPostsForHomeScreenResponse.fromJson(Map<String, Object?> json) =>
      _$GetPostsForHomeScreenResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetPostsForHomeScreenResponseToJson(this);
}
