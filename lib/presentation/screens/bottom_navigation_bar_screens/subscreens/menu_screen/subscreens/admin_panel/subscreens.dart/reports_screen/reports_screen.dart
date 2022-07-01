import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel/subscreens.dart/reports_screen/subscreens/closed_reports_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel/subscreens.dart/reports_screen/subscreens/open_reports_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reports_list.dart';

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
          ReportsList(reportStatus: ReportStatus.open),
          ReportsList(reportStatus: ReportStatus.closed),
        ],
      ),
    );
  }
}
