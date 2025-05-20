import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsModel>(
  () => SettingsNotifier(),
);

class SettingsModel {
  const SettingsModel({required this.defaultApkName});

  final String defaultApkName;

  SettingsModel copyWith({
    final bool? gridView,
    final bool? showNonLaunchable,
    final String? defaultApkName,
  }) => SettingsModel(defaultApkName: defaultApkName ?? this.defaultApkName);
}

class SettingsNotifier extends Notifier<SettingsModel> {
  @override
  SettingsModel build() {
    final defaultApkName = 'name_version.apk';

    return SettingsModel(defaultApkName: defaultApkName);
  }

  void setApkName(final String? value) {
    final name = value ?? 'name_version.apk';
    state = state.copyWith(defaultApkName: name);
  }
}
