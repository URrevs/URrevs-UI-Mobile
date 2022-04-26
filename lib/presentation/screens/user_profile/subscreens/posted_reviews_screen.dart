import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class PostedReviewsScreen extends StatefulWidget {
  const PostedReviewsScreen({Key? key}) : super(key: key);

  static const String routeName = 'PostedReviewsScreen';

  @override
  State<PostedReviewsScreen> createState() => _PostedReviewsScreenState();
}

class _PostedReviewsScreenState extends State<PostedReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(LocaleKeys.addReview.tr()),
        icon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      ),
      body: ListView(
        children: [
          Center(
            child: Text('posted reviews'),
          )
        ],
      ),
    );
  }
}
