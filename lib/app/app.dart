import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:urrevs_ui_mobile/presentation/resources/language_manager.dart';
import 'package:urrevs_ui_mobile/presentation/state_management/providers.dart';
import 'package:urrevs_ui_mobile/presentation/resources/routes_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/theme_manager.dart';
import 'package:urrevs_ui_mobile/presentation/timeago.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (_) => MaterialApp(
        title: LocaleKeys.urrevs.tr(),
        initialRoute: Routes.development,
        onGenerateRoute: RouteGenerator.getRoute,
        debugShowCheckedModeBanner: false,
        themeMode: ref.watch(themeModeProvider),
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          timeago.setLocaleMessages(LanguageType.en.name, MyCustomEnMessages());
          timeago.setLocaleMessages(LanguageType.ar.name, MyCustomArMessages());
          return MediaQuery(
            //Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
