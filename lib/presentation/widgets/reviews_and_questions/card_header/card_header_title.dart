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
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';

/// Build the line containing the author's name and the product name.
class CardHeaderTitle extends StatelessWidget {
  const CardHeaderTitle({
    Key? key,
    required this.authorName,
    required this.targetName,
    required this.userId,
    required this.targetId,
    required this.type,
    this.usedInReportCard = false,
  })  : assert(usedInReportCard || type != null),
        super(key: key);

  /// Name of review author.
  final String authorName;

  /// Name of product on which the review was posted.
  final String targetName;

  final String userId;

  final String targetId;

  final TargetType? type;

  final bool usedInReportCard;

  void _onPressingTarget(BuildContext context) {
    switch (type) {
      case TargetType.company:
        Navigator.of(context).pushNamed(
          CompanyProfileScreen.routeName,
          arguments: CompanyProfileScreenArgs(
            companyId: targetId,
            companyName: targetName,
          ),
        );
        break;
      case TargetType.phone:
        Navigator.of(context).pushNamed(
          ProductProfileScreen.routeName,
          arguments: ProductProfileScreenArgs(
            phoneId: targetId,
            phoneName: targetName,
          ),
        );
        break;
      case null:
        Navigator.of(context).pushNamed(
          UserProfileScreen.routeName,
          arguments: UserProfileScreenArgs(userId: targetId),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                UserProfileScreen.routeName,
                arguments: UserProfileScreenArgs(userId: userId),
              );
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
        Padding(
          padding:  EdgeInsets.only(bottom: 5.h),
          child: FaIcon(
            context.isArabic ? IconsManager.caretLeft : IconsManager.caretRight,
            textDirection: TextDirection.ltr,
            size: 16.sp,
          ),
        ),
        8.horizontalSpace,
        Flexible(
          child: GestureDetector(
            onTap: () => _onPressingTarget(context),
            child: Text(
              targetName,
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
