import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/presentation_models/posting_question_model.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/search_text_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/txt_field.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../../../../../state_management/providers_parameters.dart';

class PostingQuestionSubscreen extends StatefulWidget {
  const PostingQuestionSubscreen({Key? key}) : super(key: key);

  @override
  State<PostingQuestionSubscreen> createState() =>
      _PostingQuestionSubscreenState();
}

class _PostingQuestionSubscreenState extends State<PostingQuestionSubscreen> {
  final SearchProviderParams _searchProviderParams =
      SearchProviderParams(searchMode: SearchMode.phones);

  PostingQuestionModel postingQuestionModel =
      PostingQuestionModel(productName: '', question: '');

  late TextEditingController productNameController;
  late TextEditingController questionController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    productNameController =
        TextEditingController(text: postingQuestionModel.productName);
    questionController =
        TextEditingController(text: postingQuestionModel.question);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: AppEdgeInsets.screenPadding.copyWith(bottom: 10.h),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(LocaleKeys.yourQuestionRegarding.tr(),
                style: TextStyleManager.s18w500),
            SearchTextField(
              checkChosenSearchResult: false,
              fillColor: ColorManager.textFieldGrey,
              searchProviderParams: _searchProviderParams,
              searchCtl: productNameController,
              hasErrorMsg: true,
              hintText: LocaleKeys.writeTheNameOfProductOrCompany.tr(),
              errorMsg: LocaleKeys.productNameOrCompanyNameErrorMsg.tr(),
            ),
            SizedBox(height: 20.h),
            Text(LocaleKeys.writeYourQuestion.tr(),
                style: TextStyleManager.s18w500),
            TxtField(
              textController: questionController,
              hintText: LocaleKeys.question.tr(),
              keyboardType: TextInputType.text,
              fillColor: ColorManager.textFieldGrey,
              errorMsg: LocaleKeys.enterYourQuestionErrorMsg.tr(),
              hasErrorMsg: true,
            ),
            SizedBox(height: 30.h),
            GradButton(
                text: Text(
                  LocaleKeys.postQuestion.tr(),
                  style: TextStyleManager.s18w700,
                ),
                icon: Icon(IconsManager.add, size: 28.sp),
                width: 360.w,
                reverseIcon: false,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                }),
          ]),
        ));
  }
}
