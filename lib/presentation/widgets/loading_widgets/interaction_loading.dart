import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/loading_widgets/circular_loading.dart';

class InteractionLoading extends StatelessWidget {
  const InteractionLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularLoading();
  }
}
