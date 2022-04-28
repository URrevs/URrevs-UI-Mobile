import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/app_elevations.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/company_logo_tile.dart';

///A class that contains data for a company logo tile.
class CompanyItem {
  final String name;
  final String imageUrl;

  CompanyItem({required this.name, required this.imageUrl});
}

/// Testing data for company logo tiles.
List<CompanyItem> companyItems = [
  CompanyItem(
      name: 'Xiaomi', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Samsung', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Apple', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Huawei', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Lenovo', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'LG', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Asus', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Nokia', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Motorola', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Oppo', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Vivo', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'ZTE', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Meizu', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Acer', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'OnePlus', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Realme', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Gionee', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Vivo', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Xiaomi', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Samsung', imageUrl: 'https://picsum.photos/seed/picsum/200/200'),
  CompanyItem(
      name: 'Apple', imageUrl: 'https://picsum.photos/seed/picsum/200/200')
];

class CompanyHorizontalListTile extends StatefulWidget {
  const CompanyHorizontalListTile({required this.companyItems, Key? key})
      : super(key: key);

  final List<CompanyItem> companyItems;
  @override
  State<CompanyHorizontalListTile> createState() =>
      _CompanyHorizontalListTileState();
}

class _CompanyHorizontalListTileState extends State<CompanyHorizontalListTile> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppElevations.ev3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
        child: Container(
          color: ColorManager.white,
          height: 95.h,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(overscroll: false),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: companyItems.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (_selectedIndex == index) {
                          _selectedIndex = -1;
                        } else {
                          _selectedIndex = index;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? ColorManager.blue.withOpacity(0.8)
                            : ColorManager.white,
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(10.r, 10.r)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: CompanyLogoTile(
                        companyName: companyItems[index].name,
                        imageUrl: companyItems[index].imageUrl,
                        isSelected: _selectedIndex == index ? true : false,
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
