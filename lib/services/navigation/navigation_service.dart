import 'package:flutter/material.dart';

abstract interface class NavigationService {
  RouterConfig<Object> get config;

  void pop<T extends Object?>([T? result]);
}
