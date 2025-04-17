import 'package:flutter/material.dart';

import './generated/app_localizations.dart';

extension AppLocalizationX on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this);
}
