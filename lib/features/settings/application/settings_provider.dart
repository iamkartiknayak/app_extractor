import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/helpers/box_helper.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsModel>(
  () => SettingsNotifier(),
);

class SettingsModel {
  const SettingsModel({
    required this.showNonLaunchable,
    required this.defaultApkName,
    required this.gridView,
  });

  final bool showNonLaunchable;
  final String defaultApkName;
  final bool gridView;

  SettingsModel copyWith({
    final bool? showNonLaunchable,
    final String? defaultApkName,
    final bool? gridView,
  }) => SettingsModel(
    showNonLaunchable: showNonLaunchable ?? this.showNonLaunchable,
    defaultApkName: defaultApkName ?? this.defaultApkName,
    gridView: gridView ?? this.gridView,
  );
}

class SettingsNotifier extends Notifier<SettingsModel> {
  late final Box<dynamic> _settingsBox;

  @override
  SettingsModel build() {
    _settingsBox = BoxHelper.instance.settingsBox;

    final gridView = _settingsBox.get('gridView', defaultValue: false) as bool;
    final defaultApkName = _settingsBox.get(
      'defaultApkName',
      defaultValue: 'name_version.apk',
    );

    return SettingsModel(
      showNonLaunchable: false,
      defaultApkName: defaultApkName,
      gridView: gridView,
    );
  }

  void setApkName(final String? value) {
    final name = value ?? 'name_version.apk';
    state = state.copyWith(defaultApkName: name);
    _settingsBox.put('defaultApkName', name);
  }

  void toggleNonLaunchable(final bool value, final WidgetRef ref) {
    state = state.copyWith(showNonLaunchable: value);
  }

  void toggleGridView() {
    final updated = !state.gridView;
    state = state.copyWith(gridView: updated);
    _settingsBox.put('gridView', updated);
  }
}
