import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class OwnedProductsScreen extends StatefulWidget {
  const OwnedProductsScreen({Key? key}) : super(key: key);

  static const String routeName = 'OwnedProductsScreen';

  @override
  State<OwnedProductsScreen> createState() => _OwnedProductsScreenState();
}

class _OwnedProductsScreenState extends State<OwnedProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(LocaleKeys.addOwnedProduct.tr()),
        icon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => MenyItem(
          title: 'Nokia 7 plus',
          subtitle: LocaleKeys.smartphone,
          iconData: IconsManager.smartPhone,
          onTap: () {},
        ),
        itemCount: 10,
      ),
    );
  }
}
