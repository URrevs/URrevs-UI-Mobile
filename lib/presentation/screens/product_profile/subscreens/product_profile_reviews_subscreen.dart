import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/get_posts_on_certain_target.dart';

class ProductProfileReviewsSubscreen extends StatelessWidget {
  const ProductProfileReviewsSubscreen({
    Key? key,
    required this.phoneId,
  }) : super(key: key);
  final String phoneId;

  @override
  Widget build(BuildContext context) {
    return PostsListOnCertainTarget(
      targetId: phoneId,
      targetType: TargetType.phone,
      postContentType: PostContentType.review,
    );
  }
}
