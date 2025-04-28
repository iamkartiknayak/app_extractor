import 'package:flutter/material.dart';

import '../../applist/presentation/pages/settings_page.dart';
import '../../applist/presentation/pages/system_apps_page.dart';
import '../../applist/presentation/pages/favorite_apps_page.dart';
import '../../applist/presentation/pages/installed_apps_page.dart';

class NavbarIndexProvider extends ChangeNotifier {
  // public var (getters)
  int get currentIndex => _currentIndex;
  List<Widget> get pages => _pages;

  // private var
  int _currentIndex = 0;
  final List<Widget> _pages = [
    InstalledAppsPage(),
    SystemAppsPage(),
    FavoriteAppsPage(),
    SettingsPage(),
  ];

  // public methods
  void updateIndex(int selectedIndex) {
    _currentIndex = selectedIndex;
    notifyListeners();
  }
}
