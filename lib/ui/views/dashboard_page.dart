import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_space_x/i18n/i18n.dart';
import 'package:flutter_space_x/injection/setup_locator.dart';
import 'package:flutter_space_x/services/navigation/navigation_service.dart';

// Would ideally with more time replace these annotations with my own to decouple these views completely from auto_route.
@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // I don't super like accessing the service locator like this in the view layer.
    // Usually prefer to do this in the view model layer (like a bloc or cubit) but is unavoidable sometimes and it the interests of time.
    final navigationService = locator<NavigationService>();

    return navigationService.createDashboardTabRouter((context, child) {
      final appBarTitles = [
        context.localizations.launchesListTitle,
        context.localizations.historyListTitle,
      ];

      return Scaffold(
        body: child,
        appBar: AppBar(
          title: Text(appBarTitles[navigationService.activeTabIndex]),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationService.activeTabIndex,
          onTap: (index) {
            navigationService.setActiveTabIndex(index);
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
    });
  }
}
