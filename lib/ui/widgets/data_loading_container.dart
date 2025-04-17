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

  final Future<void> Function()? onRefresh;

  const DataLoadingContainer({
    super.key,
    required this.loadingStatus,
    required this.successContent,
    this.loadingContent,
    this.failureContent,
    this.errorMessage,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final canRefresh =
        onRefresh != null &&
        (loadingStatus == DataLoadingStatus.success ||
            loadingStatus == DataLoadingStatus.success);

    return RefreshIndicator(
      onRefresh: canRefresh ? onRefresh! : () async {},
      child: Builder(
        builder: (context) {
          switch (loadingStatus) {
            case DataLoadingStatus.initial:
              return const SizedBox();

            case DataLoadingStatus.loading:
              return loadingContent != null
                  ? loadingContent!(context)
                  : const Center(child: CircularProgressIndicator());

            case DataLoadingStatus.success:
            case DataLoadingStatus.refreshing:
              return successContent(context);

            case DataLoadingStatus.failure:
              return failureContent != null
                  ? failureContent!(context)
                  : ScreenErrorMessage(
                    errorMessage ?? context.localizations.generalErrorMsg,
                  );
          }
        },
      ),
    );
  }
}
