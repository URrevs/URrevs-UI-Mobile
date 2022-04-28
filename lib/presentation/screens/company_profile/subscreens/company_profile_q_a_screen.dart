import 'package:flutter/material.dart';

class CompanyProfileQASubscreen extends StatefulWidget {
  const CompanyProfileQASubscreen({Key? key}) : super(key: key);

  @override
  State<CompanyProfileQASubscreen> createState() =>
      _CompanyProfileQASubscreenState();
}

class _CompanyProfileQASubscreenState extends State<CompanyProfileQASubscreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 1000,
          child: Center(child: Text('company profile q a')),
        )
      ],
    );
  }
}
