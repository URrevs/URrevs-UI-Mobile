import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:urrevs_ui_mobile/data/requests/base_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/companies_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/leaderboard_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/questions_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/reports_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/reviews_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/search_api_requests.dart';
import 'package:urrevs_ui_mobile/data/requests/users_api_requests.dart';
import 'package:urrevs_ui_mobile/data/responses/base_response.dart';
import 'package:urrevs_ui_mobile/data/responses/companies_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/leaderboard_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/misc_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/phones_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/questions_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/reports_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/reviews_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/search_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/update_api_responses.dart';
import 'package:urrevs_ui_mobile/data/responses/users_api_response.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';

part 'remote_data_source.g.dart';

@RestApi(baseUrl: StringsManager.currentBackendApi)
abstract class RemoteDataSource {
  factory RemoteDataSource(Dio dio, {String baseUrl}) = _RemoteDataSource;

  // USERS API

  @GET('/users/authenticate')
  Future<AuthenticationResponse> authenticate(
    @Header('authorization') String authorizationHeader,
  );

  @PUT('/users/login/mobile')
  Future<GivePointsToUserResponse> givePointsToUser();

  @GET('/users/logout')
  Future<StatusResponse> logoutFromAllDevices();

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

  @GET('/search/products')
  Future<SearchProductsResponse> searchProducts(
    @Query('q') String searchWord,
  );

  @GET('/search/products/phones')
  Future<SearchPhonesResponse> searchPhones(
    @Query('q') String searchWord,
  );

