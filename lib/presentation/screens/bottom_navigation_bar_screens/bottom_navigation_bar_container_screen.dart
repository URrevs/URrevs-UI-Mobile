import 'package:flutter/material.dart';

class BottomNavigationBarContainerScreen extends StatefulWidget {
  const BottomNavigationBarContainerScreen({Key? key}) : super(key: key);

  static const String routeName = 'BottomNavigationBarContainerScreen';

  @override
  State<BottomNavigationBarContainerScreen> createState() =>
      _BottomNavigationBarContainerScreenState();
}

class _BottomNavigationBarContainerScreenState
    extends State<BottomNavigationBarContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
