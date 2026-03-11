import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/storage_service.dart';

final sl = GetIt.instance; // sl stands for Service Locator

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data Sources
  sl.registerLazySingleton(() => StorageService(sl()));
}