  /// 16
  @GET('/companies/{companyId}/stats')
  Future<GetCompanyStatisticalInfoResponse> getCompanyStatisticalInfo(
    @Path() String companyId,
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

  @GET('/reviews/company/on/{companyId}')
  Future<GetReviewsOnCertainCompanyResponse> getReviewsOnCertainCompany(
    @Path() String companyId,
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

  @POST('/reviews/phone/{reviewId}/hate')
  Future<IDontLikeThisForPhoneReviewResponse> iDontLikeThisForPhoneReview(
    @Path() String reviewId,
  );

  @POST('/reviews/company/{reviewId}/hate')
  Future<IDontLikeThisForCompanyReviewResponse> iDontLikeThisForCompanyReview(
    @Path() String reviewId,
  );

  @PUT('/reviews/phone/{reviewId}/view')
  Future<IncreaseViewCountForPhoneReviewResponse>
      increaseViewCountForPhoneReview(
    @Path() String reviewId,
  );

  @PUT('/reviews/company/{reviewId}/view')
  Future<IncreaseViewCountForCompanyReviewResponse>
      increaseViewCountForCompanyReview(
    @Path() String reviewId,
  );

  @PUT('/reviews/phone/{reviewId}/share')
  Future<IncreaseShareCountForPhoneReviewResponse>
      increaseShareCountForPhoneReview(
    @Path() String reviewId,
  );

  @PUT('/reviews/company/{reviewId}/share')
  Future<IncreaseShareCountForCompanyReviewResponse>
      increaseShareCountForCompanyReview(
    @Path() String reviewId,
  );

  @POST('/reviews/phone/{reviewId}/seemore')
  Future<UserPressesSeeMoreInPhoneReviewResponse>
      userPressesSeeMoreInPhoneReview(
    @Path() String reviewId,
  );

  @POST('/reviews/company/{reviewId}/seemore')
  Future<UserPressesSeeMoreInCompanyReviewResponse>
      userPressesSeeMoreInCompanyReview(
    @Path() String reviewId,
  );

  @POST('/reviews/phone/{reviewId}/fullscreen')
  Future<UserPressesFullscreenInPhoneReviewResponse>
      userPressesFullscreenInPhoneReview(
    @Path() String reviewId,
  );

  @POST('/reviews/company/{reviewId}/fullscreen')
  Future<UserPressesFullscreenInCompanyReviewResponse>
      userPressesFullscreenInCompanyReview(
    @Path() String reviewId,
  );

  @POST('/questions/phone')
  Future<AddPhoneQuestionResponse> addPhoneQuestion(
    @Body() AddPhoneQuestionRequest request,
  );

  @POST('/questions/company')
  Future<AddCompanyQuestionResponse> addCompanyQuestion(
    @Body() AddCompanyQuestionRequest request,
  );

  @GET('/questions/phone/{questionId}')
  Future<GetPhoneQuestionResponse> getPhoneQuestion(
    @Path() String questionId,
  );

  @GET('/questions/company/{questionId}')
  Future<GetPhoneQuestionResponse> getCompanyQuestion(
    @Path() String questionId,
  );

  @GET('/questions/phone/by/me')
  Future<GetMyPhoneQuestionsResponse> getMyPhoneQuestions(
    @Query('round') int round,
  );

  @GET('/questions/company/by/me')
  Future<GetMyCompanyQuestionsResponse> getMyCompanyQuestions(
    @Query('round') int round,
  );

  @GET('/questions/phone/by/{userId}')
  Future<GetPhoneQuestionsOfAnotherUser> getPhoneQuestionsOfAnotherUser(
    @Path() String userId,
    @Query('round') int round,
  );

  @GET('/questions/company/by/{userId}')
  Future<GetCompanyQuestionsOfAnotherUser> getCompanyQuestionsOfAnotherUser(
    @Path() String userId,
    @Query('round') int round,
  );

  @GET('/questions/phone/owned/by/me')
  Future<GetQuestionsAboutMyOwnedPhonesResponse> getQuestionsAboutMyOwnedPhones(
    @Query('round') int round,
  );

  @GET('/questions/phone/on/{phoneId}')
  Future<GetQuestionsOnCertainPhoneResponse> getQuestionsOnCertainPhone(
    @Path() String phoneId,
    @Query('round') int round,
  );

  @GET('/questions/company/on/{companyId}')
  Future<GetQuestionsOnCertainCompanyResponse> getQuestionsOnCertainCompany(
    @Path() String companyId,
    @Query('round') int round,
  );

  /// 74
  @POST('/questions/phone/{questionId}/like')
  Future<UpvotePhoneQuestionResponse> upvotePhoneQuestion(
    @Path() String questionId,
  );

  @POST('/questions/phone/{questionId}/unlike')
  Future<DownvotePhoneQuestionResponse> downvotePhoneQuestion(
    @Path() String questionId,
  );

  @POST('/questions/company/{questionId}/like')
  Future<UpvoteCompanyQuestionResponse> upvoteCompanyQuestion(
    @Path() String questionId,
  );

  @POST('/questions/company/{questionId}/unlike')
  Future<DownvoteCompanyQuestionResponse> downvoteCompanyQuestion(
    @Path() String questionId,
  );

  @GET('/questions/phone/{questionId}/answers')
  Future<GetAnswersAndRepliesForPhoneQuestionResponse>
      getAnswersAndRepliesForPhoneQuestion(
    @Path() String questionId,
    @Query('round') int round,
  );

  @GET('/questions/company/{questionId}/answers')
  Future<GetAnswersAndRepliesForCompanyQuestionResponse>
      getAnswersAndRepliesForCompanyQuestion(
    @Path() String questionId,
    @Query('round') int round,
  );

  /// 80
  @POST('/questions/phone/{questionId}/answers')
  Future<AddAnswerToPhoneQuestionResponse> addAnswerToPhoneQuestion(
    @Path() String questionId,
    @Body() AddInteractionRequest request,
  );

  @POST('/questions/company/{questionId}/answers')
  Future<AddAnswerToCompanyQuestionResponse> addAnswerToCompanyQuestion(
    @Path() String questionId,
    @Body() AddInteractionRequest request,
  );

  @POST('/questions/phone/answers/{answerId}/replies')
  Future<AddReplyToPhoneQuestionAnswerResponse> addReplyToPhoneQuestionAnswer(
    @Path() String answerId,
    @Body() AddInteractionRequest request,
  );

  @POST('/questions/company/answers/{answerId}/replies')
  Future<AddReplyToCompanyQuestionAnswerResponse>
      addReplyToCompanyQuestionAnswer(
    @Path() String answerId,
    @Body() AddInteractionRequest request,
  );

  @POST('/questions/phone/answers/{answerId}/like')
  Future<BaseResponse> upvotePhoneQuestionAnswer(
    @Path() String answerId,
  );
  @POST('/questions/phone/answers/{answerId}/unlike')
  Future<BaseResponse> downvotePhoneQuestionAnswer(
    @Path() String answerId,
  );
  @POST('/questions/company/answers/{answerId}/like')
  Future<BaseResponse> upvoteCompanyQuestionAnswer(
    @Path() String answerId,
  );
  @POST('/questions/company/answers/{answerId}/unlike')
  Future<BaseResponse> downvoteCompanyQuestionAnswer(
    @Path() String answerId,
  );
  @POST('/questions/phone/answers/{answerId}/replies/{replyId}/like')
  Future<BaseResponse> likePhoneQuestionReply(
    @Path() String answerId,
    @Path() String replyId,
  );
  @POST('/questions/phone/answers/{answerId}/replies/{replyId}/unlike')
  Future<BaseResponse> unlikePhoneQuestionReply(
    @Path() String answerId,
    @Path() String replyId,
  );
  @POST('/questions/company/answers/{answerId}/replies/{replyId}/like')
  Future<BaseResponse> likeCompanyQuestionReply(
    @Path() String answerId,
    @Path() String replyId,
  );
  @POST('/questions/company/answers/{answerId}/replies/{replyId}/unlike')
  Future<BaseResponse> unlikeCompanyQuestionReply(
    @Path() String answerId,
    @Path() String replyId,
  );

  @POST('/questions/phone/{questionId}/hate')
  Future<BaseResponse> iDontLikeThisForPhoneQuestion(
    @Path() String questionId,
  );

  @POST('/questions/company/{questionId}/hate')
  Future<BaseResponse> iDontLikeThisForCompanyQuestion(
    @Path() String questionId,
  );

  /// 94
  @POST('/questions/phone/{questionId}/answers/{answerId}/accept')
  Future<MarkAnswerAsAcceptedForPhoneResponse> markAnswerAsAcceptedForPhone(
    @Path() String questionId,
    @Path() String answerId,
  );

  @POST('/questions/company/{questionId}/answers/{answerId}/accept')
  Future<MarkAnswerAsAcceptedForCompanyResponse> markAnswerAsAcceptedForCompany(
    @Path() String questionId,
    @Path() String answerId,
  );

  @POST('/questions/phone/{questionId}/answers/{answerId}/reject')
  Future<UnmarkAnswerAsAcceptedForPhoneResponse> unmarkAnswerAsAcceptedForPhone(
    @Path() String questionId,
    @Path() String answerId,
  );

  @POST('/questions/company/{questionId}/answers/{answerId}/reject')
  Future<UnmarkAnswerAsAcceptedForCompanyResponse>
      unmarkAnswerAsAcceptedForCompany(
    @Path() String questionId,
    @Path() String answerId,
  );

  @PUT('/questions/phone/{questionId}/share')
  Future<BaseResponse> increaseShareCountForPhoneQuestion(
    @Path() String questionId,
  );

  @PUT('/questions/company/{questionId}/share')
  Future<BaseResponse> increaseShareCountForCompanyQuestion(
    @Path() String questionId,
  );

  @POST('/questions/phone/{questionId}/fullscreen')
  Future<BaseResponse> userPressesFullscreenInPhoneQuestion(
    @Path() String questionId,
  );

  @POST('/questions/company/{questionId}/fullscreen')
  Future<BaseResponse> userPressesFullscreenInCompanyQuestion(
    @Path() String questionId,
  );

  @POST('/competitions/')
  Future<AddCompetitionResponse> addCompetition(
    @Body() AddCompetitionRequest request,
  );

  @GET('/competitions/latest')
  Future<GetLatestCompetitionResponse> getLatestCompetition();

  @GET('/competitions/top')
  Future<GetTopUsersInCompetitionResponse> getTopUsersInCompetition();

  @GET('/competitions/rank')
  Future<GetMyRankInCompetitionResponse> getMyRankInCompetition();

  @GET('/home/recommended')
  Future<GetPostsForHomeScreenResponse> getPostsForHomeScreen();

  // REPORTS API
  @POST('/reports/review/phone/{reviewId}')
  Future<BaseResponse> reportPhoneReview(
    @Path() String reviewId,
    @Body() ReportSocialItemRequest request,
  );
  @POST('/reports/review/company/{reviewId}')
  Future<BaseResponse> reportCompanyReview(
    @Path() String reviewId,
    @Body() ReportSocialItemRequest request,
  );
  @POST('/reports/question/phone/{questionId}')
  Future<BaseResponse> reportPhoneQuestion(
    @Path() String questionId,
    @Body() ReportSocialItemRequest request,
  );
  @POST('/reports/question/company/{questionId}')
  Future<BaseResponse> reportCompanyQuestion(
    @Path() String questionId,
    @Body() ReportSocialItemRequest request,
  );
  @POST('/reports/review/phone/{reviewId}/comments/{commentId}')
  Future<BaseResponse> reportPhoneReviewComment(
    @Path() String reviewId,
    @Path() String commentId,
    @Body() ReportSocialItemRequest request,
  );
  @POST('/reports/review/company/{reviewId}/comments/{commentId}')
  Future<BaseResponse> reportCompanyReviewComment(
    @Path() String reviewId,
    @Path() String commentId,
    @Body() ReportSocialItemRequest request,
  );
  @POST('/reports/question/phone/{questionId}/answers/{answerId}')
  Future<BaseResponse> reportPhoneQuestionAnswer(
    @Path() String questionId,
    @Path() String answerId,
    @Body() ReportSocialItemRequest request,
  );
  @POST('/reports/question/company/{questionId}/answers/{answerId}')
  Future<BaseResponse> reportCompanyQuestionAnswer(
    @Path() String questionId,
    @Path() String answerId,
    @Body() ReportSocialItemRequest request,
  );
  @POST(
      '/reports/review/phone/{reviewId}/comments/{commentId}/replies/{replyId}')
  Future<BaseResponse> reportPhoneReviewCommentReply(
    @Path() String reviewId,
    @Path() String commentId,
    @Path() String replyId,
    @Body() ReportSocialItemRequest request,
  );
  @POST(
      '/reports/review/company/{reviewId}/comments/{commentId}/replies/{replyId}')
  Future<BaseResponse> reportCompanyReviewCommentReply(
    @Path() String reviewId,
    @Path() String commentId,
    @Path() String replyId,
    @Body() ReportSocialItemRequest request,
  );
  @POST(
      '/reports/question/phone/{questionId}/answers/{answerId}/replies/{replyId}')
  Future<BaseResponse> reportPhoneQuestionAnswerReply(
    @Path() String questionId,
    @Path() String answerId,
    @Path() String replyId,
    @Body() ReportSocialItemRequest request,
  );
  @POST(
      '/reports/question/company/{questionId}/answers/{answerId}/replies/{replyId}')
  Future<BaseResponse> reportCompanyQuestionAnswerReply(
    @Path() String questionId,
    @Path() String answerId,
    @Path() String replyId,
    @Body() ReportSocialItemRequest request,
  );

  @PUT('/users/{userId}/block/all')
  Future<BaseResponse> blockUser(
    @Path() String userId,
  );
  @PUT('/users/{userId}/unblock/all')
  Future<BaseResponse> unblockUser(
    @Path() String userId,
  );

  @PUT('/reviews/phone/{reviewId}/hide')
  Future<BaseResponse> hidePhoneReview(
    @Path() String reviewId,
  );
  @PUT('/reviews/company/{reviewId}/hide')
  Future<BaseResponse> hideCompanyReview(
    @Path() String reviewId,
  );
  @PUT('/reviews/phone/{reviewId}/unhide')
  Future<BaseResponse> unhidePhoneReview(
    @Path() String reviewId,
  );
  @PUT('/reviews/company/{reviewId}/unhide')
  Future<BaseResponse> unhideCompanyReview(
    @Path() String reviewId,
  );
  @PUT('/questions/phone/{questionId}/hide')
  Future<BaseResponse> hidePhoneQuestion(
    @Path() String questionId,
  );
  @PUT('/questions/company/{questionId}/hide')
  Future<BaseResponse> hideCompanyQuestion(
    @Path() String questionId,
  );
  @PUT('/questions/phone/{questionId}/unhide')
  Future<BaseResponse> unhidePhoneQuestion(
    @Path() String questionId,
  );
  @PUT('/questions/company/{questionId}/unhide')
  Future<BaseResponse> unhideCompanyQuestion(
    @Path() String questionId,
  );
  @PUT('/reviews/phone/comments/{commentId}/hide')
  Future<BaseResponse> hidePhoneReviewComment(
    @Path() String commentId,
  );
  @PUT('/reviews/company/comments/{commentId}/hide')
  Future<BaseResponse> hideCompanyReviewComment(
    @Path() String commentId,
  );
  @PUT('/reviews/phone/comments/{commentId}/unhide')
  Future<BaseResponse> unhidePhoneReviewComment(
    @Path() String commentId,
  );
  @PUT('/reviews/company/comments/{commentId}/unhide')
  Future<BaseResponse> unhideCompanyReviewComment(
    @Path() String commentId,
  );
  @PUT('/questions/phone/answers/{answerId}/hide')
  Future<BaseResponse> hidePhoneQuestionAnswer(
    @Path() String answerId,
  );
  @PUT('/questions/company/answers/{answerId}/hide')
  Future<BaseResponse> hideCompanyQuestionAnswer(
    @Path() String answerId,
  );
  @PUT('/questions/phone/answers/{answerId}/unhide')
  Future<BaseResponse> unhidePhoneQuestionAnswer(
    @Path() String answerId,
  );
  @PUT('/questions/company/answers/{answerId}/unhide')
  Future<BaseResponse> unhideCompanyQuestionAnswer(
    @Path() String answerId,
  );
  @PUT('/reviews/phone/comments/{commentId}/replies/{replyId}/hide')
  Future<BaseResponse> hidePhoneReviewReply(
    @Path() String commentId,
    @Path() String replyId,
  );
  @PUT('/reviews/company/comments/{commentId}/replies/{replyId}/hide')
  Future<BaseResponse> hideCompanyReviewReply(
    @Path() String commentId,
    @Path() String replyId,
  );
  @PUT('/questions/phone/answers/{answerId}/replies/{replyId}/hide')
  Future<BaseResponse> hidePhoneQuestionReply(
    @Path() String answerId,
    @Path() String replyId,
  );
  @PUT('/questions/company/answers/{answerId}/replies/{replyId}/hide')
  Future<BaseResponse> hideCompanyQuestionReply(
    @Path() String answerId,
    @Path() String replyId,
  );
  @PUT('/reviews/phone/comments/{commentId}/replies/{replyId}/unhide')
  Future<BaseResponse> unhidePhoneReviewReply(
    @Path() String commentId,
    @Path() String replyId,
  );
  @PUT('/reviews/company/comments/{commentId}/replies/{replyId}/unhide')
  Future<BaseResponse> unhideCompanyReviewReply(
    @Path() String commentId,
    @Path() String replyId,
  );
  @PUT('/questions/phone/answers/{answerId}/replies/{replyId}/unhide')
  Future<BaseResponse> unhidePhoneQuestionReply(
    @Path() String answerId,
    @Path() String replyId,
  );
  @PUT('/questions/company/answers/{answerId}/replies/{replyId}/unhide')
  Future<BaseResponse> unhideCompanyQuestionReply(
    @Path() String answerId,
    @Path() String replyId,
  );

  @GET('/reports/open')
  Future<GetReportsResponse> getOpenReports(
    @Query('round') int round,
  );

  @GET('/reports/closed')
  Future<GetReportsResponse> getClosedReports(
    @Query('round') int round,
  );

  @PUT('/reports/{reportId}/close')
  Future<BaseResponse> closeReport(
    @Path() String reportId,
  );

  @PUT('/reports/{reportId}/actions')
  Future<BaseResponse> updateReportState(
    @Path() String reportId,
    @Body() UpdateReportStateRequest request,
  );

  @GET('/reports/content/review/phone/{reviewId}')
  Future<GetPhoneReviewResponse> showReportPhoneReview(
    @Path() String reviewId,
  );
  @GET('/reports/content/review/company/{reviewId}')
  Future<GetCompanyReviewResponse> showReportCompanyReview(
    @Path() String reviewId,
  );

  @GET('/reports/content/review/phone/comments/{commentId}')
  Future<ShowReportCommentResponse> showReportPhoneReviewComment(
    @Path() String commentId,
  );
  @GET('/reports/content/review/company/comments/{commentId}')
  Future<ShowReportCommentResponse> showReportCompanyReviewComment(
    @Path() String commentId,
  );

  @GET('/reports/content/review/phone/comments/{commentId}/replies/{replyId}')
  Future<ShowReportReplyResponse> showReportPhoneReviewCommentReply(
    @Path() String commentId,
    @Path() String replyId,
  );
  @GET('/reports/content/review/company/comments/{commentId}/replies/{replyId}')
  Future<ShowReportReplyResponse> showReportCompanyReviewCommentReply(
    @Path() String commentId,
    @Path() String replyId,
  );

  @GET('/reports/content/question/phone/{questionId}')
  Future<GetPhoneQuestionResponse> showReportPhoneQuestion(
    @Path() String questionId,
  );
  @GET('/reports/content/question/company/{questionId}')
  Future<GetCompanyQuestionResponse> showReportCompanyQuestion(
    @Path() String questionId,
  );

  @GET('/reports/content/question/phone/answers/{answerId}')
  Future<ShowReportAnswerResponse> showReportPhoneQuestionAnswer(
    @Path() String answerId,
  );
  @GET('/reports/content/question/company/answers/{answerId}')
  Future<ShowReportAnswerResponse> showReportCompanyQuestionAnswer(
    @Path() String answerId,
  );

  @GET('/reports/content/question/phone/answers/{answerId}/replies/{replyId}')
  Future<ShowReportReplyResponse> showReportPhoneQuestionAnswerReply(
    @Path() String answerId,
    @Path() String replyId,
  );
  @GET('/reports/content/question/company/answers/{answerId}/replies/{replyId}')
  Future<ShowReportReplyResponse> showReportCompanyQuestionAnswerReply(
    @Path() String answerId,
    @Path() String replyId,
  );

  @GET('/reports/context/review/phone/{reviewId}/comments/{commentId}')
  Future<ShowReportPhoneReviewCommentContextResponse>
      showReportPhoneReviewCommentContext(
    @Path() String reviewId,
    @Path() String commentId,
  );

  @GET('/reports/context/review/company/{reviewId}/comments/{commentId}')
  Future<ShowReportCompanyReviewCommentContextResponse>
      showReportCompanyReviewCommentContext(
    @Path() String reviewId,
    @Path() String commentId,
  );

  @GET('/reports/context/question/phone/{questionId}/answers/{answerId}')
  Future<ShowReportAnswerContextResponse> showReportPhoneQuestionAnswerContext(
    @Path() String questionId,
    @Path() String answerId,
  );

  @GET('/reports/context/question/company/{questionId}/answers/{answerId}')
  Future<ShowReportAnswerContextResponse>
      showReportCompanyQuestionAnswerContext(
    @Path() String questionId,
    @Path() String answerId,
  );
}
