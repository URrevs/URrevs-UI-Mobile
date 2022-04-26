import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/presentation_models/posting_review_model.dart';

class PostingReviewSubscreen extends StatefulWidget {
  const PostingReviewSubscreen({Key? key}) : super(key: key);

  @override
  State<PostingReviewSubscreen> createState() => _PostingReviewSubscreenState();
}

class _PostingReviewSubscreenState extends State<PostingReviewSubscreen> {
  PostingReviewModel postingReviewModel = PostingReviewModel(
    productName: '',
    usedSince: DateTime.now(),
    generalRating: 3,
    manufacturingQuality: 3,
    priceQuality: 3,
    camera: 3,
    callsQuality: 3,
    battery: 3,
    whatUserLikedAboutProduct: '',
    whatUserHatedAboutProduct: '',
    companyRating: 3,
    whatUserLikedAboutCompany: '',
    whatUserHatedAboutCompany: '',
    invitationCode: '',
  );

  late TextEditingController productNameController;
  late TextEditingController likedAboutProductController;
  late TextEditingController hatedAboutProductController;
  late TextEditingController likedAboutCompanyController;
  late TextEditingController hatedAboutCompanyController;
  late TextEditingController invitationCodeController;

  @override
  void initState() {
    super.initState();
    productNameController =
        TextEditingController(text: postingReviewModel.productName);
    likedAboutProductController = TextEditingController(
        text: postingReviewModel.whatUserLikedAboutProduct);
    hatedAboutProductController = TextEditingController(
        text: postingReviewModel.whatUserHatedAboutProduct);
    likedAboutCompanyController = TextEditingController(
        text: postingReviewModel.whatUserLikedAboutCompany);
    hatedAboutCompanyController = TextEditingController(
        text: postingReviewModel.whatUserHatedAboutCompany);
    invitationCodeController =
        TextEditingController(text: postingReviewModel.invitationCode);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(controller: productNameController);
  }
}
