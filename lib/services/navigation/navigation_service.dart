import 'package:flutter/material.dart';

abstract interface class NavigationService {
  RouterConfig<Object> get config;

  int get activeTabIndex;

  void setActiveTabIndex(int index);

  Widget createDashboardTabRouter(
    Widget Function(BuildContext, Widget)? builder,
  );

  Future<T?> navigateToHistoryDetails<T extends Object?>(int eventId);

  void pop<T extends Object?>([T? result]);
}
