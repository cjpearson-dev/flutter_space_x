import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_router.dart';
import 'app_router.gr.dart';
import 'navigation_service.dart';

class NavigationServiceAutoRoute implements NavigationService {
  final _rootRouter = AppRouter();

  final _tabRouterKey = GlobalKey<AutoTabsRouterState>();

  @override
  RouterConfig<Object> get config => _rootRouter.config();

  @override
  int get activeTabIndex =>
      _tabRouterKey.currentState?.controller?.activeIndex ?? 0;

  @override
  Widget createDashboardTabRouter(
    Widget Function(BuildContext, Widget)? builder,
  ) => AutoTabsRouter(
    key: _tabRouterKey,
    routes: const [LaunchesListRoute(), HistoryListRoute()],
    transitionBuilder:
        (context, child, animation) =>
            FadeTransition(opacity: animation, child: child),
    builder: builder,
  );

  @override
  void setActiveTabIndex(int index) {
    _tabRouterKey.currentState?.controller?.setActiveIndex(index);
  }

  @override
  Future<T?> navigateToHistoryDetails<T extends Object?>(int eventId) {
    return _rootRouter.push(HistoryDetailsRoute(eventId: eventId));
  }

  @override
  void pop<T extends Object?>([T? result]) {
    return _rootRouter.pop(result);
  }
}
