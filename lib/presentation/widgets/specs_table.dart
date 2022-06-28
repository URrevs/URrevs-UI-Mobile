// ignore_for_file: non_constant_identifier_names

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/domain/models/specs.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_button_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/company_profile_screen.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class SpecsDummyData {
  int price;
  String manufacturingCompany;
  DateTime releaseDate;
  String productDimensions;
  String networkType;
  String productWeight;
  String simCard;
  String displayType;
  String displaySize;
  String displayResolution;
  String screenProtection;
  String operatingSystem;
  String chipset;
  String CPU;
  String GPU;
  String externalMemory;
  String internalMemory;
  String mainCamera;
  String frontCamera;
  String loudSpeakers;
  String jack3_5;
  String wlan;
  String bluetooth;
  String GPS;
  String NFC;
  String radio;
  String USB;
  String sensors;
  String battery;
  String charging;
  SpecsDummyData({
    required this.price,
    required this.manufacturingCompany,
    required this.releaseDate,
    required this.productDimensions,
    required this.networkType,
    required this.productWeight,
    required this.simCard,
    required this.displayType,
    required this.displaySize,
    required this.displayResolution,
    required this.screenProtection,
    required this.operatingSystem,
    required this.chipset,
    required this.CPU,
    required this.GPU,
    required this.externalMemory,
    required this.internalMemory,
    required this.mainCamera,
    required this.frontCamera,
    required this.loudSpeakers,
    required this.jack3_5,
    required this.wlan,
    required this.bluetooth,
    required this.GPS,
    required this.NFC,
    required this.radio,
    required this.USB,
    required this.sensors,
    required this.battery,
    required this.charging,
  });

  Map<String, String> toMap({required String languageCode}) {
    String strPrice = price.toString() + " " + LocaleKeys.egyptianPound.tr();
    String strReleaseDate = DateFormat.yMMMM(languageCode).format(releaseDate);
    return {
      LocaleKeys.priceWhenReleased: strPrice,
      LocaleKeys.manufacturingCompany: manufacturingCompany,
      LocaleKeys.releaseDate: strReleaseDate,
      LocaleKeys.productDimensions: productDimensions,
      LocaleKeys.networkType: networkType,
      LocaleKeys.productWeight: productWeight,
      LocaleKeys.simCard: simCard,
      LocaleKeys.displayType: displayType,
      LocaleKeys.displaySize: displaySize,
      LocaleKeys.displayResolution: displayResolution,
      LocaleKeys.screenProtection: screenProtection,
      LocaleKeys.operatingSystem: operatingSystem,
      LocaleKeys.chipset: chipset,
      LocaleKeys.CPU: CPU,
      LocaleKeys.GPU: GPU,
      LocaleKeys.externalMemory: externalMemory,
      LocaleKeys.internalMemory: internalMemory,
      LocaleKeys.mainCamera: mainCamera,
      LocaleKeys.frontCamera: frontCamera,
      LocaleKeys.loudSpeakers: loudSpeakers,
      LocaleKeys.jack3_5: jack3_5,
      LocaleKeys.wlan: wlan,
      LocaleKeys.bluetooth: bluetooth,
      LocaleKeys.GPS: GPS,
      LocaleKeys.NFC: NFC,
      LocaleKeys.radio: radio,
      LocaleKeys.USB: USB,
      LocaleKeys.sensors: sensors,
      LocaleKeys.battery: battery,
      LocaleKeys.charging: charging,
    };
  }

  static SpecsDummyData get dummyData => SpecsDummyData(
        price: 3400,
        manufacturingCompany: 'Nokia',
        releaseDate: DateTime(2018, 3),
        productDimensions: '158 x 75 x 8 mm',
        networkType: 'GSM / HSPA / LTE',
        productWeight: '181 gram',
        simCard: 'hybrid dual sim (nano-sim)',
        displayType: 'Super AMOLED, 120Hz, HDR10, 700 nits, 1200 nits (peak)',
        displaySize: '6.67 inches, 107.4 cm2 (~86.0% screen-to-body ratio)',
        displayResolution: '1080 x 2400 pixels, 20:9 ratio (~395 ppi density)',
        screenProtection: 'Corning Gorilla Glass 3',
        operatingSystem: 'Android 11, MIUI 12.5',
        chipset: 'MediaTek Helio G88 (12nm)',
        CPU: 'Octa-core (2x2.0 GHz Cortex-A75 & 6x1.8 GHz Cortex-A55)',
        GPU: 'Mali-G52 MC2',
        externalMemory: 'microSDXC (dedicated slot)',
        internalMemory: '64GB 4GB RAM, 128GB 4GB RAM, 128GB 6GB RAM',
        mainCamera:
            'Quad 50 MP, f/1.8, (wide), PDAF 8 MP, f/2.2, 120˚ (ultrawide) 2 MP, f/2.4, (macro) 2 MP, f/2.4 (depth)',
        frontCamera: 'Single 8 MP, f/2.0, (wide), 1/4.0”, 1.12µm',
        loudSpeakers: 'Yes, with stereo speakers',
        jack3_5: 'Yes',
        wlan: 'Wi-Fi 802.11 a/b/g/n/ac, dual-band, Wi-Fi Direct, hotspot',
        bluetooth: '5.1, A2DP, LE',
        GPS: 'Yes, with A-GPS, GLONASS, GALILEO, BDS',
        NFC: 'Yes (market/region dependent)',
        radio: 'FM radio',
        USB: 'USB Type-C 2.0',
        sensors:
            'Fingerprint (side-mounted), accelerometer, proximity, compass',
        battery: 'Li-Po 5000 mAh, non-removable',
        charging: 'Fast charging 18W Reverse charging 9W',
      );
}

