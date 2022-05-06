import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/presentation_models/posting_review_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/search_text_field.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

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
    return ListView(
      padding: AppEdgeInsets.screenPadding,
      addAutomaticKeepAlives: false,
      cacheExtent: 100,
      children: [
        Text(LocaleKeys.chooseProduct.tr() + ':',
            style: TextStyleManager.s18w700),
            SearchTextField(searchCtl: productNameController, fillColor: ColorManager.textFieldGrey,),

      ]
    );
  }
}
