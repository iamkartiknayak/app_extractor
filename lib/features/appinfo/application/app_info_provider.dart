import 'package:app_install_events/app_install_events.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/app_operations_helper.dart';
import '../../../helpers/snackbar_helper.dart';
import '../../applist/application/applist_provider.dart';

class AppInfoProvider extends ChangeNotifier {
  // public var (getters)
  String? get selectedAppId => _selectedAppId;
  String get apkSize => _apkSize;
  String get techStack => _techStack;

  // private var
  String? _selectedAppId;
  bool _isInitialized = false;
  String _apkSize = 'Calculating...';
  String _techStack = 'Parsing...';
  late BuildContext _context;
  late AppIUEvents _appIUEvents;

  // public methods
  void init(BuildContext context) {
    if (_isInitialized) return;

    _context = context;
    _appIUEvents = AppIUEvents();
    _appIUEvents.appEvents.listen((event) async {
      if (event.type == IUEventType.uninstalled) {
        debugPrint("App has been uninstalled => ${event.packageName}");

        if (!context.mounted) return;

        debugPrint('Before');
        _context.read<ApplistProvider>().removeApp(event.packageName);
        debugPrint('Done');
        if (_selectedAppId == event.packageName) {
          Navigator.of(_context).pop();
        }
      }
    });

    _isInitialized = true;
  }

  void calculateAppInfoValues(Application app) async {
    await _getApkSize(app);
    await _getTechStack(app);
    notifyListeners();
  }

  void extractApk(BuildContext context, Application app) async {
    final extractedPath = await AppOperationsHelper.extractApk(app);
    if (context.mounted) {
      SnackbarHelper.showDoneExtractionSnackbar(context, extractedPath);
    }
  }

  void setSelectedAppId(String? appId) {
    _selectedAppId = appId;
    notifyListeners();
  }

  void resetValues() async {
    await Future.delayed(Duration(seconds: 1));
    _apkSize = 'Calulating...';
    _techStack = 'Parsing...';
  }

  // private methods
  Future<void> _getApkSize(Application app) async {
    _apkSize = await AppOperationsHelper.getAppSize(app.apkFilePath);
  }

  Future<void> _getTechStack(Application app) async {
    final result = await AppOperationsHelper.detectTechStack(app.apkFilePath);
    _techStack = result['framework']!;
  }
}
