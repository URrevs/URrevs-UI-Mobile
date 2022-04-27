import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/app/extensions.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/company_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/other_user_profile_screen.dart';

/// Build the line containing the author's name and the product name.
class CardHeaderTitle extends StatelessWidget {
  const CardHeaderTitle({
    Key? key,
    required this.authorName,
    required this.productName,
    required this.cardType,
  }) : super(key: key);

  /// Name of review author.
  final String authorName;

  /// Name of product on which the review was posted.
  final String productName;

  final CardType cardType;

  void _onPressingTarget(BuildContext context) {
    switch (cardType) {
      case CardType.companyReview:
      case CardType.companyQuestion:
        Navigator.of(context).pushNamed(CompanyProfileScreen.routeName);
        break;
      default:
        Navigator.of(context).pushNamed(ProductProfileScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(OtherUserProfileScreen.routeName);
            },
            child: Text(
              authorName,
              textAlign: TextAlign.center,
              style: TextStyleManager.s16w700.copyWith(
                color: ColorManager.black,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        8.horizontalSpace,
        FaIcon(
          context.isArabic ? IconsManager.caretLeft : IconsManager.caretRight,
          textDirection: TextDirection.ltr,
          size: 16.sp,
        ),
        8.horizontalSpace,
        Flexible(
          child: GestureDetector(
            onTap: () => _onPressingTarget(context),
            child: Text(
              productName,
              textAlign: TextAlign.center,
              style: TextStyleManager.s16w700.copyWith(
                color: ColorManager.black,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
