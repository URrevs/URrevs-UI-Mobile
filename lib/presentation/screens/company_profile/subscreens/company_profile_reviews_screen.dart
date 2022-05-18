import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/get_posts_on_certain_target.dart';

class CompanyProfileReviewsSubscreen extends StatelessWidget {
  const CompanyProfileReviewsSubscreen({
    Key? key,
    required this.companyId,
  }) : super(key: key);
  final String companyId;

  @override
  Widget build(BuildContext context) {
    return PostsListOnCertainTarget(
      targetId: companyId,
      targetType: TargetType.company,
      postContentType: PostContentType.review,
      isSliver: false,
    );
  }
}
