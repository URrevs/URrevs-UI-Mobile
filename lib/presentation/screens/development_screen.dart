import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_comparison_table.dart';

class DevelopmentScreen extends StatefulWidget {
  const DevelopmentScreen({Key? key}) : super(key: key);

  @override
  State<DevelopmentScreen> createState() => _DevelopmentScreenState();
}

class _DevelopmentScreenState extends State<DevelopmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => context.setLocale(LanguageType.ar.locale),
            child: Text('ar'),
          ),
          ElevatedButton(
            onPressed: () => context.setLocale(LanguageType.en.locale),
            child: Text('en'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     print("scale width: ${ScreenUtil().scaleWidth}");
          //     print("scale height: ${ScreenUtil().scaleHeight}");
          //     print("screen width: ${ScreenUtil().screenWidth}");
          //     print("ui size: ${ScreenUtil().uiSize}");
          //   },
          //   child: Text('screen util'),
          // ),
        ],
      ),
      body: ListView(
        children: [
          ProductReviewCard.dummyInstance,
        ],
      ),
    );
  }
}
