import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: DashboardRoute.page,
      initial: true,
      children: [
        AutoRoute(page: LaunchesListRoute.page, initial: true),
        AutoRoute(page: HistoryListRoute.page),
      ],
    ),
    AutoRoute(page: HistoryDetailsRoute.page),
    AutoRoute(page: LaunchDetailsRoute.page),
  ];
}
