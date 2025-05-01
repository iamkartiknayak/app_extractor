import 'dart:async';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/box_helper.dart';

class ApplistProvider extends ChangeNotifier {
  // public var (getters)
  bool get fetchingData => _fetchingData;
  bool get searchEnabled => _searchEnabled;
  List<Application> get searchResultList => _searchResultList;

  // private var
  bool _isInitialized = false;
  bool _fetchingData = false;
  bool _searchEnabled = false;
  String _searchTerm = '';

  List<Application> _allAppslist = [];
  List<Application> _installedAppsList = [];
  List<Application> _systemAppsList = [];
  List<Application> _favoriteAppsList = [];
  List<Application> _searchResultList = [];
  late final List<String> _favoriteAppsIds;
  Timer? _debounceTimer;

  // public methods
  void init() async {
    if (_isInitialized) return;

    _favoriteAppsIds = BoxHelper.instance.getFavoriteAppsIdList();
    _getAppsList();
    _isInitialized = true;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void toggleFavorite(Application app) {
    _favoriteAppsIds.contains(app.packageName)
        ? _favoriteAppsIds.remove(app.packageName)
        : _favoriteAppsIds.add(app.packageName);

    updateFavoriteAppsList();
    BoxHelper.instance.saveFavorites(_favoriteAppsIds.toList());
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

  void updateFavoriteAppsList() {
    _favoriteAppsList =
        _allAppslist
            .where((app) => _favoriteAppsIds.contains(app.packageName))
            .toList();
  }

  ({
    List<Application> appList,
    bool fetchingData,
    String title,
    bool searchEnabled,
    List<Application> searchResultList,
    String searchTerm,
  })
  getData(BuildContext context, int currentIndex) {
    late final List<Application> appList;
    late final String title;

    switch (currentIndex) {
      case 0:
        appList = _installedAppsList;
        title = 'Installed Apps';
        break;
      case 1:
        appList = _systemAppsList;
        title = 'System Apps';
        break;
      case 2:
        appList = _favoriteAppsList;
        title = 'Favorite Apps';
        break;
    }

    return (
      appList: appList,
      fetchingData: context.select<ApplistProvider, bool>(
        (p) => p.fetchingData,
      ),
      title: title,
      searchEnabled: _searchEnabled,
      searchResultList: _searchResultList,
      searchTerm: _searchTerm,
    );
  }

  void toggleSearch({bool? enable}) {
    _searchEnabled = enable ?? !_searchEnabled;

    if (!_searchEnabled) {
      _searchTerm = '';
      _searchResultList.clear();
    }
    notifyListeners();
  }

  void updateSearchResult(String query, List<Application> currentList) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      _searchTerm = query.trim().toLowerCase();
      _searchResultList =
          currentList
              .where((app) => app.appName.toLowerCase().contains(_searchTerm))
              .toList();
      notifyListeners();
    });
  }

  // private methods
  Future<void> _getAppsList() async {
    _fetchingData = true;
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
    updateFavoriteAppsList();

    _fetchingData = false;
    notifyListeners();
  }
}
