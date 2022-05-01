import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urrevs_ui_mobile/app/app_preferences.dart';
import 'package:urrevs_ui_mobile/data/dio_factory.dart';
import 'package:urrevs_ui_mobile/data/remote_data_source/remote_data_source.dart';
import 'package:urrevs_ui_mobile/domain/repository.dart';
import 'package:urrevs_ui_mobile/presentation/resources/flags_manager.dart';

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  GetIt.I.registerLazySingleton<AppPreferences>(
    () => AppPreferences(sharedPreferences),
  );
  GetIt.I.registerLazySingleton<Dio>(
    () => getDio,
  );
  GetIt.I.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSource(
      GetIt.I<Dio>(),
      baseUrl: FlagsManager.useMockApi
          ? 'http://10.0.2.2:3000/'
          : 'https://urrevs-api-dev-mobile.herokuapp.com',
    ),
  );
  GetIt.I.registerLazySingleton<Repository>(
    () => Repository(remoteDataSource: GetIt.I<RemoteDataSource>()),
  );
}
