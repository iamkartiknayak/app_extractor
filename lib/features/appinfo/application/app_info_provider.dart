import 'dart:io';

import 'package:app_install_events/app_install_events.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helpers/box_helper.dart';
import '../data/models/extracted_app_model.dart';
import '../../../helpers/play_store_helper.dart';
import '../data/models/cached_app_info_model.dart';
import '../../../helpers/app_operations_helper.dart';
import '../../../helpers/snackbar_helper.dart';
import '../../applist/application/applist_provider.dart';

class AppInfoProvider extends ChangeNotifier {
  // public var (getters)
  String? get selectedAppId => _selectedAppId;
  Map<String, CachedAppInfoModel> get cachedAppInfoMap => _cachedAppInfoMap;
  String get apkSize => _apkSize;
  String get techStack => _techStack;
  bool get isAvailableOnPlayStore => _isAvailableOnPlayStore;
  List<ExtractedAppModel> get extractedAppsList => _extractedAppsList;
  bool get hasExtractedApp => _hasExtractedApp;
  String get extractedAppPath => _extractedAppPath;

  // private var
  String? _selectedAppId;
  bool _isInitialized = false;
  late BuildContext _context;
  late AppIUEvents _appIUEvents;
  final Map<String, CachedAppInfoModel> _cachedAppInfoMap = {};

  String _apkSize = 'Calculating...';
  String _techStack = 'Parsing...';
  bool _isAvailableOnPlayStore = false;
  bool _isCalculating = false;
  bool _hasExtractedApp = false;
  String _extractedAppPath = '';

  late final List<ExtractedAppModel> _extractedAppsList;

  // public methods
  void init(BuildContext context) {
    if (_isInitialized) return;

    _context = context;
    _isInitialized = true;
    _extractedAppsList = BoxHelper.instance.getExtractedAppsList();
    _appIUEvents = AppIUEvents();
    _appIUEvents.appEvents.listen((event) async {
      if (event.type == IUEventType.uninstalled) {
        if (!context.mounted) return;

        _context.read<ApplistProvider>().removeApp(event.packageName);
        if (_selectedAppId == event.packageName) {
          Navigator.of(_context).pop();
        }
      }
    });
  }

  @override
  void dispose() {
    _appIUEvents.dispose();
    super.dispose();
  }

  void calculateAppInfoValues(Application app) {
    _resetValues();
    updateExtractedAppStatus(app);
    if (_cachedAppInfoMap.containsKey(app.packageName)) {
      Future.microtask(() => _setCachedValues(app));
      return;
    }

    _isCalculating = true;
    Future.wait([
      _getApkSize(app),
      _getTechStack(app),
      _getPlayStoreAvailability(app.packageName),
    ]).then((_) {
      if (!_isCalculating) return;
      _cacheAppInfo(app);
      notifyListeners();
    });
  }

  Future<void> extractApk(BuildContext context, Application app) async {
    late final String appSize;
    late final String? extractedPath;

    final result = await Future.wait([
      AppOperationsHelper.getAppSize(app.apkFilePath),
      AppOperationsHelper.extractApk(app),
    ]);

    appSize = result[0]!;
    extractedPath = result[1];

    if (extractedPath == null) return;

    if (context.mounted) {
      SnackbarHelper.showDoneExtractionSnackbar(
        context,
        extractedPath,
        app.appName,
      );
    }

    _extractedAppsList.add(
      ExtractedAppModel(
        appIcon: (app as ApplicationWithIcon).icon,
        appName: app.appName,
        packageName: app.packageName,
        appSize: appSize,
        appPath: extractedPath,
      ),
    );
    BoxHelper.instance.saveExtractedApps(_extractedAppsList);
    updateExtractedAppStatus(app);
    notifyListeners();
  }

  void setSelectedAppId(String? appId) {
    _selectedAppId = appId;
    notifyListeners();
  }

  void updateExtractedAppStatus(Application app) {
    _hasExtractedApp = false;
    _extractedAppPath = '';

    for (final exApp in _extractedAppsList) {
      if (exApp.packageName == app.packageName) {
        _hasExtractedApp = true;
        _extractedAppPath = exApp.appPath;
        return;
      }
    }
  }

  void shareExtractedApp(String extractedAppPath) {
    final file = File(extractedAppPath);
    SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
  }

  // private methods
  Future<void> _getPlayStoreAvailability(String appId) async {
    _isAvailableOnPlayStore = await PlayStoreHelper.isAppAvailable(appId);
  }

  Future<void> _getApkSize(Application app) async {
    _apkSize = await AppOperationsHelper.getAppSize(app.apkFilePath);
  }

  Future<void> _getTechStack(Application app) async {
    final result = await AppOperationsHelper.detectTechStack(app.apkFilePath);
    _techStack = result['framework']!;
  }

  void _cacheAppInfo(Application app) {
    if (_cachedAppInfoMap.containsKey(app.packageName)) return;

    _cachedAppInfoMap[app.packageName] = CachedAppInfoModel(
      appSize: _apkSize,
      isAvailableOnPlayStore: _isAvailableOnPlayStore,
      techStack: _techStack,
    );
  }

  void _resetValues() {
    _apkSize = 'Calulating...';
    _techStack = 'Parsing...';
    _isAvailableOnPlayStore = false;
    _isCalculating = false;
  }

  void _setCachedValues(Application app) {
    _apkSize = _cachedAppInfoMap[app.packageName]!.appSize;
    _techStack = _cachedAppInfoMap[app.packageName]!.techStack;
    _isAvailableOnPlayStore =
        _cachedAppInfoMap[app.packageName]!.isAvailableOnPlayStore;
    notifyListeners();
  }
}
