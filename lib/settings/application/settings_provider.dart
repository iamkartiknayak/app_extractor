import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  // public var (getters)
  bool get gridView => _gridView;
  String get defaultApkName => _defaultApkName;

  // private var
  bool _gridView = false;
  String _defaultApkName = 'name_version.apk';

  void toggleGridView() {
    _gridView = !_gridView;
    notifyListeners();
  }

  void setApkName(String? value) {
    _defaultApkName = value ?? 'name_version.apk';
    notifyListeners();
  }
}
