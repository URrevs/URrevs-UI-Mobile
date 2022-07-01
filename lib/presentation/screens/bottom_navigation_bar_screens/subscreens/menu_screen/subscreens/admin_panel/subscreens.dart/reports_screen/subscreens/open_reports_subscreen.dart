import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reports_list.dart';

class OpenReportsSubscreen extends StatelessWidget {
  const OpenReportsSubscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReportsList(reportStatus: ReportStatus.open);
  }
}
