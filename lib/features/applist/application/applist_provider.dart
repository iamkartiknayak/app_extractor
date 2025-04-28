import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class ApplistProvider extends ChangeNotifier {
  // public var (getters)
  List<Application> get installedAppsList => _installedAppsList;
  List<Application> get systemAppsList => _systemAppsList;
  List<Application> get favoriteAppsList => _favoriteAppsList;

  // private var
  bool _isInitialized = false;

  List<Application> _allAppslist = [];
  List<Application> _installedAppsList = [];
  List<Application> _systemAppsList = [];
  final List<Application> _favoriteAppsList = [];

  // public methods
  void init() async {
    if (_isInitialized) return;

    await _getAppsList();
    _isInitialized = true;
  }

  void toggleFavorite(Application app) {
    _favoriteAppsList.contains(app)
        ? _favoriteAppsList.remove(app)
        : _favoriteAppsList.add(app);

    notifyListeners();
  }

  bool isFavorite(Application app) => _favoriteAppsList.contains(app);

  // private methods
  Future<void> _getAppsList() async {
    _allAppslist = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );

    _allAppslist.sort(
      (a, b) => a.appName.toUpperCase().compareTo(b.appName.toUpperCase()),
    );

    _installedAppsList = _allAppslist.where((app) => !app.systemApp).toList();
    _systemAppsList = _allAppslist.where((app) => app.systemApp).toList();

    debugPrint(_installedAppsList.toString());

    notifyListeners();
  }
}
