import 'package:flutter/material.dart';

import 'app.dart';
import 'injection/setup_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure service locator
  await setupLocator();

  runApp(const MyApp());
}
