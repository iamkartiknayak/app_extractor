import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../helpers/box_helper.dart';

class SettingsProvider extends ChangeNotifier {
  // public var (getters)
  bool get gridView => _gridView;
  String get defaultApkName => _defaultApkName;

  // private var
  bool _gridView = false;
  String _defaultApkName = 'name_version.apk';
  late final Box<dynamic> _settingsBox;

  // private Box reference
  SettingsProvider() {
    _settingsBox = BoxHelper.instance.appBox;
    _gridView = _settingsBox.get('gridView', defaultValue: false);
    _defaultApkName = _settingsBox.get(
      'defaultApkName',
      defaultValue: 'name_version.apk',
    );
    notifyListeners();
  }

  void toggleGridView() {
    _gridView = !_gridView;
    _settingsBox.put('gridView', _gridView);
    notifyListeners();
  }

  void setApkName(String? value) {
    _defaultApkName = value ?? 'name_version.apk';
    _settingsBox.put('defaultApkName', _defaultApkName);
    notifyListeners();
  }
}
