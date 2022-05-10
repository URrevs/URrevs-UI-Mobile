import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/fields/search_text_field.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/custom_alert_dialog.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

import '../../resources/enums.dart';
import '../../state_management/providers_parameters.dart';

/// a prompt that navigates to specs compare screen to compare between 2 products

class CompareDialoge extends StatefulWidget {
  const CompareDialoge({
    Key? key,
    required this.searchCtl,
    required this.productName1,
  }) : super(key: key);

  /// The controller for the search field.
  final TextEditingController searchCtl;

  /// The name of the first product.
  final String productName1;
  @override
  State<CompareDialoge> createState() => _CompareDialogeState();
}

class _CompareDialogeState extends State<CompareDialoge> {
  final _formKey = GlobalKey<FormState>();
  final SearchProviderParams _searchProviderParams =
      SearchProviderParams(searchMode: SearchMode.phones);
  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: '',
      hasTitle: true,
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              LocaleKeys.compare.tr() +
                  ' ' +
                  widget.productName1 +
                  ' ' +
                  LocaleKeys.withWord.tr(),
              style: TextStyleManager.s18w500,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.h,
            ),
            SearchTextField(
              checkChosenSearchResult: false,
              searchCtl: widget.searchCtl,
              fillColor: ColorManager.backgroundGrey,
              hasErrorMsg: true,
              errorMsg: LocaleKeys.productNameErrorMsg.tr(),
              hintText: LocaleKeys.writeProductName.tr(),
              searchProviderParams: _searchProviderParams,
            ),
            SizedBox(
              height: 70.h,
            ),
            GradButton(
                text: Text(
                  LocaleKeys.compare.tr(),
                  style: TextStyleManager.s18w700,
                ),
                icon: Icon(
                  IconsManager.compare,
                  size: 28.sp,
                ),
                width: 310.w,
                reverseIcon: false,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
