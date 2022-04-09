// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "usedSince": "استخدمه منذ",
  "urrevs": "urrevs",
  "generalProductRating": "التقييم العام للمنتج",
  "userInterface": "واجهة المستخدم",
  "manufacturingQuality": "جودة التصنيع",
  "priceQuality": "القيمة للسعر",
  "camera": "الكاميرا",
  "callsQuality": "جودة المكالمات",
  "battery": "البطارية",
  "pros": "المميزات",
  "cons": "العيوب",
  "like": "أعجبني",
  "comment": "تعليق",
  "share": "مشاركة",
  "seeMore": "المزيد",
  "seeLess": "أقل"
};
static const Map<String,dynamic> en = {
  "usedSince": "Used since",
  "urrevs": "urrevs",
  "battery": "Battery",
  "callsQuality": "Calls Quality",
  "camera": "Camera",
  "comment": "Comment",
  "cons": "Cons",
  "generalProductRating": "General Rating",
  "like": "Like",
  "manufacturingQuality": "Manufacturing Quality",
  "priceQuality": "Price Quality",
  "pros": "Pros",
  "seeLess": "see less",
  "seeMore": "see more",
  "share": "Share",
  "userInterface": "User Interface"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
