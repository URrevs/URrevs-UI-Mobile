import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/assets_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/color_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/dummy_data_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/resources/icons_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/strings_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/text_style_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/values_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/avatar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/bottom_navigation_bar.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/auth_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/buttons/grad_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/rating_overview_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/cards/report_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/circular_rating_indicator.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answer_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/answers_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comment_tree.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/comments_list.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/interactions/reply.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/card_body_rating_block.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/see_more_button.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/card_body/review_card_body.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/company_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/product_review_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/reviews_and_questions/question_card.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_comparison_table.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/specs_table.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/stars_counter.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/company_horizontal_list_tile.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/company_logo_tile.dart';
import 'package:urrevs_ui_mobile/presentation/widgets/tiles/updated_list_tile.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

final countProvider = StateProvider<int>((ref) {
  return 1;
});

final squareProvider = StateNotifierProvider<SquareNotifier, int>((ref) {
  return SquareNotifier(ref);
});

class SquareNotifier extends StateNotifier<int> {
  SquareNotifier(this.ref) : super(1) {
    ref.listen<int>(countProvider, (previous, next) {
      state = state + 1;
    });
  }

  void increment() => state = state + 1;

  final StateNotifierProviderRef ref;
}

class DevelopmentScreen extends ConsumerStatefulWidget {
  const DevelopmentScreen({Key? key}) : super(key: key);

  static const String routeName = 'DevelopmentScreen';

  @override
  ConsumerState<DevelopmentScreen> createState() => _DevelopmentScreenState();
}

// List<Item> items = [
//   Item(itemName: 'Xiaomi Redmi Note 6', type: ItemDescription.smartphone),
//   Item(itemName: 'Xiaomi', type: ItemDescription.company),
// ];

class _DevelopmentScreenState extends ConsumerState<DevelopmentScreen> {
  bool isSelected = false;
  int selectedIndex = -1;
  String _userAgent = 'User Agent Header';

  void updateFirebasePhoto() async {
    await signInWithGoogle();
    FirebaseAuth.instance.currentUser!.updatePhotoURL(
        'https://media.istockphoto.com/photos/hacker-dark-face-using-laptop-picture-id1133604495?k=20&m=1133604495&s=612x612&w=0&h=QX5zvMG1qvfiz10hE5bSUXMj4eRMRTZF4qg3EIr-ffo=');
    print('current firebase photo:');
    print(FirebaseAuth.instance.currentUser!.photoURL);
    print('current google photo:');
    print(FirebaseAuth.instance.currentUser!.providerData.first.photoURL);
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

    debugPrint('firebase idToken: $idToken');
    debugPrint('google idToken: ${googleAuth?.idToken}');
    debugPrint('google access token: ${googleAuth?.accessToken}');
  }

  void signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    String idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    // await Dio().get(
    //   'https://urrevs-api-dev-mobile.herokuapp.com/users/authenticate',
    //   options: Options(
    //     headers: {
    //       'Authorization': 'Bearer $idToken',
    //     },
    //   ),
    // );
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    NumberFormat numberFormat =
        NumberFormat.compact(locale: context.locale.languageCode);
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () => context.setLocale(LanguageType.ar.locale),
            child: Text('ar'),
          ),
          ElevatedButton(
            onPressed: () => context.setLocale(LanguageType.en.locale),
            child: Text('en'),
          ),
          ElevatedButton(
            onPressed: () => ref
                .read(themeModeProvider.notifier)
                .setThemeMode(ThemeMode.dark),
            child: Text('🌙'),
          ),
          ElevatedButton(
            onPressed: () => ref
                .read(themeModeProvider.notifier)
                .setThemeMode(ThemeMode.light),
            child: Text('☀'),
          ),
          ElevatedButton(
            onPressed: () => print(FirebaseAuth.instance.currentUser),
            child: Text('hhh'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     print("scale width: ${ScreenUtil().scaleWidth}");
          //     print("scale height: ${ScreenUtil().scaleHeight}");
          //     print("screen width: ${ScreenUtil().screenWidth}");
          //     print("ui size: ${ScreenUtil().uiSize}");
          //   },
          //   child: Text('screen util'),
          // ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // ReportCard(
          //   imageUrl: null,
          //   authorName: 'Amr Fatouh',
          //   authorId: 'authorId',
          //   targetUserName: 'Fady Ahmed',
          //   targetUserId: 'targetUserId',
          //   postedDate: DateTime.now(),
          //   postType: PostType.phoneReview,
          //   complaintReason: ComplaintReason.spam,
          //   complaintContent: 'this is complaint content',
          // )
          // Center(
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(50),
          //     child: Container(
          //       height: 100,
          //       width: 100,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         gradient: LinearGradient(
          //           colors: [
          //             Colors.blue,
          //             Colors.white,
          //           ],
          //         ),
          //       ),
          //       child: Image.asset(
          //         ImageAssets.lenovoSmallLogo,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          // ElevatedButton(
          //     onPressed: () async {
          //       final dynamicLinkParams = DynamicLinkParameters(
          //         link: Uri.parse("https://www.example.com/"),
          //         uriPrefix: "https://urevs.page.link",
          //         androidParameters: const AndroidParameters(
          //             packageName: "com.example.urrevs_ui_mobile"),
          //       );
          //       final dynamicLink = await FirebaseDynamicLinks.instance
          //           .buildLink(dynamicLinkParams);
          //       print(dynamicLink);
          //     },
          //     child: Text('CLICK'))
          // UpdatedListTile(title: 'قائمة الشركات المضافة حديثاً', items: items),
          // ProductReviewCard.dummyInstance(),
          // CompanyReviewCard.dummyInstance(),
          // QuestionCard.dummyInstance(context),
          // CommentTree.dummyInstance,
          // AnswerTree.dummyInstance,
          // CommentsList.dummyInstance,
          // AnswersList.dummyInstance,
          // SpecsTable.dummyInstance,
          // SpecsComparisonTable.dummyInstance,
          // SvgPicture.asset(SvgAssets.upvote, color: Colors.red),
        ],
      ),
      //bottomNavigationBar: BottomNavBar(currentIndex: 2,onTap: (int i)=>{},),
    );
  }
}

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'error text';
        }
        return null;
      },
    );
  }
}
