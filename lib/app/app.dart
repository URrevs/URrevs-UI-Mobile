import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:urrevs_ui_mobile/app/app_preferences.dart';
import 'package:urrevs_ui_mobile/presentation/providers.dart';
import 'package:urrevs_ui_mobile/presentation/resources/routes_manager.dart';
import 'package:urrevs_ui_mobile/presentation/resources/theme_manager.dart';
import 'package:urrevs_ui_mobile/translations/locale_keys.g.dart';

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return ScreenUtilInit(
      designSize: Size(411, 731),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: () => MaterialApp(
        title: 'URrevs', //TODO: place translated text here
        initialRoute: Routes.home,
        onGenerateRoute: RouteGenerator.getRoute,
        themeMode: ref.watch(themeModeProvider),
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
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

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.hello).tr()),
      body: Center(
        child: Container(
          color: Colors.red,
          width: 200.w,
          height: 200.h,
          child: Center(
            child: Column(
              children: [
                Text(ref.watch(themeModeProvider).name),
                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () => ref
                          .read(themeModeProvider.notifier)
                          .setThemeMode(ThemeMode.dark),
                      child: Text('dark'),
                    ),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(themeModeProvider.notifier)
                          .setThemeMode(ThemeMode.light),
                      child: Text('light'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => context.setLocale(
                    context.locale.languageCode == 'en'
                        ? Locale('ar')
                        : Locale('en'),
                  ),
                  child: Text(LocaleKeys.toggleLocale.tr()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
