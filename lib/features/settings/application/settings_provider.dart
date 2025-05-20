import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  @override
  SettingsModel build() {
    final defaultApkName = 'name_version.apk';

    return SettingsModel(
      showNonLaunchable: false,
      defaultApkName: defaultApkName,
      gridView: false,
    );
  }

  void setApkName(final String? value) {
    final name = value ?? 'name_version.apk';
    state = state.copyWith(defaultApkName: name);
  }

  void toggleNonLaunchable(final bool value, final WidgetRef ref) {
    state = state.copyWith(showNonLaunchable: value);
  }

  void toggleGridView() {
    final updated = !state.gridView;
    state = state.copyWith(gridView: updated);
  }
}
