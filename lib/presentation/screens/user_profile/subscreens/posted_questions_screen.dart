import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class PostedQuestionsScreen extends StatefulWidget {
  const PostedQuestionsScreen({Key? key}) : super(key: key);

  static const String routeName = 'PostedQuestionsScreen';

  @override
  State<PostedQuestionsScreen> createState() => _PostedQuestionsScreenState();
}

class _PostedQuestionsScreenState extends State<PostedQuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(LocaleKeys.addQuestion.tr()),
        icon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      ),
      body: ListView(
        children: [
          Center(
            child: Text('posted questions'),
          )
        ],
      ),
    );
  }
}
