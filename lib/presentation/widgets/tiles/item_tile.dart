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
    required this.itemName,
    required this.type,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  /// The name of the item.
  final String itemName;

  /// The type of the item.
  final ItemDescription type;

  /// The function that is called when the item is tapped.
  final VoidCallback onTap;

  /// Function that chooses the icon of the item, eihter it's smartphone or company.
  IconData chooseSuitableItemIcon(ItemDescription itemDescription) {
    switch (itemDescription) {
      case ItemDescription.Smartphone:
        return IconsManager.smartPhone;
      case ItemDescription.Company:
        return IconsManager.company;
      default:
        return IconsManager.smartPhone;
    }
    ;
  }

  /// A function for translating items description as for localization.
  String getItemDescription(ItemDescription type) {
    switch (type) {
      case ItemDescription.Smartphone:
        return LocaleKeys.smartphone.tr();
      case ItemDescription.Company:
        return LocaleKeys.company.tr();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            itemName,
            style: TextStyleManager.s20w700,
          ),
          onTap: onTap,
          textColor: ColorManager.black,
          iconColor: ColorManager.buttonGrey,
          subtitle: Text(getItemDescription(type),
              style: TextStyleManager.s18w400.copyWith(
                color: ColorManager.grey,
              )),
          leading: Icon(
            chooseSuitableItemIcon(type),
            size: 40.sp,
          ),
        ),
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
