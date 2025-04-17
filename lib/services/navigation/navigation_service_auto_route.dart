import 'package:flutter/material.dart';

import 'app_router.dart';
import 'app_router.gr.dart';
import 'navigation_service.dart';

class NavigationServiceAutoRoute implements NavigationService {
  final _rootRouter = AppRouter();

  @override
  RouterConfig<Object> get config => _rootRouter.config();

  @override
  Future<T?> navigateToHistoryDetails<T extends Object?>(int eventId) {
    return _rootRouter.push(HistoryDetailsRoute(eventId: eventId));
  }

  @override
  void pop<T extends Object?>([T? result]) {
    return _rootRouter.pop(result);
  }
}
