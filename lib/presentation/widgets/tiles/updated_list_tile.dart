import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';

///Enum that defines the type of the tile's item.
enum ItemDescription { smartphone, company }

///A class that represents a tile that contains an item.
class Item {
  final String itemName;
  final ItemDescription type;

  Item({required this.itemName, required this.type});
}
///Expanable list tile that contains newely updated items, it may contain a products or companies.
class UpdatedListTile extends StatefulWidget {
  const UpdatedListTile({Key? key, required this.title, required this.items})
      : super(key: key);

  ///The title of the updated list tile.
  final String title;

  ///The items that are contained in the updated list tile.
  final List<Item> items;

  @override
  State<UpdatedListTile> createState() => _UpdatedListTileState();
}

class _UpdatedListTileState extends State<UpdatedListTile> {
  bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Card(
        elevation: AppElevations.ev3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppRadius.updatedListTile,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.updatedListTile),
          child: ExpansionTile(
              title: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    Text(widget.title, style: TextStyleManager.s20w500),
                    SizedBox(width: 10),
                    Text('(${widget.items.length})',
                        style: TextStyleManager.s20w500),
                  ],
                ),
              ),
              collapsedTextColor: ColorManager.black,
              collapsedIconColor: ColorManager.black,
              textColor: ColorManager.black,
              iconColor: ColorManager.black,
              trailing: Icon(
                !_customTileExpanded
                    ? IconsManager.expand
                    : IconsManager.collapse,
                size: 32.sp,
              ),
              onExpansionChanged: (bool expanded) {
                setState(() => _customTileExpanded = expanded);
              },
              backgroundColor: ColorManager.white,
              collapsedBackgroundColor: ColorManager.white,
              children: [
                SizedBox(
                  height: widget.items.length <= 4
                      ? widget.items.length * (90.h)
                      : 4 * (90.h),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ItemTile(
                          itemName: widget.items[index].itemName,
                          type: widget.items[index].type,
                          onTap: () {});
                    },
                    itemCount: widget.items.length,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
