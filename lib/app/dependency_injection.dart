import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urrevs_ui_mobile/app/app_preferences.dart';

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences));
}
