import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  static const String routeName = 'ReportsScreen';

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.appBarofReportsScreen(
        context: context,
        controller: _tabController,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text('open')),
          Center(child: Text('closed')),
        ],
      ),
    );
  }
}
