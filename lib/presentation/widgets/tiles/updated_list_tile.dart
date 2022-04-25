import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';

enum itemDescription { Smartphone, Company }

class Item {
  final String itemName;
  final itemDescription type;

  Item({required this.itemName, required this.type});
}


class UpdatedListTile extends StatefulWidget {
  const UpdatedListTile({Key? key,required this.title ,required this.items}) : super(key: key);

  final String title;
  final List<Item> items;
  @override
  State<UpdatedListTile> createState() => _UpdatedListTileState();
}

class _UpdatedListTileState extends State<UpdatedListTile> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        30.r,
      ),
      child: Card(
        elevation: 3,
        child: ExpansionTile(
            title: Row(
              children: [
                Text(widget.title,
                    style: TextStyleManager.s20w500),
                SizedBox(width: 10),
                Text('(${widget.items.length})', style: TextStyleManager.s20w500),
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
              SizedBox(
                height: widget.items.length <=4? widget.items.length * (90.h): 4 * (90.h),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ItemTile(
                        itemName: widget.items[index].itemName,
                        itemDescription: widget.items[index].type.name);
                  },
                  itemCount: widget.items.length,
                ),
              ),
            ]),
      ),
    );
  }
}
