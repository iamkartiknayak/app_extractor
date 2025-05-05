import 'dart:async';
import 'dart:typed_data';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/box_helper.dart';
import '../../../helpers/snackbar_helper.dart';
import '../../../settings/application/settings_provider.dart';
import '../../appinfo/application/app_info_provider.dart';

class ApplistProvider extends ChangeNotifier {
  // public var (getters)
  String get currentTitle => _currentTitle;
  bool get fetchingData => _fetchingData;
  bool get searchEnabled => _searchEnabled;
  bool get noSearchData => _noSearchData;
  bool get longPress => _longPress;
  int get currentIndex => _currentIndex;

  List<Application> get currentAppList => _currentAppList;
  List<int> get selectedItemIndexList => _selectedItemIndexList;
  Map<String, Uint8List> get iconCache => _iconCache;

  // private var
  bool _isInitialized = false;
  late final BuildContext _context;
  String _currentTitle = '';
  bool _fetchingData = false;
  bool _searchEnabled = false;
  bool _noSearchData = false;
  bool _longPress = true;
  int _currentIndex = 0;

  List<Application> _allAppslist = [];
  List<Application> _installedAppsList = [];
  List<Application> _systemAppsList = [];
  List<Application> _runnableSystemAppsList = [];
  List<Application> _allSystemAppsList = [];
  List<Application> _favoriteAppsList = [];
  List<Application> _currentAppList = [];
  final List<int> _selectedItemIndexList = [];
  late final Map<String, Uint8List> _iconCache;
  late final List<String> _favoriteAppsIds;
  Timer? _searchdebounce;

  // public methods
  Future<void> init(BuildContext context) async {
    if (_isInitialized) {
      return;
    }

    _context = context;
    _favoriteAppsIds = BoxHelper.instance.getFavoriteAppsIdList();
    _iconCache = BoxHelper.instance.getIconCache();
    _getAppsList();
    _isInitialized = true;
  }

  @override
  void dispose() {
    _searchdebounce?.cancel();
    super.dispose();
  }

