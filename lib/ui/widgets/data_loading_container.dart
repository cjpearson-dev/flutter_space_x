import 'package:flutter/material.dart';
import 'package:flutter_space_x/i18n/i18n.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';

import './screen_error_message.dart';

class DataLoadingContainer extends StatelessWidget {
  final DataLoadingStatus loadingStatus;

  final WidgetBuilder successContent;

  final WidgetBuilder? loadingContent;

  final WidgetBuilder? failureContent;

  final String? errorMessage;

  const DataLoadingContainer({
    super.key,
    required this.loadingStatus,
    required this.successContent,
    this.loadingContent,
    this.failureContent,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    switch (loadingStatus) {
      case DataLoadingStatus.initial:
        return const SizedBox();

      case DataLoadingStatus.loading:
        return loadingContent != null
            ? loadingContent!(context)
            : const Center(child: CircularProgressIndicator());

      case DataLoadingStatus.success:
        return successContent(context);

      case DataLoadingStatus.failure:
        return failureContent != null
            ? failureContent!(context)
            : ScreenErrorMessage(
              errorMessage ?? context.localizations.generalErrorMsg,
            );
    }
  }
}
