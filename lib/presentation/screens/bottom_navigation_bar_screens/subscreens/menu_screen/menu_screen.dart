import 'package:flutter/material.dart';

class MenuSubscreen extends StatefulWidget {
  const MenuSubscreen({Key? key}) : super(key: key);

  @override
  State<MenuSubscreen> createState() => _MenuSubscreenState();
}

class _MenuSubscreenState extends State<MenuSubscreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Menu'),
    );
  }
}
