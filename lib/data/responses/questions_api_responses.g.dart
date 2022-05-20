// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_api_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPhoneQuestionResponse _$AddPhoneQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    AddPhoneQuestionResponse(
      success: json['success'] as bool,
      questionSubResponse: PhoneQuestionSubResponse.fromJson(
          json['question'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddPhoneQuestionResponseToJson(
        AddPhoneQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'question': instance.questionSubResponse,
    };

AddCompanyQuestionResponse _$AddCompanyQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    AddCompanyQuestionResponse(
      success: json['success'] as bool,
      questionSubResponse: CompanyQuestionSubResponse.fromJson(
          json['question'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddCompanyQuestionResponseToJson(
        AddCompanyQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'question': instance.questionSubResponse,
    };

GetPhoneQuestionResponse _$GetPhoneQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    GetPhoneQuestionResponse(
      success: json['success'] as bool,
      questionSubResponse: QuestionSubResponse.fromJson(
          json['question'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPhoneQuestionResponseToJson(
        GetPhoneQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'question': instance.questionSubResponse,
    };

GetCompanyQuestionResponse _$GetCompanyQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    GetCompanyQuestionResponse(
      success: json['success'] as bool,
      questionSubResponse: QuestionSubResponse.fromJson(
          json['question'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCompanyQuestionResponseToJson(
        GetCompanyQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'question': instance.questionSubResponse,
    };

GetMyPhoneQuestionsResponse _$GetMyPhoneQuestionsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyPhoneQuestionsResponse(
      success: json['success'] as bool,
      questionsSubResponses: (json['questions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyPhoneQuestionsResponseToJson(
        GetMyPhoneQuestionsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questionsSubResponses,
    };

GetMyCompanyQuestionsResponse _$GetMyCompanyQuestionsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyCompanyQuestionsResponse(
      success: json['success'] as bool,
      questionsSubResponses: (json['questions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMyCompanyQuestionsResponseToJson(
        GetMyCompanyQuestionsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questionsSubResponses,
    };

GetPhoneQuestionsOfAnotherUser _$GetPhoneQuestionsOfAnotherUserFromJson(
        Map<String, dynamic> json) =>
    GetPhoneQuestionsOfAnotherUser(
      success: json['success'] as bool,
      questionsSubResponses: (json['questions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPhoneQuestionsOfAnotherUserToJson(
        GetPhoneQuestionsOfAnotherUser instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questionsSubResponses,
    };

GetCompanyQuestionsOfAnotherUser _$GetCompanyQuestionsOfAnotherUserFromJson(
        Map<String, dynamic> json) =>
    GetCompanyQuestionsOfAnotherUser(
      success: json['success'] as bool,
      questionsSubResponses: (json['questions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCompanyQuestionsOfAnotherUserToJson(
        GetCompanyQuestionsOfAnotherUser instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questionsSubResponses,
    };

GetQuestionsOnCertainPhoneResponse _$GetQuestionsOnCertainPhoneResponseFromJson(
        Map<String, dynamic> json) =>
    GetQuestionsOnCertainPhoneResponse(
      success: json['success'] as bool,
      questionsSubResponses: (json['questions'] as List<dynamic>)
          .map((e) => QuestionSubResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetQuestionsOnCertainPhoneResponseToJson(
        GetQuestionsOnCertainPhoneResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questionsSubResponses,
    };

GetQuestionsOnCertainCompanyResponse
    _$GetQuestionsOnCertainCompanyResponseFromJson(Map<String, dynamic> json) =>
        GetQuestionsOnCertainCompanyResponse(
          success: json['success'] as bool,
          questionsSubResponses: (json['questions'] as List<dynamic>)
              .map((e) =>
                  QuestionSubResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetQuestionsOnCertainCompanyResponseToJson(
        GetQuestionsOnCertainCompanyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'questions': instance.questionsSubResponses,
    };

UpvotePhoneQuestionResponse _$UpvotePhoneQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    UpvotePhoneQuestionResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpvotePhoneQuestionResponseToJson(
        UpvotePhoneQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

DownvotePhoneQuestionResponse _$DownvotePhoneQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    DownvotePhoneQuestionResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$DownvotePhoneQuestionResponseToJson(
        DownvotePhoneQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

UpvoteCompanyQuestionResponse _$UpvoteCompanyQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    UpvoteCompanyQuestionResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpvoteCompanyQuestionResponseToJson(
        UpvoteCompanyQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

DownvoteCompanyQuestionResponse _$DownvoteCompanyQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    DownvoteCompanyQuestionResponse(
      success: json['success'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$DownvoteCompanyQuestionResponseToJson(
        DownvoteCompanyQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
    };

GetAnswersAndRepliesForPhoneQuestionResponse
    _$GetAnswersAndRepliesForPhoneQuestionResponseFromJson(
            Map<String, dynamic> json) =>
        GetAnswersAndRepliesForPhoneQuestionResponse(
          success: json['success'] as bool,
          answersSubResponses: (json['answers'] as List<dynamic>)
              .map((e) => AnswerSubResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetAnswersAndRepliesForPhoneQuestionResponseToJson(
        GetAnswersAndRepliesForPhoneQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'answers': instance.answersSubResponses,
    };

GetAnswersAndRepliesForCompanyQuestionResponse
    _$GetAnswersAndRepliesForCompanyQuestionResponseFromJson(
            Map<String, dynamic> json) =>
        GetAnswersAndRepliesForCompanyQuestionResponse(
          success: json['success'] as bool,
          answersSubResponses: (json['answers'] as List<dynamic>)
              .map((e) => AnswerSubResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$GetAnswersAndRepliesForCompanyQuestionResponseToJson(
        GetAnswersAndRepliesForCompanyQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'answers': instance.answersSubResponses,
    };

AddAnswerToPhoneQuestionResponse _$AddAnswerToPhoneQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    AddAnswerToPhoneQuestionResponse(
      success: json['success'] as bool,
      answerId: json['answer'] as String,
    );

Map<String, dynamic> _$AddAnswerToPhoneQuestionResponseToJson(
        AddAnswerToPhoneQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'answer': instance.answerId,
    };

AddAnswerToCompanyQuestionResponse _$AddAnswerToCompanyQuestionResponseFromJson(
        Map<String, dynamic> json) =>
    AddAnswerToCompanyQuestionResponse(
      success: json['success'] as bool,
      answerId: json['answer'] as String,
    );

Map<String, dynamic> _$AddAnswerToCompanyQuestionResponseToJson(
        AddAnswerToCompanyQuestionResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'answer': instance.answerId,
    };

AddReplyToPhoneQuestionAnswerResponse
    _$AddReplyToPhoneQuestionAnswerResponseFromJson(
            Map<String, dynamic> json) =>
        AddReplyToPhoneQuestionAnswerResponse(
          success: json['success'] as bool,
          replyId: json['reply'] as String,
        );

Map<String, dynamic> _$AddReplyToPhoneQuestionAnswerResponseToJson(
        AddReplyToPhoneQuestionAnswerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reply': instance.replyId,
    };

AddReplyToCompanyQuestionAnswerResponse
    _$AddReplyToCompanyQuestionAnswerResponseFromJson(
            Map<String, dynamic> json) =>
        AddReplyToCompanyQuestionAnswerResponse(
          success: json['success'] as bool,
          replyId: json['reply'] as String,
        );

Map<String, dynamic> _$AddReplyToCompanyQuestionAnswerResponseToJson(
        AddReplyToCompanyQuestionAnswerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'reply': instance.replyId,
    };

MarkAnswerAsAcceptedForPhoneResponse
    _$MarkAnswerAsAcceptedForPhoneResponseFromJson(Map<String, dynamic> json) =>
        MarkAnswerAsAcceptedForPhoneResponse(
          success: json['success'] as bool,
          id: json['_id'] as String,
        );

Map<String, dynamic> _$MarkAnswerAsAcceptedForPhoneResponseToJson(
        MarkAnswerAsAcceptedForPhoneResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      '_id': instance.id,
    };

MarkAnswerAsAcceptedForCompanyResponse
    _$MarkAnswerAsAcceptedForCompanyResponseFromJson(
            Map<String, dynamic> json) =>
        MarkAnswerAsAcceptedForCompanyResponse(
          success: json['success'] as bool,
          id: json['_id'] as String,
        );

Map<String, dynamic> _$MarkAnswerAsAcceptedForCompanyResponseToJson(
        MarkAnswerAsAcceptedForCompanyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      '_id': instance.id,
    };

UnmarkAnswerAsAcceptedForPhoneResponse
    _$UnmarkAnswerAsAcceptedForPhoneResponseFromJson(
            Map<String, dynamic> json) =>
        UnmarkAnswerAsAcceptedForPhoneResponse(
          success: json['success'] as bool,
          id: json['_id'] as String,
        );

Map<String, dynamic> _$UnmarkAnswerAsAcceptedForPhoneResponseToJson(
        UnmarkAnswerAsAcceptedForPhoneResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      '_id': instance.id,
    };

UnmarkAnswerAsAcceptedForCompanyResponse
    _$UnmarkAnswerAsAcceptedForCompanyResponseFromJson(
            Map<String, dynamic> json) =>
        UnmarkAnswerAsAcceptedForCompanyResponse(
          success: json['success'] as bool,
          id: json['_id'] as String,
        );

Map<String, dynamic> _$UnmarkAnswerAsAcceptedForCompanyResponseToJson(
        UnmarkAnswerAsAcceptedForCompanyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      '_id': instance.id,
    };
