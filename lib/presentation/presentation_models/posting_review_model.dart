class PostingReviewModel {
  String productName;
  String companyName;
  DateTime usedSince;
  int generalRating;
  int manufacturingQuality;
  int userInterface;
  int priceQuality;
  int camera;
  int callsQuality;
  int battery;
  String whatUserLikedAboutProduct;
  String whatUserHatedAboutProduct;
  int companyRating;
  String whatUserLikedAboutCompany;
  String whatUserHatedAboutCompany;
  String invitationCode;
  PostingReviewModel({
    required this.productName,
    required this.companyName,
    required this.usedSince,
    required this.generalRating,
    required this.manufacturingQuality,
    required this.userInterface,
    required this.priceQuality,
    required this.camera,
    required this.callsQuality,
    required this.battery,
    required this.whatUserLikedAboutProduct,
    required this.whatUserHatedAboutProduct,
    required this.companyRating,
    required this.whatUserLikedAboutCompany,
    required this.whatUserHatedAboutCompany,
    required this.invitationCode,
  });
}
