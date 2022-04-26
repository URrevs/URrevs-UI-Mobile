import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';

class PostedReviewsScreen extends StatefulWidget {
  const PostedReviewsScreen({Key? key}) : super(key: key);

  static const String routeName = 'PostedReviewsScreen';

  @override
  State<PostedReviewsScreen> createState() => _PostedReviewsScreenState();
}

class _PostedReviewsScreenState extends State<PostedReviewsScreen> {
  bool _showFab = true;

  Widget? get fab => _showFab
      ? FloatingActionButton.extended(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.plus, size: AppSize.s16),
          label: Text('أضف سؤال'),
        )
      : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            if (!_showFab) setState(() => _showFab = true);
          } else if (notification.direction == ScrollDirection.reverse) {
            if (_showFab) setState(() => _showFab = false);
          }
          return true;
        },
        child: ListView(
          children: [
            SizedBox(
              height: 1000,
              child: Center(
                child: Text('hello'),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: fab,
    );
  }
}
