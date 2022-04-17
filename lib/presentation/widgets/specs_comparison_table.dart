import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/font_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/styles_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_table.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class SpecsComparisonTable extends StatelessWidget {
  final String firstProductName;
  final String secondProductName;
  final String firstProductImageUrl;
  final String secondProductImageIrl;
  final SpecsDummyData firstProductSpecs;
  final SpecsDummyData secondProductSpecs;

  const SpecsComparisonTable({
    Key? key,
    required this.firstProductName,
    required this.secondProductName,
    required this.firstProductImageUrl,
    required this.secondProductImageIrl,
    required this.firstProductSpecs,
    required this.secondProductSpecs,
  }) : super(key: key);

  static SpecsComparisonTable get dummyInstance => SpecsComparisonTable(
        firstProductName: 'Oppo Reno 6',
        secondProductName: 'Nokia plus',
        firstProductImageUrl: StringsManager.picsum200x200,
        secondProductImageIrl: StringsManager.picsum200x200,
        firstProductSpecs: SpecsDummyData.dummyData,
        secondProductSpecs: SpecsDummyData.dummyData,
      );

  /// Returns a [TableRow] that contains both the specification name and value
  /// of the phone.
  TableRow _tableRow({
    required String specName,
    required String firstSpecValue,
    required String secondSpecValue,
  }) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.2, color: ColorManager.black),
        ),
      ),
      children: <Widget>[
        _specName(specName),
        if (specName == LocaleKeys.manufacturingCompany) ...[
          _companyName(firstSpecValue),
          _companyName(secondSpecValue),
        ],
        if (specName != LocaleKeys.manufacturingCompany) ...[
          _specValue(firstSpecValue, specName),
          _specValue(secondSpecValue, specName),
        ],
      ],
    );
  }

  /// Returns a [TableCell] that contains the specification value of the phone.
  TableCell _specValue(String specValue, String specName) {
    final bool isPrice = specName == LocaleKeys.price;

    /// Always the text direction would be from left to right except in the case
    /// of price, the text direction would be left to be determined by the
    /// locale. This is because the price value is the only cell that contains
    /// both arabic letters and english numbers (in the arabic locale)
    final TextDirection? textDirection = isPrice ? null : TextDirection.ltr;
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Center(
          child: Text(
            specValue,
            textAlign: TextAlign.center,
            textDirection: textDirection,
            // TODO: use TextStyle manager
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeightManager.w400,
            ),
          ),
        ),
      ),
    );
  }

  /// Returns a [TableCell] that contains a [TextButton] navigating to the
  /// company profile screen.
  TableCell _companyName(String specValue) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: TextButton(
        onPressed: _navigateToCompanyScreen,
        child: Text(
          specValue,
          textAlign: TextAlign.center,
          // TODO: use TextStyle manager
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightManager.w900,
          ).copyWith(
            decoration: TextDecoration.underline,
            color: ColorManager.black,
          ),
        ),
      ),
    );
  }

  /// Navigates to company profile screen.
  void _navigateToCompanyScreen() {}

  /// Returns a [TableCell] that contains the name of the specification of the
  /// phone.
  TableCell _specName(String specName) {
    print('spec name rebuilt');
    print(TextStyleManager.s16w500);
    print(16.sp);
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Center(
          child: Text(
            specName.tr() + ":",
            textAlign: TextAlign.center,
            // TODO: use TextStyle manager
            style: TextStyleManager.s16w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String languageCode = context.locale.languageCode;
    final List<String> specNames =
        firstProductSpecs.toMap(languageCode: languageCode).keys.toList();
    final List<String> firstProductSpecsValues =
        firstProductSpecs.toMap(languageCode: languageCode).values.toList();
    final List<String> secondProductSpecsValues =
        secondProductSpecs.toMap(languageCode: languageCode).values.toList();

    EdgeInsets cardPadding = EdgeInsets.only(
      bottom: 15.h,
      top: 7.h,
      right: 16.w,
      left: 16.w,
    );

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: cardPadding,
        child: Table(
          children: [
            for (int i = 0; i < specNames.length; i++) ...[
              _tableRow(
                specName: specNames[i],
                firstSpecValue: firstProductSpecsValues[i],
                secondSpecValue: secondProductSpecsValues[i],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
