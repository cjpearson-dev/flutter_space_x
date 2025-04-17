import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_space_x/i18n/i18n.dart';

import '../../services/navigation/app_router.gr.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [LaunchesListRoute(), HistoryListRoute()],
      transitionBuilder:
          (context, child, animation) =>
              FadeTransition(opacity: animation, child: child),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        final appBarTitles = [
          context.localizations.launchesListTitle,
          context.localizations.historyListTitle,
        ];

        return Scaffold(
          body: child,
          appBar: AppBar(title: Text(appBarTitles[tabsRouter.activeIndex])),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                label: appBarTitles[0],
                icon: Icon(Icons.rocket_outlined),
              ),
              BottomNavigationBarItem(
                label: appBarTitles[1],
                icon: Icon(Icons.article_outlined),
              ),
            ],
          ),
        );
      },
    );
  }
}
