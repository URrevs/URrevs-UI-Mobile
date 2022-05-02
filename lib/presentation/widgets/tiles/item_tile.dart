import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/updated_list_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

/// A widget that displays the name and category of a product, on tapping it routes you to the item profile.
class ItemTile extends StatelessWidget {
  const ItemTile({
    required this.title,
    this.subtitle,
    required this.iconData,
    required this.onTap,
    this.showDivider = false,
    Key? key,
  }) : super(key: key);

  /// The name of the item.
  final String title;

  /// The type of the item.
  final String? subtitle;

  /// [IconData] to be shown in the leading of the list tile.
  final IconData iconData;

  /// The function that is called when the item is tapped.
  final VoidCallback onTap;

  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyleManager.s20w700,
          ),
          onTap: onTap,
          textColor: ColorManager.black,
          iconColor: ColorManager.buttonGrey,
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: TextStyleManager.s18w400.copyWith(
                    color: ColorManager.grey,
                  ),
                )
              : null,
          leading: Icon(
            iconData,
            size: 40.sp,
          ),
        ),
        if (showDivider)
          Divider(
            indent: 20.w,
            endIndent: 20.w,
            color: ColorManager.dividerGrey,
            thickness: 1.h,
          )
      ],
    );
  }
}
