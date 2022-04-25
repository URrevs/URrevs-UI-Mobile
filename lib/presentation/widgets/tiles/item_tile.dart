
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/updated_list_tile.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    required this.itemName,
    required this.itemDescription,
    Key? key,
  }) : super(key: key);
  final String itemName;
  final String itemDescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            itemName,
            style: TextStyleManager.s20w700,
          ),
          textColor: ColorManager.black,
          iconColor: ColorManager.buttonGrey,
          subtitle: Text(itemDescription,
              style: TextStyleManager.s18w400.copyWith(
                color: ColorManager.grey,
              )),
          leading: Icon(chooseSuitableItemIcon(itemDescription),
          size: 40.sp,),
        ),
        Divider(
          indent: 20.w,
          endIndent: 20.w,
          color: ColorManager.dividerGrey,
          thickness: 1.h,)
      ],
    );
  }

  IconData chooseSuitableItemIcon(String itemDescription) { 
          switch (itemDescription) {
            case  'Smartphone':  return Icons.smartphone_rounded;
            case  'Company': return Icons.business_rounded;
            default: return Icons.smartphone_rounded;
          };
  }
}