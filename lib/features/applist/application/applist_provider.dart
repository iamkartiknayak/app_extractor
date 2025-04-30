import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ApplistProvider extends ChangeNotifier {
  static const boxId = 'appData';

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
  late final List<String> _favoriteAppsIds;
  late final Box<dynamic> _appData;

  // public methods
  void init() async {
    if (_isInitialized) return;

    _appData = Hive.box(boxId);
    _favoriteAppsIds = _appData.get('favorites', defaultValue: <String>[]);
    _getAppsList();
    _isInitialized = true;
  }

  void toggleFavorite(Application app) {
    _favoriteAppsIds.contains(app.packageName)
        ? _favoriteAppsIds.remove(app.packageName)
        : _favoriteAppsIds.add(app.packageName);

    _appData.put('favorites', _favoriteAppsIds.toList());
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
