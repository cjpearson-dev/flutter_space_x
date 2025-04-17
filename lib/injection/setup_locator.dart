import 'package:get_it/get_it.dart';

import '../services/api/api.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Services
  locator.registerLazySingleton<ApiService>(() => ApiServiceHttp());
}
