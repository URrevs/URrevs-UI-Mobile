import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/company_horizontal_list_tile.dart';

class AllProductsSubscreen extends StatefulWidget {
  const AllProductsSubscreen({Key? key}) : super(key: key);

  @override
  State<AllProductsSubscreen> createState() => _AllProductsSubscreenState();
}

class _AllProductsSubscreenState extends State<AllProductsSubscreen> {
  SliverAppBar _buildCompanyList() {
    return SliverAppBar(
      elevation: 3,
      snap: true,
      floating: true,
      toolbarHeight: 95.h,
      collapsedHeight: 95.h,
      expandedHeight: 95.h,
      backgroundColor: ColorManager.transparent,
      flexibleSpace: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          CompanyHorizontalListTile(companyItems: companyItems),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: CustomScrollView(
        slivers: [
          _buildCompanyList(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 1000,
              child: Center(child: Text('all products')),
            ),
          )
        ],
      ),
    );
  }
}
