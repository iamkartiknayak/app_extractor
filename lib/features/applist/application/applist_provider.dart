import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class ApplistProvider extends ChangeNotifier {
  // public var (getters)
  List<Application> get installedAppsList => _installedAppsList;
  List<Application> get systemAppsList => _systemAppsList;
  List<Application> get favoriteAppsList =>
      _allAppslist
          .where((app) => _favoriteAppsIds.contains(app.packageName))
          .toList();

  // private var
  bool _isInitialized = false;

  List<Application> _allAppslist = [];
  List<Application> _installedAppsList = [];
  List<Application> _systemAppsList = [];
  final Set<String> _favoriteAppsIds = {};

  // public methods
  void init() async {
    if (_isInitialized) return;

    await _getAppsList();
    _isInitialized = true;
  }

  void toggleFavorite(Application app) {
    _favoriteAppsIds.contains(app.packageName)
        ? _favoriteAppsIds.remove(app.packageName)
        : _favoriteAppsIds.add(app.packageName);

    notifyListeners();
  }

  bool isFavorite(String packageName) => _favoriteAppsIds.contains(packageName);

  void removeApp(String appId) {
    _allAppslist.retainWhere((app) => app.packageName != appId);
    _installedAppsList.retainWhere((app) => app.packageName != appId);
    _systemAppsList.retainWhere((app) => app.packageName != appId);
    _favoriteAppsIds.retainWhere((packageName) => packageName != appId);
    notifyListeners();
  }

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
