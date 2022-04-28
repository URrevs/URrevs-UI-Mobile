import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/bottom_navigation_bar_container_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/about_us_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/privacy_policy_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/questions_about_my_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/settings_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/terms_and_conditions_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/company_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/comparison_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/development_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/presentation_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/search_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/owned_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_questions_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_reviews_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';

class Routes {
  static const String development = "/development";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case DevelopmentScreen.routeName:
        return MaterialPageRoute(builder: (_) => DevelopmentScreen());
      case PresentationScreen.routeName:
        return MaterialPageRoute(builder: (_) => PresentationScreen());
      case BottomNavigationBarContainerScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => BottomNavigationBarContainerScreen(),
        );
      case UserProfileScreen.routeName:
        final screenArgs = routeSettings.arguments as UserProfileScreenArgs? ??
            UserProfileScreenArgs();
        return MaterialPageRoute(
          builder: (_) => UserProfileScreen(screenArgs),
        );
      case PostedReviewsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => PostedReviewsScreen(),
        );
      case PostedQuestionsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => PostedQuestionsScreen(),
        );
      case OwnedProductsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => OwnedProductsScreen(),
        );
      case AboutUsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => AboutUsScreen(),
        );
      case AdminPanelScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => AdminPanelScreen(),
        );
      case PrivacyPolicyScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => PrivacyPolicyScreen(),
        );
      case QuestionsAboutMyProductsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => QuestionsAboutMyProductsScreen(),
        );
      case SettingsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );
      case TermsAndConditionsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => TermsAndConditionsScreen(),
        );
      case CompanyProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => CompanyProfileScreen(),
        );
      case ProductProfileScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ProductProfileScreen(),
        );
      case AuthenticationScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => AuthenticationScreen(),
        );
      case ComparisonScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ComparisonScreen(),
        );
      case FullscreenPostScreen.routeName:
        // TODO: remove default screen arguments value
        FullscreenPostScreenArgs screenArgs =
            routeSettings.arguments as FullscreenPostScreenArgs? ??
                FullscreenPostScreenArgs(cardType: CardType.productReview);
        return MaterialPageRoute(
          builder: (_) => FullscreenPostScreen(screenArgs),
        );
      case SearchScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => SearchScreen(),
        );
      default:
        return unDefinedRoute(routeSettings.name);
    }
  }

  static Route<dynamic> unDefinedRoute(String? routeName) {
    return MaterialPageRoute(
        builder: (_) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Route not found'),
                ),
                body: Center(child: Text('$routeName is not found')),
              ),
            ));
  }
}
