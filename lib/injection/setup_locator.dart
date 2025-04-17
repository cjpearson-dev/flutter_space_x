import 'package:get_it/get_it.dart';

import '../repositories/history/history_repository.dart';
import '../repositories/history/history_repository_impl.dart';
import '../services/api/api_service.dart';
import '../services/api/api_service_http.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Services
  locator.registerLazySingleton<ApiService>(() => ApiServiceHttp());

  // Repositories
  locator.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(locator<ApiService>()),
  );
}
