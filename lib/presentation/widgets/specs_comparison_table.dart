import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
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
          _companyName(firstSpecValue),
          _companyName(secondSpecValue),
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
    final bool isPrice = specName == LocaleKeys.price;
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
          firstProductName,
          TextDirection.ltr,
          TextStyleManager.s20w500,
        ),
        _specValue(
          secondProductName,
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
          TextStyleManager.s20w500,
        ),
        _organizedTableCell(
          child: _organizedProductImage(imageUrl: firstProductImageUrl),
        ),
        _organizedTableCell(
          child: _organizedProductImage(imageUrl: secondProductImageIrl),
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
          fit: BoxFit.cover,
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
  TableCell _companyName(String specValue) {
    return _organizedTableCell(
      child: TextButton(
        onPressed: _navigateToCompanyScreen,
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
  void _navigateToCompanyScreen() {}

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
    final List<String> specNames =
        firstProductSpecs.toMap(languageCode: languageCode).keys.toList();
    final List<String> firstProductSpecsValues =
        firstProductSpecs.toMap(languageCode: languageCode).values.toList();
    final List<String> secondProductSpecsValues =
        secondProductSpecs.toMap(languageCode: languageCode).values.toList();
    final borderSide = BorderSide(width: 0.2, color: ColorManager.black);

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
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(
          width: 1.2.sw,
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: ListView(
                children: [
                  _buildTable(context),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
