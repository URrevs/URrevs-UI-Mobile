import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel/subscreens.dart/update_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/utils/no_glowing_scroll_behavior.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  static const String routeName = 'AdminPanelScreen';

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlowingScrollBehaviour(),
          child: ListView(
            children: [
              ItemTile(
                title: LocaleKeys.updateProductList.tr(),
                subtitle: 'آخر تحديث تم في 20 فبراير 2022',
                iconData: Icons.update,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    UpdateProductsScreen.routeName,
                  );
                },
              ),
              ItemTile(
                title: LocaleKeys.addACompetition.tr(),
                subtitle: 'آخر مسابقة تمت في 20 أغسطس 2020',
                iconData: Icons.update,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    UpdateProductsScreen.routeName,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
