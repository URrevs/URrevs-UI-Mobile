import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/company_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_widgets/empty_updated_companies.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/empty_widgets/empty_updated_products.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/item_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

///Enum that defines the type of the tile's item.
enum ItemDescription { smartphone, company }

///A class that represents a tile that contains an item.
class Item {
  final String itemId;
  final String itemName;
  final ItemDescription type;

  Item({
    required this.itemId,
    required this.itemName,
    required this.type,
  });
}

///Expanable list tile that contains newely updated items, it may contain a products or companies.
class UpdatedListTile extends StatefulWidget {
  const UpdatedListTile({
    Key? key,
    required this.title,
    required this.items,
    required this.listType,
  }) : super(key: key);

  ///The title of the updated list tile.
  final String title;

  ///The items that are contained in the updated list tile.
  final List<Item> items;

  final ItemDescription listType;

  @override
  State<UpdatedListTile> createState() => _UpdatedListTileState();
}

class _UpdatedListTileState extends State<UpdatedListTile> {
  bool _customTileExpanded = false;

  /// Function that chooses the icon of the item, eihter it's smartphone or company.
  IconData chooseSuitableItemIcon(ItemDescription itemDescription) {
    switch (itemDescription) {
      case ItemDescription.smartphone:
        return IconsManager.smartPhone;
      case ItemDescription.company:
        return IconsManager.company;
      default:
        return IconsManager.smartPhone;
    }
  }

  /// A function for translating items description as for localization.
  String getItemDescription(ItemDescription type) {
    switch (type) {
      case ItemDescription.smartphone:
        return LocaleKeys.smartphone.tr();
      case ItemDescription.company:
        return LocaleKeys.company.tr();
    }
  }

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
          child: _buildExpansionTile(),
        ),
      ),
    );
  }

  Widget _buildExpansionTile() {
    if (widget.items.isEmpty) {
      if (widget.listType == ItemDescription.smartphone) {
        return EmptyUpdatedProducts();
      } else {
        return EmptyUpdatedCompanies();
      }
    }
    return ExpansionTile(
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            Text(widget.title, style: TextStyleManager.s20w500),
            SizedBox(width: 10),
            Text('(${widget.items.length})', style: TextStyleManager.s20w500),
          ],
        ),
      ),
      collapsedTextColor: ColorManager.black,
      collapsedIconColor: ColorManager.black,
      textColor: ColorManager.black,
      iconColor: ColorManager.black,
      trailing: Icon(
        !_customTileExpanded ? IconsManager.expand : IconsManager.collapse,
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
              Item item = widget.items[index];
              return ItemTile(
                title: item.itemName,
                subtitle: getItemDescription(item.type),
                iconData: chooseSuitableItemIcon(item.type),
                showDivider: true,
                onTap: () {
                  if (item.type == ItemDescription.smartphone) {
                    Navigator.of(context).pushNamed(
                      ProductProfileScreen.routeName,
                      arguments: ProductProfileScreenArgs(
                        phoneId: item.itemId,
                        phoneName: item.itemName,
                      ),
                    );
                  } else {
                    // company
                    Navigator.of(context).pushNamed(
                      CompanyProfileScreen.routeName,
                      arguments: CompanyProfileScreenArgs(
                        companyId: item.itemId,
                        companyName: item.itemName,
                      ),
                    );
                  }
                },
              );
            },
            itemCount: widget.items.length,
          ),
        ),
      ],
    );
  }
}
