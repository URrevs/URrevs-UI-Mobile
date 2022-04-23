import 'package:flutter/material.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({Key? key}) : super(key: key);

  static const String routeName = 'CompanyProfileScreen';

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}
