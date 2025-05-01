import 'package:flutter/material.dart';

import '../../applist/presentation/pages/settings_page.dart';
import '../../applist/presentation/pages/app_list_page.dart';

class NavbarIndexProvider extends ChangeNotifier {
  // public var (getters)
  int get currentIndex => _currentIndex;
  List<Widget> get pages => _pages;

  // private var
  int _currentIndex = 0;
  final List<Widget> _pages = [
    AppListPage(),
    AppListPage(),
    AppListPage(),
    SettingsPage(),
  ];

  // public methods
  void updateIndex(int selectedIndex) {
    _currentIndex = selectedIndex;
    notifyListeners();
  }
}
