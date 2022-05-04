import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel/admin_panel_screen.dart';

class MenuSubscreen extends StatefulWidget {
  const MenuSubscreen({Key? key}) : super(key: key);

  @override
  State<MenuSubscreen> createState() => _MenuSubscreenState();
}

class _MenuSubscreenState extends State<MenuSubscreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AdminPanelScreen.routeName);
        },
        child: Text('ADMIN PANEL'),
      ),
    );
  }
}
