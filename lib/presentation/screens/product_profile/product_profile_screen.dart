import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/domain/models/phone.dart';

import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/posting_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/subscreens/product_profile_q_a_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/subscreens/product_profile_reviews_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/subscreens/product_profile_specs_subscreen.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/app_bars.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/prompts/compare_dialog.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/scaffold_with_hiding_fab.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class ProductProfileScreenArgs {
  String phoneId;
  String phoneName;
  ProductProfileScreenArgs({
    required this.phoneId,
    required this.phoneName,
  });

  static ProductProfileScreenArgs get defaultArgs {
    return ProductProfileScreenArgs(
      phoneId: '6256a75b5f87fa90093a4bd6',
      phoneName: 'Nokia 7 plus',
    );
  }
}

class ProductProfileScreen extends ConsumerStatefulWidget {
  const ProductProfileScreen(this.screenArgs, {Key? key}) : super(key: key);

  final ProductProfileScreenArgs screenArgs;

  static const String routeName = 'ProductProfileScreen';

  @override
  ConsumerState<ProductProfileScreen> createState() =>
      _ProductProfileScreenState();
}

class _ProductProfileScreenState extends ConsumerState<ProductProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  String get fabLabel {
    switch (_tabController.index) {
      case 1:
        return LocaleKeys.compareWithAnotherProduct.tr();
      case 2:
        return LocaleKeys.addQuestion.tr();
      default:
        return LocaleKeys.addReview.tr();
    }
  }

  Widget get fabIcon {
    switch (_tabController.index) {
      case 1:
        return Icon(Icons.compare, size: AppSize.s22);
      case 2:
        return Icon(FontAwesomeIcons.plus, size: AppSize.s16);
      default:
        return Icon(FontAwesomeIcons.plus, size: AppSize.s16);
    }
  }

  VoidCallback get onPressingFab {
    Phone phone = Phone(
      id: widget.screenArgs.phoneId,
      name: widget.screenArgs.phoneName,
    );
    switch (_tabController.index) {
      case 0: //reviews
        return () {
          Navigator.of(context).pushNamed(
            PostingScreen.routeName,
            arguments: PostingScreenArgs(
              postContentType: PostContentType.review,
              phone: phone,
            ),
          );
        };
      case 1:
        return () {
          showDialog(
            context: context,
            builder: (context) => CompareDialoge(
              productId1: widget.screenArgs.phoneId,
              productName1: widget.screenArgs.phoneName,
            ),
          );
        };
      case 2: //questions
        return () {
          Navigator.of(context).pushNamed(
            PostingScreen.routeName,
            arguments: PostingScreenArgs(
              postContentType: PostContentType.question,
              phone: phone,
            ),
          );
        };
      default:
        return () {};
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithHidingFab(
      appBar: AppBars.appBarOfProductProfile(
        context: context,
        controller: _tabController,
        text: widget.screenArgs.phoneName,
        imageUrl: ref.currentUser!.picture,
      ),
      fabLabel: fabLabel,
      fabIcon: fabIcon,
      onPressingFab: onPressingFab,
      body: TabBarView(
        controller: _tabController,
        children: [
          ProductProfileReviewsSubscreen(phoneId: widget.screenArgs.phoneId),
          ProductProfileSpecsSubscreen(phoneId: widget.screenArgs.phoneId),
          ProductProfileQASubscreen(phoneId: widget.screenArgs.phoneId),
        ],
      ),
    );
  }
}
