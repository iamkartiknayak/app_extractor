import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../helpers/box_helper.dart';
import '../../applist/application/applist_provider.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider() {
    _settingsBox = BoxHelper.instance.settingsBox;
    _gridView = _settingsBox.get('gridView', defaultValue: false);
    _defaultApkName = _settingsBox.get(
      'defaultApkName',
      defaultValue: 'name_version.apk',
    );

    notifyListeners();
  }

  // public var (getters)
  bool get gridView => _gridView;
  String get defaultApkName => _defaultApkName;
  bool get showNonLaunchable => _showNonLaunchable;

  // private var
  bool _gridView = false;
  bool _showNonLaunchable = false;
  String _defaultApkName = 'name_version.apk';
  late final Box<dynamic> _settingsBox;

  void toggleGridView() {
    _gridView = !_gridView;
    _settingsBox.put('gridView', _gridView);
    notifyListeners();
  }

  void toggleNonLaunchable(bool value, BuildContext context) {
    _showNonLaunchable = value;
    context.read<ApplistProvider>().updateSystemAppsList(!value);
    notifyListeners();
  }

  void setApkName(String? value) {
    _defaultApkName = value ?? 'name_version.apk';
    _settingsBox.put('defaultApkName', _defaultApkName);
    notifyListeners();
  }
}
