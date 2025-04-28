import 'package:app_install_events/app_install_events.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/app_extract_helper.dart';
import '../../../helpers/snackbar_helper.dart';
import '../../applist/application/applist_provider.dart';

class AppInfoProvider extends ChangeNotifier {
  // public var (getters)
  String? get selectedAppId => _selectedAppId;

  // private var
  String? _selectedAppId;
  bool _isInitialized = false;
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

  void extractApk(BuildContext context, Application app) async {
    final extractedPath = await AppExtractHelper.extractApk(app);
    if (context.mounted) {
      SnackbarHelper.showDoneExtractionSnackbar(context, extractedPath);
    }
  }

  void setSelectedAppId(String? appId) {
    _selectedAppId = appId;
    notifyListeners();
  }
}
