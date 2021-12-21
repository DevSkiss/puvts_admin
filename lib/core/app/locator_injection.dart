import 'package:get_it/get_it.dart';
import 'package:puvts_admin/features/login/data/service/auth_service_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Blocs
  // locator.registerFactory(
  //   () => LoginSignupBloc(),
  // );
  locator.registerLazySingleton<AuthApiService>(() => AuthApiServiceImpl());

  // locator.registerLazySingleton(() => DirectionsRepository());

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
}
