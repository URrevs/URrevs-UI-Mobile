import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:urrevs_ui_mobile/data/requests/base_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/companies_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/search_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/users_api_requests.dart';
import 'package:urrevs_ui_mobile/data/responses/companies_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/phones_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/questions_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/reviews_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/search_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/update_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/users_api_response.dart';

part 'remote_data_source.g.dart';

@RestApi(baseUrl: 'https://urrevs-api-dev-mobile.herokuapp.com')
abstract class RemoteDataSource {
  factory RemoteDataSource(Dio dio, {String baseUrl}) = _RemoteDataSource;

  // USERS API

  @GET('/users/authenticate')
  Future<AuthenticationResponse> authenticate(
    @Header('authorization') String authorizationHeader,
  );

  @PUT('/users/login/mobile')
  Future<GivePointsToUserResponse> givePointsToUser(
    @Header('authorization') String authorizationHeader,
  );

  @GET('/users/profile')
  Future<GetMyProfileResponse> getMyProfile();

  @GET('/users/{userId}/profile')
  Future<GetTheProfileOfAnotherUserResponse> getTheProfileOfAnotherUser(
    @Path() String userId,
  );

  @GET('/users/phones')
  Future<GetMyOwnedPhonesResponse> getMyOwnedPhones(
    @Query('round') int round,
  );

  @GET('/users/{userId}/phones')
  Future<GetMyOwnedPhonesResponse> getTheOwnedPhonesOfAnotherUser(
    @Path() String userId,
    @Query('round') int round,
  );

  // UPDATE API

  @GET('/targets/update')
  Future<UpdateTargetFromSourceResponse> updateTargetsFromSource();

  @GET('/targets/update/latest')
  Future<GetInfoAboutLatestUpdateResponse> getInfoAboutLatestUpdate();

  // SEARCH API

  /// 10
  @PUT('/search/recent')
  Future<AddNewRecentSearchResponse> addNewRecentSearch(
    @Body() AddNewRecentSearchRequest request,
  );

  /// 11
  @GET('/search/recent')
  Future<GetMyRecentSearchesResponse> getMyRecentSearches();

  @DELETE('/search/recent')
  Future<DeleteRecentSearchResponse> deleteRecentSearch(
    @Body() DeleteRecentSearchRequest request,
  );

  @GET('/search/all')
  Future<SearchProductsAndCompaiesResponse> searchProductsAndCompanies(
    @Query('q') String searchWord,
  );

  @GET('/search/products/phones')
  Future<SearchPhonesResponse> searchPhones(
    @Query('q') String searchWord,
  );

  /// 17
  @GET('/companies/all')
  Future<GetAllCompaniesResponse> getAllCompanies(
    @Query('round') int round,
  );

  @GET('/phones/all')
  Future<GetAllPhonesResponse> getAllPhones(
    @Query('round') int round,
  );

  @GET('/phones/by/{companyId}')
  Future<GetPhonesFromCertainCompanyResponse> getPhonesFromCertainCompany(
    @Path() String companyId,
    @Query('round') int round,
  );

  @GET('/phones/{phoneId}/company')
  Future<GetPhoneManufacturingCompanyResponse> getPhoneManufacturingCompany(
    @Path() String phoneId,
  );

  @GET('/phones/{phoneId}/specs')
  Future<GetPhoneSpecsResponse> getPhoneSpecs(
    @Path() String phoneId,
  );

  /// 22
  @GET('/phones/{phoneId}/stats')
  Future<GetPhoneStatisticalInfoResponse> getPhoneStatisticalInfo(
    @Path() String phoneId,
  );

  @PUT('/phones/{phoneId1}/compare/{phoneId2}')
  Future<IndicateUserComparedBetweenTwoPhonesResponse>
      indicateUserComparedBetweenTwoPhones(
    @Path() String phoneId1,
    @Path() String phoneId2,
  );

  @GET('/phones/{phoneId}/similar')
  Future<GetSimilarPhonesResponse> getSimilarPhones(
    @Path() String phoneId,
  );

  @POST('/reviews/phone')
  Future<AddPhoneReviewResponse> addPhoneReview(
    @Body() AddPhoneReviewRequest request,
  );

  /// 26
  @GET('/reviews/phone/{reviewId}')
  Future<GetPhoneReviewResponse> getPhoneReview(
    @Path() String reviewId,
  );

  @GET('/reviews/company/{reviewId}')
  Future<GetCompanyReviewResponse> getCompanyReview(
    @Path() String reviewId,
  );

  @GET('/reviews/phone/by/me')
  Future<GetMyPhoneReviewsResponse> getMyPhoneReviews(
    @Query('round') int round,
  );

  @GET('/reviews/phone/by/{userId}')
  Future<GetPhoneReviewsOfAnotherUserResponse> getPhoneReviewsOfAnotherUser(
    @Path() String userId,
    @Query('round') int round,
  );

  @GET('/reviews/company/by/me')
  Future<GetMyCompanyReviewsResponse> getMyCompanyReviews(
    @Query('round') int round,
  );

  @GET('/reviews/company/by/{userId}')
  Future<GetCompanyReviewsOfAnotherUserResponse> getCompanyReviewsOfAnotherUser(
    @Path() String userId,
    @Query('round') int round,
  );

  @GET('/reviews/phone/on/{phoneId}')
  Future<GetReviewsOnCertainPhoneResponse> getReviewsOnCertainPhone(
    @Path() String phoneId,
    @Query('round') int round,
  );

