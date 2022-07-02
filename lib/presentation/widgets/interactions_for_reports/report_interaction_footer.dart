import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';

class ReportInteractionFooter extends StatefulWidget {
  const ReportInteractionFooter({
    Key? key,
    required this.datePosted,
  }) : super(key: key);

  final DateTime datePosted;

  @override
  State<ReportInteractionFooter> createState() => _InteractionFooterState();
}

class _InteractionFooterState extends State<ReportInteractionFooter> {
  String footerDate(BuildContext context) =>
      timeago.format(widget.datePosted, locale: context.locale.languageCode);

  @override
  Widget build(BuildContext context) {
    EdgeInsets footerElementsPadding =
        EdgeInsets.only(top: 6.h, left: 3.w, right: 3.w);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        10.horizontalSpace,
        Padding(
          padding: footerElementsPadding,
          child: Text(
            footerDate(context),
            style: TextStyleManager.s13w400.copyWith(
              color: ColorManager.grey,
            ),
          ),
        )
      ],
    );
  }
}
