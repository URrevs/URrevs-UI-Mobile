import 'package:easy_localization/easy_localization.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class Specs {
  String id;
  String name;
  String type;
  String picture;
  String companyId;
  String companyName;
  double? priceEgp;
  // double? priceEur;
  // double? priceUsd;
  String? releaseDate;
  String? dimensions;
  String? network;
  String? screenProtection;
  String? os;
  String? chipset;
  String? cpu;
  String? gpu;
  String? externalMem;
  String? internalMem;
  String? mainCam;
  String? selfieCam;
  String? loudspeaker;
  String? slot3_5mm;
  String? wlan;
  String? bluetooth;
  String? gps;
  String? nfc;
  String? radio;
  String? usb;
  String? sensors;
  String? battery;
  String? charging;
  Specs({
    required this.id,
    required this.name,
    required this.type,
    required this.picture,
    required this.companyId,
    required this.companyName,
    required this.priceEgp,
    // required this.priceEur,
    // required this.priceUsd,
    required this.releaseDate,
    required this.dimensions,
    required this.network,
    required this.screenProtection,
    required this.os,
    required this.chipset,
    required this.cpu,
    required this.gpu,
    required this.externalMem,
    required this.internalMem,
    required this.mainCam,
    required this.selfieCam,
    required this.loudspeaker,
    required this.slot3_5mm,
    required this.wlan,
    required this.bluetooth,
    required this.gps,
    required this.nfc,
    required this.radio,
    required this.usb,
    required this.sensors,
    required this.battery,
    required this.charging,
  });

  Map<String, String> toMap({required String languageCode}) {
    // TODO: show prices with usd and euros in their locales

    String? strPrice;
    double? price = priceEgp;
    if (price != null) {
      price = (price / 10).round() * 10; // round to tens
    }
    strPrice = price?.toStringAsFixed(0);
    if (strPrice != null) strPrice += " " + LocaleKeys.egyptianPound.tr();
    // String strReleaseDate = DateFormat.yMMMM(languageCode).format(releaseDate);
    return {
      LocaleKeys.priceWhenReleased: strPrice ?? '-',
      LocaleKeys.manufacturingCompany: companyName,
      LocaleKeys.releaseDate: releaseDate ?? '-',
      LocaleKeys.productDimensions: dimensions ?? '-',
      LocaleKeys.networkType: network ?? '-',
      LocaleKeys.screenProtection: screenProtection ?? '-',
      LocaleKeys.operatingSystem: os ?? '-',
      LocaleKeys.chipset: chipset ?? '-',
      LocaleKeys.CPU: cpu ?? '-',
      LocaleKeys.GPU: gpu ?? '-',
      LocaleKeys.externalMemory: externalMem ?? '-',
      LocaleKeys.internalMemory: internalMem ?? '-',
      LocaleKeys.mainCamera: mainCam ?? '-',
      LocaleKeys.frontCamera: selfieCam ?? '-',
      LocaleKeys.loudSpeakers: loudspeaker ?? '-',
      LocaleKeys.jack3_5: slot3_5mm ?? '-',
      LocaleKeys.wlan: wlan ?? '-',
      LocaleKeys.bluetooth: bluetooth ?? '-',
      LocaleKeys.GPS: gps ?? '-',
      LocaleKeys.NFC: nfc ?? '-',
      LocaleKeys.radio: radio ?? '-',
      LocaleKeys.USB: usb ?? '-',
      LocaleKeys.sensors: sensors ?? '-',
      LocaleKeys.battery: battery ?? '-',
      LocaleKeys.charging: charging ?? '-',
    };
  }
}
