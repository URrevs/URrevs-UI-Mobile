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
  final String? imageUrl;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? ColorManager.blue.withOpacity(0.8)
            : ColorManager.white,
        borderRadius: BorderRadius.all(Radius.elliptical(10.r, 10.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Avatar(imageUrl: imageUrl, radius: 25.r, placeholder: Icons.business),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              companyName,
              style: isSelected
                  ? TextStyleManager.s16w500
                  : TextStyleManager.s16w400,
            ),
          ),
        ],
      ),
    );
  }
}
