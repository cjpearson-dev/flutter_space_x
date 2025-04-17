import 'package:flutter/material.dart';

import 'app_router.dart';
import 'navigation_service.dart';

class NavigationServiceAutoRoute implements NavigationService {
  final _rootRouter = AppRouter();

  @override
  RouterConfig<Object> get config => _rootRouter.config();

  @override
  void pop<T extends Object?>([T? result]) {
    return _rootRouter.pop(result);
  }
}