  void toggleFavorite(Application app) {
    _favoriteAppsIds.contains(app.packageName)
        ? _favoriteAppsIds.remove(app.packageName)
        : _favoriteAppsIds.add(app.packageName);

    BoxHelper.instance.saveFavorites(_favoriteAppsIds.toList());
    _updateFavoriteAppsList();
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

  void setData(BuildContext context, int currentIndex) {
    _currentIndex = currentIndex;
    _longPress = false;
    _selectedItemIndexList.clear();

    switch (currentIndex) {
      case 0:
        _currentAppList = context.select<ApplistProvider, List<Application>>(
          (p) => p._installedAppsList,
        );
        _currentTitle = 'Installed Apps';
        break;
      case 1:
        _currentAppList = context.select<ApplistProvider, List<Application>>(
          (p) => p._systemAppsList,
        );
        _currentTitle = 'System Apps';
        break;
      case 2:
        _currentAppList = context.select<ApplistProvider, List<Application>>(
          (p) => p._favoriteAppsList,
        );
        _currentTitle = 'Favorite Apps';
        break;
    }
  }

  void toggleSearch({bool? enable}) {
    _searchEnabled = enable ?? !_searchEnabled;

    if (!_searchEnabled) {
      _currentAppList = _getCurrentAppList(_currentIndex);
      _noSearchData = false;
    }
    notifyListeners();
  }

  void updateSearchResult(String query) {
    if (_searchdebounce?.isActive ?? false) {
      _searchdebounce!.cancel();
    }
    final searchList = _getCurrentAppList(_currentIndex);

    _searchdebounce = Timer(const Duration(milliseconds: 400), () {
      query = query.trim().toLowerCase();
      _currentAppList =
          searchList
              .where((app) => app.appName.toLowerCase().contains(query))
              .toList();

      _noSearchData = _currentAppList.isEmpty && query.isNotEmpty;
      notifyListeners();
    });
  }

  void updateSelectedItemIndexList(int index) {
    if (!longPress) {
      _longPress = true;
    }

    _selectedItemIndexList.contains(index)
        ? _selectedItemIndexList.remove(index)
        : _selectedItemIndexList.add(index);

    if (_selectedItemIndexList.isEmpty) {
      _longPress = false;
    }
    notifyListeners();
  }

  Future<void> batchAppExtract(BuildContext context) async {
    for (final itemIndex in _selectedItemIndexList) {
      debugPrint('Extracting item $itemIndex');
      await context.read<AppInfoProvider>().extractApk(
        context: context,
        app: _getCurrentAppList(_currentIndex)[itemIndex],
        showSnackBar: _selectedItemIndexList.length == 1,
      );
    }

    if (context.mounted && _selectedItemIndexList.length > 1) {
      SnackbarHelper.showSnackbar(
        context: context,
        extractedPath: '',
        appName: '',
        successMessage: 'All selected apps have been extracted successfully',
        errorMessage: 'Failed to extract all APKs',
        duration: const Duration(milliseconds: 2500),
      );
    }

    resetSelection();
  }

  void resetSelection() {
    _selectedItemIndexList.clear();
    _longPress = false;
    notifyListeners();
  }

  Future<void> batchAppDelete(BuildContext context) async {
    final sortedIndices = [..._selectedItemIndexList]..sort((a, b) => b - a);
    for (final itemIndex in sortedIndices) {
      await context.read<AppInfoProvider>().deleteExtractedApp(
        itemIndex: itemIndex,
        showSnackbar: _selectedItemIndexList.length == 1,
      );
    }

    if (context.mounted && _selectedItemIndexList.length > 1) {
      SnackbarHelper.showSnackbar(
        context: context,
        extractedPath: '',
        appName: '',
        successMessage: 'All selected apps have been deleted successfully',
        errorMessage: 'Failed to delete all APKs',
        duration: const Duration(milliseconds: 2500),
      );
    }
    resetSelection();
  }

  Future<void> refreshList() async {
    _fetchAppsData(
      assignList: (updatedList) => _installedAppsList = updatedList,
      includeSystemApps: false,
    );
    _updateFavoriteAppsList();
  }

  Future<void> updateSystemAppsList(bool hideBackgroundApps) async {
    if (_runnableSystemAppsList.isEmpty || _allSystemAppsList.isEmpty) {
      _fetchAppsData(
        assignList: (updatedList) => _systemAppsList = updatedList,
        includeSystemApps: true,
      );
      return;
    }

    _systemAppsList =
        hideBackgroundApps ? _runnableSystemAppsList : _allSystemAppsList;
    notifyListeners();
  }

  // private methods
  Future<void> _getAppsList() async {
    _fetchingData = true;
    _fetchAppsData(
      assignList: (updatedList) => _installedAppsList = updatedList,
      includeSystemApps: false,
    );
    _fetchAppsData(
      assignList: (updatedList) => _systemAppsList = updatedList,
      includeSystemApps: true,
    );

    _allAppslist = await DeviceApps.getInstalledApplications(
      includeAppIcons: false,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: false,
    );

    _allAppslist.sort(
      (a, b) => a.appName.toUpperCase().compareTo(b.appName.toUpperCase()),
    );

    _updateFavoriteAppsList();
    notifyListeners();
  }

  void _updateFavoriteAppsList() {
    _favoriteAppsList =
        _allAppslist
            .where((app) => _favoriteAppsIds.contains(app.packageName))
            .toList();
  }

  List<Application> _getCurrentAppList(int index) {
    switch (index) {
      case 0:
        return _installedAppsList;
      case 1:
        return _systemAppsList;
      case 2:
        return _favoriteAppsList;
      default:
        return _installedAppsList;
    }
  }

  Future<void> _fetchAppsData({
    required bool includeSystemApps,
    required void Function(List<Application>) assignList,
  }) async {
    final hideBackgroundApps =
        !_context.read<SettingsProvider>().showNonLaunchable;

    Future.microtask(() async {
      final appsWithIcons = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: includeSystemApps,
        onlyAppsWithLaunchIntent: hideBackgroundApps,
      );
      for (final app in appsWithIcons) {
        if (_iconCache.containsKey(app.packageName)) {
          continue;
        }
        _iconCache[app.packageName] = (app as ApplicationWithIcon).icon;
      }
      _fetchingData = false;
      BoxHelper.instance.saveIconCache(_iconCache);
      notifyListeners();
    });

    final apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: false,
      includeSystemApps: includeSystemApps,
      onlyAppsWithLaunchIntent: hideBackgroundApps,
    );

    apps.sort(
      (a, b) => a.appName.toUpperCase().compareTo(b.appName.toUpperCase()),
    );

    if (includeSystemApps) {
      apps.retainWhere((app) => app.systemApp);
    }

    if (includeSystemApps) {
      if (_runnableSystemAppsList.isEmpty && hideBackgroundApps) {
        _runnableSystemAppsList = apps;
      } else if (_allSystemAppsList.isEmpty && !hideBackgroundApps) {
        _allSystemAppsList = apps;
      }
    }

    if (_iconCache.isNotEmpty) {
      _fetchingData = false;
    }

    assignList(apps);
    notifyListeners();
  }
}
