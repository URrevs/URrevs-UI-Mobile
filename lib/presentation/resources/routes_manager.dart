import 'package:flutter/material.dart';
import 'package:urrevs_ui_mobile/presentation/resources/enums.dart';
import 'package:urrevs_ui_mobile/presentation/screens/authentication_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/bottom_navigation_bar_container_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/about_us_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel/admin_panel_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/admin_panel/subscreens.dart/update_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/privacy_policy_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/questions_about_my_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/settings_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/bottom_navigation_bar_screens/subscreens/menu_screen/subscreens/terms_and_conditions_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/company_profile/company_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/comparison_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/development_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/fullscreen_post_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/posting_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/presentation_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/product_profile/product_profile_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/search_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/splash_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/owned_products_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_questions_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/subscreens/posted_posts_screen.dart';
import 'package:urrevs_ui_mobile/presentation/screens/user_profile/user_profile_screen.dart';

class Routes {
  static const String development = "/development";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case DevelopmentScreen.routeName:
        return MaterialPageRoute(builder: (_) => DevelopmentScreen());
      case PresentationScreen.routeName:
        return MaterialPageRoute(builder: (_) => PresentationScreen());
      case BottomNavigationBarContainerScreen.routeName:
        final screenArgs =
            routeSettings.arguments as BottomNavigationBarContainerScreenArgs;
        return MaterialPageRoute(
          builder: (_) => BottomNavigationBarContainerScreen(screenArgs),
        );
      case UserProfileScreen.routeName:
        final screenArgs = routeSettings.arguments as UserProfileScreenArgs? ??
            UserProfileScreenArgs();
        return MaterialPageRoute(
          builder: (_) => UserProfileScreen(screenArgs),
        );
      case PostedPostsScreen.routeName:
        final screenArgs = routeSettings.arguments as PostedPostsScreenArgs? ??
            PostedPostsScreenArgs.defaultArgs;
        return MaterialPageRoute(
          builder: (_) => PostedPostsScreen(screenArgs),
        );
      case PostedQuestionsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => PostedQuestionsScreen(),
        );
      case OwnedProductsScreen.routeName:
        final screenArgs =
            routeSettings.arguments as OwnedProductsScreenArgs? ??
                OwnedProductsScreenArgs();
        return MaterialPageRoute(
          builder: (_) => OwnedProductsScreen(screenArgs),
        );
      case AboutUsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => AboutUsScreen(),
        );
      case AdminPanelScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => AdminPanelScreen(),
        );
      case UpdateProductsScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => UpdateProductsScreen(),
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
        final screenArgs =
            routeSettings.arguments as CompanyProfileScreenArgs? ??
                CompanyProfileScreenArgs.defaultArgs;
        return MaterialPageRoute(
          builder: (_) => CompanyProfileScreen(screenArgs),
        );
      case ProductProfileScreen.routeName:
        final screenArgs =
            routeSettings.arguments as ProductProfileScreenArgs? ??
                ProductProfileScreenArgs.defaultArgs;
        return MaterialPageRoute(
          builder: (_) => ProductProfileScreen(screenArgs),
        );
      case AuthenticationScreen.routeName:
        final screenArgs = routeSettings.arguments as AuthenticationScreenArgs;
        return MaterialPageRoute(
          builder: (_) => AuthenticationScreen(screenArgs: screenArgs),
        );
      case ComparisonScreen.routeName:
        ComparisonScreenArgs screenArgs =
            routeSettings.arguments as ComparisonScreenArgs? ??
                ComparisonScreenArgs.defaultArgs;
        return MaterialPageRoute(
          builder: (_) => ComparisonScreen(screenArgs),
        );
      case FullscreenPostScreen.routeName:
        // TODO: remove default screen arguments value
        FullscreenPostScreenArgs screenArgs =
            routeSettings.arguments as FullscreenPostScreenArgs;
        return MaterialPageRoute(
          builder: (_) => FullscreenPostScreen(screenArgs),
        );
      case SearchScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => SearchScreen(),
        );
      case PostingScreen.routeName:
        PostingScreenArgs screenArgs =
            routeSettings.arguments as PostingScreenArgs;
        return MaterialPageRoute(
          builder: (_) => PostingScreen(screenArgs: screenArgs),
        );
      case SplashScreen.routeName:
        SplashScreenArgs screenArgs =
            routeSettings.arguments as SplashScreenArgs;
        return MaterialPageRoute(
          builder: (_) => SplashScreen(screenArgs: screenArgs),
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
