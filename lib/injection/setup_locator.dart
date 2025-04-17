import 'package:get_it/get_it.dart';

import '../repositories/history/history_repository.dart';
import '../repositories/history/history_repository_impl.dart';
import '../repositories/launches/launches_repository.dart';
import '../repositories/launches/launches_repository_impl.dart';
import '../services/api/api_service.dart';
import '../services/api/api_service_http.dart';
import '../services/navigation/navigation_service.dart';
import '../services/navigation/navigation_service_auto_route.dart';
import '../services/url_launcher/url_launcher_service.dart';
import '../services/url_launcher/url_launcher_service_impl.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Services
  locator.registerLazySingleton<ApiService>(() => ApiServiceHttp());
  locator.registerLazySingleton<NavigationService>(
    () => NavigationServiceAutoRoute(),
  );
  locator.registerLazySingleton<UrlLauncherService>(
    () => UrlLauncherServiceImpl(),
  );

  // Repositories
  locator.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(locator<ApiService>()),
  );
  locator.registerLazySingleton<LaunchesRepository>(
    () => LaunchesRepositoryImpl(locator<ApiService>()),
  );
}