class SpecsTable extends StatefulWidget {
  final Specs specs;

  const SpecsTable({Key? key, required this.specs}) : super(key: key);

  @override
  State<SpecsTable> createState() => _SpecsTableState();
}

class _SpecsTableState extends State<SpecsTable> {
  /// Returns a [TableRow] that contains both the specification name and value
  /// of the phone.
  TableRow _tableRow({required String specName, required String specValue}) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: ColorManager.dividerGrey),
        ),
      ),
      children: <Widget>[
        _specName(specName),
        if (specName == LocaleKeys.manufacturingCompany)
          _companyName(specValue),
        if (specName != LocaleKeys.manufacturingCompany)
          _specValue(specValue, specName),
      ],
    );
  }

  /// Returns a [TableCell] that contains the specification value of the phone.
  TableCell _specValue(String specValue, String specName) {
    final bool isPrice = specName == LocaleKeys.priceWhenReleased;

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
            style: TextStyleManager.s16w400,
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
      child: Center(
        child: TextButton(
          onPressed: _navigateToCompanyScreen,
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
      ),
    );
  }

  /// Navigates to company profile screen.
  void _navigateToCompanyScreen() {
    Navigator.of(context).pushNamed(
      CompanyProfileScreen.routeName,
      arguments: CompanyProfileScreenArgs(
        companyId: widget.specs.companyId,
        companyName: widget.specs.companyName,
      ),
    );
  }

  /// Returns a [TableCell] that contains the name of the specification of the
  /// phone.
  TableCell _specName(String specName) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 25.w),
        child: Text(
          specName.tr() + ":",
          style: TextStyleManager.s16w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String languageCode = context.locale.languageCode;
    final List<String> specNames =
        widget.specs.toMap(languageCode: languageCode).keys.toList();
    final List<String> specValues =
        widget.specs.toMap(languageCode: languageCode).values.toList();
    final cardPadding = EdgeInsets.only(
      bottom: 15.h,
      top: 7.h,
      right: 16.w,
      left: 16.w,
    );

    return Card(
      elevation: AppElevations.ev3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: cardPadding,
        child: Table(
          children: [
            for (int i = 0; i < specNames.length; i++) ...[
              _tableRow(specName: specNames[i], specValue: specValues[i])
            ],
          ],
        ),
      ),
    );
  }
}
