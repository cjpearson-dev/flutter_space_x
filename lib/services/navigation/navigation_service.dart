import 'package:flutter/material.dart';

abstract interface class NavigationService {
  RouterConfig<Object> get config;

  int get activeTabIndex;

  void setActiveTabIndex(int index);

  Widget createDashboardTabRouter(
    Widget Function(BuildContext, Widget)? builder,
  );

  Future<T?> navigateToHistoryDetails<T extends Object?>(int eventId);

  Future<T?> navigateToLaunchDetails<T extends Object?>(int flightNumber);

  void pop<T extends Object?>([T? result]);
}
