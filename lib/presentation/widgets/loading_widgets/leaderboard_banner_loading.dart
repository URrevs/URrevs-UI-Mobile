import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/circular_loading.dart';

class LeaderboardBannerLoading extends StatelessWidget {
  const LeaderboardBannerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularLoading();
  }
}
