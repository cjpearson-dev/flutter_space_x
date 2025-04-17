import 'package:flutter/material.dart';

abstract interface class NavigationService {
  RouterConfig<Object> get config;

  Future<T?> navigateToHistoryDetails<T extends Object?>(int eventId);

  void pop<T extends Object?>([T? result]);
}