  @POST('/reviews/phone/{reviewId}/like')
  Future<LikePhoneReviewResponse> likePhoneReview(
    @Path() String reviewId,
  );

  @POST('/reviews/phone/{reviewId}/unlike')
  Future<UnlikePhoneReviewResponse> unlikePhoneReview(
    @Path() String reviewId,
  );

  @POST('/reviews/company/{reviewId}/like')
  Future<LikeCompanyReviewResponse> likeCompanyReview(
    @Path() String reviewId,
  );

  @POST('/reviews/company/{reviewId}/unlike')
  Future<UnlikeCompanyReviewResponse> unlikeCompanyReview(
    @Path() String reviewId,
  );

  /// 38
  @GET('/reviews/phone/{reviewId}/comments')
  Future<GetCommentsAndRepliesForPhoneReviewResponse>
      getCommentsAndRepliesForPhoneReview(
    @Path() String reviewId,
    @Query('round') int round,
  );

  @GET('/reviews/company/{reviewId}/comments')
  Future<GetCommentsAndRepliesForCompanyReviewResponse>
      getCommentsAndRepliesForCompanyReview(
    @Path() String reviewId,
    @Query('round') int round,
  );

  @POST('/reviews/phone/{reviewId}/comments')
  Future<AddCommentToPhoneReviewResponse> addCommentToPhoneReview(
    @Path() String reviewId,
    @Body() AddInteractionRequest request,
  );

  @POST('/reviews/company/{reviewId}/comments')
  Future<AddCommentToCompanyReviewResponse> addCommentToCompanyReview(
    @Path() String reviewId,
    @Body() AddInteractionRequest request,
  );

  @POST('/reviews/phone/comments/{commentId}/replies')
  Future<AddReplyToPhoneReviewCommentResponse> addReplyToPhoneReviewComment(
    @Path() String commentId,
    @Body() AddInteractionRequest request,
  );

  @POST('/reviews/company/comments/{commentId}/replies')
  Future<AddReplyToCompanyReviewCommentResponse> addReplyToCompanyReviewComment(
    @Path() String commentId,
    @Body() AddInteractionRequest request,
  );

  @POST('/reviews/phone/comments/{commentId}/like')
  Future<LikePhoneReviewCommentResponse> likePhoneReviewComment(
    @Path() String commentId,
  );

  @POST('/reviews/phone/comments/{commentId}/unlike')
  Future<UnlikePhoneReviewCommentResponse> unlikePhoneReviewComment(
    @Path() String commentId,
  );

  @POST('/reviews/company/comments/{commentId}/like')
  Future<LikeCompanyReviewCommentResponse> likeCompanyReviewComment(
    @Path() String commentId,
  );

  @POST('/reviews/company/comments/{commentId}/unlike')
  Future<UnlikeCompanyReviewCommentResponse> unlikeCompanyReviewComment(
    @Path() String commentId,
  );

  @POST('/reviews/phone/comments/{commentId}/replies/{replyId}/like')
  Future<LikePhoneReviewReplyResponse> likePhoneReviewReply(
    @Path() String commentId,
    @Path() String replyId,
  );

  @POST('/reviews/phone/comments/{commentId}/replies/{replyId}/unlike')
  Future<UnlikePhoneReviewReplyResponse> unlikePhoneReviewReply(
    @Path() String commentId,
    @Path() String replyId,
  );

  @POST('/reviews/company/comments/{commentId}/replies/{replyId}/like')
  Future<LikeCompanyReviewReplyResponse> likeCompanyReviewReply(
    @Path() String commentId,
    @Path() String replyId,
  );

  @POST('/reviews/company/comments/{commentId}/replies/{replyId}/unlike')
  Future<UnlikeCompanyReviewReplyResponse> unlikeCompanyReviewReply(
    @Path() String commentId,
    @Path() String replyId,
  );

  @GET('/questions/phone/{questionId}')
  Future<GetPhoneQuestionResponse> getPhoneQuestion(
    @Path() String questionId,
  );

  @GET('/questions/company/{questionId}')
  Future<GetPhoneQuestionResponse> getCompanyQuestion(
    @Path() String questionId,
  );

  @GET('/questions/phone/my')
  Future<GetMyPhoneQuestionsResponse> getMyPhoneQuestions(
    @Query('round') int round,
  );

  @GET('/questions/company/my')
  Future<GetMyCompanyQuestionsResponse> getMyCompanyQuestions(
    @Query('round') int round,
  );

  @GET('/questions/phone/{userId}')
  Future<GetPhoneQuestionsOfAnotherUser> getPhoneQuestionsOfAnotherUser(
    @Path() String userId,
    @Query('round') int round,
  );

  @GET('/questions/company/{userId}')
  Future<GetCompanyQuestionsOfAnotherUser> getCompanyQuestionsOfAnotherUser(
    @Path() String userId,
    @Query('round') int round,
  );

  /// 74
  @PUT('/questions/phone/{questionId}?action=upvote')
  Future<UpvotePhoneQuestionResponse> upvotePhoneQuestion(
    @Path() String questionId,
  );

  @PUT('/questions/phone/{questionId}?action=downvote')
  Future<DownvotePhoneQuestionResponse> downvotePhoneQuestion(
    @Path() String questionId,
  );

  @PUT('/questions/company/{questionId}?action=upvote')
  Future<UpvoteCompanyQuestionResponse> upvoteCompanyQuestion(
    @Path() String questionId,
  );

  @PUT('/questions/company/{questionId}?action=downvote')
  Future<DownvoteCompanyQuestionResponse> downvoteCompanyQuestion(
    @Path() String questionId,
  );
}
