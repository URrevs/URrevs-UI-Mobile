import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/specs.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/company_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';

import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class SpecsComparisonTable extends StatefulWidget {
  final String firstProductName;
  final String secondProductName;
  final String firstProductImageUrl;
  final String secondProductImageIrl;
  final Specs firstProductSpecs;
  final Specs secondProductSpecs;

  const SpecsComparisonTable({
    Key? key,
    required this.firstProductName,
    required this.secondProductName,
    required this.firstProductImageUrl,
    required this.secondProductImageIrl,
    required this.firstProductSpecs,
    required this.secondProductSpecs,
  }) : super(key: key);

  @override
  State<SpecsComparisonTable> createState() => _SpecsComparisonTableState();
}

class _SpecsComparisonTableState extends State<SpecsComparisonTable> {
  /// Returns a [TableRow] that contains both the specification name and value
  /// of that specification for both phones.
  TableRow _specsTableRow({
    required String specName,
    required String firstSpecValue,
    required String secondSpecValue,
  }) {
    return TableRow(
      children: <Widget>[
        _pointOfComparisonCell(specName.tr(), TextStyleManager.s16w500),
        if (specName == LocaleKeys.manufacturingCompany) ...[
          _companyName(firstSpecValue, widget.firstProductSpecs.companyId),
          _companyName(secondSpecValue, widget.secondProductSpecs.companyId),
        ],
        if (specName != LocaleKeys.manufacturingCompany) ...[
          _specValue(
            firstSpecValue,
            _getTextDirection(specName),
            TextStyleManager.s16w400,
          ),
          _specValue(
            secondSpecValue,
            _getTextDirection(specName),
            TextStyleManager.s16w400,
          ),
        ],
      ],
    );
  }

  /// Returns the suitable [TextDirection] corresponding to a specification
  /// name.
  ///
  /// Always the text direction would be from left to right except in the case
  /// of price, the text direction would be left to be determined by the
  /// locale. This is because the price value is the only cell that contains
  /// both arabic letters and english numbers (in the arabic locale).
  TextDirection? _getTextDirection(String specName) {
    final bool isPrice = specName == LocaleKeys.priceWhenReleased;
    final TextDirection? textDirection = isPrice ? null : TextDirection.ltr;
    return textDirection;
  }

  /// Returns a TableRow containing the names of the 2 products.
  TableRow _productsNamesRow() {
    return TableRow(
      children: <Widget>[
        _pointOfComparisonCell(
          LocaleKeys.productName.tr(),
          TextStyleManager.s20w500,
        ),
        _specValue(
          widget.firstProductName,
          TextDirection.ltr,
          TextStyleManager.s20w500,
        ),
        _specValue(
          widget.secondProductName,
          TextDirection.ltr,
          TextStyleManager.s20w500,
        ),
      ],
    );
  }

  /// Returns a table row containing the images of the two products.
  TableRow _productsImagesRow() {
    return TableRow(
      children: <Widget>[
        _pointOfComparisonCell(
          LocaleKeys.productImage.tr(),
          TextStyleManager.s16w500,
        ),
        _organizedTableCell(
          child: _organizedProductImage(imageUrl: widget.firstProductImageUrl),
        ),
        _organizedTableCell(
          child: _organizedProductImage(imageUrl: widget.secondProductImageIrl),
        ),
      ],
    );
  }

  /// Returns the product image after clipping and with the suitable size.
  SizedBox _organizedProductImage({required String imageUrl}) {
    return SizedBox(
      width: 115.w,
      height: 95.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Returns a [TableCell] that contains the specification value of the phone.
  TableCell _specValue(
    String specValue,
    TextDirection? textDirection,
    TextStyle textStyle,
  ) {
    return _organizedTableCell(
      child: Text(
        specValue,
        textAlign: TextAlign.center,
        textDirection: textDirection,
        style: textStyle,
      ),
    );
  }

  /// A wrapper method around a widget put in the cell
  TableCell _organizedTableCell({required Widget child}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Center(
          child: child,
        ),
      ),
    );
  }

  /// Returns a [TableCell] that contains a [TextButton] navigating to the
  /// company profile screen.
  TableCell _companyName(String specValue, String companyId) {
    return _organizedTableCell(
      child: TextButton(
        onPressed: () => _navigateToCompanyScreen(companyId, specValue),
        style: TextButtonStyleManager.specsCompanyName,
        child: Text(
          specValue,
          textAlign: TextAlign.center,
          style: TextStyleManager.s16w900.copyWith(
            decoration: TextDecoration.underline,
            color: ColorManager.black,
          ),
        ),
      ),
    );
  }

  /// Navigates to company profile screen.
  void _navigateToCompanyScreen(String companyId, String companyName) {
    Navigator.of(context).pushNamed(CompanyProfileScreen.routeName,
        arguments: CompanyProfileScreenArgs(
          companyId: companyId,
          companyName: companyName,
        ));
  }

  TableCell _pointOfComparisonCell(String text, TextStyle textStyle) {
    return _organizedTableCell(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: textStyle,
      ),
    );
  }

  /// Returns the table containing all the spcifications on the 2 products.
  Table _buildTable(BuildContext context) {
    final String languageCode = context.locale.languageCode;
    final List<String> specNames = widget.firstProductSpecs
        .toMap(languageCode: languageCode)
        .keys
        .toList();
    final List<String> firstProductSpecsValues = widget.firstProductSpecs
        .toMap(languageCode: languageCode)
        .values
        .toList();
    final List<String> secondProductSpecsValues = widget.secondProductSpecs
        .toMap(languageCode: languageCode)
        .values
        .toList();
    final borderSide = BorderSide(width: 1, color: ColorManager.dividerGrey);

    return Table(
      border: TableBorder(
        verticalInside: borderSide,
        horizontalInside: borderSide,
      ),
      children: [
        _productsNamesRow(),
        _productsImagesRow(),
        for (int i = 0; i < specNames.length; i++) ...[
          _specsTableRow(
            specName: specNames[i],
            firstSpecValue: firstProductSpecsValues[i],
            secondSpecValue: secondProductSpecsValues[i],
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh - MediaQuery.of(context).padding.top,
      child: ScrollConfiguration(
        behavior: NoGlowingScrollBehaviour(),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            SizedBox(
              width: 1.2.sw,
              child: Card(
                elevation: AppElevations.ev3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    children: [
                      _buildTable(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
