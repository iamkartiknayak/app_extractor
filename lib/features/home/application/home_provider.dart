import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../settings/presentation/pages/settings_page.dart';
import '../../applist/application/applist_provider.dart';
import '../../applist/presentation/pages/app_list_page.dart';

class NavbarIndexProvider extends ChangeNotifier {
  // public var (getters)
  int get currentIndex => _currentIndex;
  List<Widget> get pages => _pages;

  // private var
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const AppListPage(),
    const AppListPage(),
    const AppListPage(),
    const SettingsPage(),
  ];

  // public methods
  void updateIndex(int selectedIndex, BuildContext context) {
    Future.microtask(() {
      if (context.mounted) {
        context.read<ApplistProvider>().toggleSearch(enable: false);
      }
    });

    _currentIndex = selectedIndex;
    notifyListeners();
  }
}
