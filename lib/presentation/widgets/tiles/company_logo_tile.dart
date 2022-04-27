
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';

class CompanyLogoTile extends StatelessWidget {
  const CompanyLogoTile({
    required this.companyName,
    required this.imageUrl,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  final String companyName;
  final String imageUrl;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Avatar(
            imageUrl: imageUrl,
            radius: 25.r),
        Container(
          alignment: Alignment.bottomCenter,
          child: Text(
            companyName,
            style: isSelected? TextStyleManager.s16w500 : TextStyleManager.s16w400,
          ),
        ),
      ],
    );
  }
}
