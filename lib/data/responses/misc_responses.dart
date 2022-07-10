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
  @JsonKey(name: 'total')
  List<String>? postsIds;

  GetPostsForHomeScreenResponse({
    required bool success,
    required this.phoneReviewsSubResponses,
    required this.companyReviewsSubResponses,
    required this.phoneQuestionsSubResponses,
    required this.companyQuestionsSubResponses,
    required this.postsIds,
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

    List<Post> allPosts = [
      ...phoneReviewModels,
      ...companyReviewModels,
      ...phoneQuestionsModels,
      ...companyQuestionModels
    ];

    // handle the case where total field is not sent
    // if (postsIds == null) {
    //   return allPosts..shuffle();
    // }

    List<Post> arrangedPosts = [];

    for (String id in postsIds!) {
      int index = allPosts.indexWhere((p) => p.id == id);
      if (index < 0) {
        continue; // for the case where some ids are not in allPosts
      }
      arrangedPosts.add(allPosts[index]);
      allPosts.removeAt(index);
    }
    // add remaining posts (in the case where some ids are not in allPosts)
    arrangedPosts.addAll(allPosts);

    return arrangedPosts;
  }

  factory GetPostsForHomeScreenResponse.fromJson(Map<String, Object?> json) =>
      _$GetPostsForHomeScreenResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$GetPostsForHomeScreenResponseToJson(this);
}

@JsonSerializable()
class VerifyResponse extends BaseResponse {
  double verificationRatio;
  VerifyResponse({
    required bool success,
    required this.verificationRatio,
  }) : super(success: success);

  factory VerifyResponse.fromJson(Map<String, Object?> json) =>
      _$VerifyResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$VerifyResponseToJson(this);
}
