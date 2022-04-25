import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';

class UpdatedListTile extends StatefulWidget {
  const UpdatedListTile({ Key? key }) : super(key: key);

  @override
  State<UpdatedListTile> createState() => _UpdatedListTileState();
}

class _UpdatedListTileState extends State<UpdatedListTile> {
  bool _customTileExpanded =false;
  @override
  Widget build(BuildContext context) {  
    return Card(
          elevation: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              AppRadius.interactionBodyRadius,
            ),
            child: ExpansionTile(
                title: Row(
                  children: [
                    Text('قائمة المنتجات المضافة حديثاً',
                        style: TextStyleManager.s20w500),
                    SizedBox(width: 10),
                    Text('(20)', style: TextStyleManager.s20w500),
                  ],
                ),
                collapsedTextColor: ColorManager.black,
                collapsedIconColor: ColorManager.black,
                textColor: ColorManager.black,
                iconColor: ColorManager.black,
                trailing: Icon(
                  !_customTileExpanded
                      ? Icons.arrow_drop_down_rounded
                      : Icons.arrow_drop_up_rounded,
                  size: 32.sp,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => _customTileExpanded = expanded);
                },
                backgroundColor: ColorManager.white,
                collapsedBackgroundColor: ColorManager.white,
                children: [
                  ListTile(
                    title: Text(
                      'Xiaomi Redmi Note 6',
                      style: TextStyleManager.s20w700,
                    ),
                    textColor: ColorManager.black,
                    iconColor: ColorManager.buttonGrey,
                    subtitle: Text('هاتف ذكي',
                        style: TextStyleManager.s18w400SubTitle),
                    leading: Icon(
                      Icons.smartphone_rounded,
                      size: 40.sp,
                    ),
                  ),
                ]),
          ),
        );
  }
}